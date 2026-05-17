#!/usr/bin/env bash
# scripts/pm-smoke-test.sh
#
# Platform smoke test runner for meowctl-stdlib PM components.
#
# Usage:
#   pm-smoke-test.sh <component>...
#
# Each <component> must match a test-<pm> fixture component name (e.g. test-apt).
# The script:
#   1. Creates a temp config dir, copies fixture test-pkg components and
#      init.star into it, writes a local.star declaring all test-* components,
#      and writes a deps.mod with a replace() directive pointing @stdlib//
#      to the local STDLIB_PATH checkout.
#   2. Runs meowctl apply for all requested components in one call so that
#      dependency ordering (after=) is respected — PM components are applied
#      before the test-pkg components that depend on them.
#   3. Then for each test component individually: verify → upgrade → remove.
#   4. Exits non-zero on first failure, printing which component and phase failed.
#
# Environment:
#   MEOWCTL_BIN   - path to meowctl binary (required)
#   STDLIB_PATH   - path to meowctl-stdlib checkout (required)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ -z "${MEOWCTL_BIN:-}" ]]; then
  echo "error: MEOWCTL_BIN environment variable is required" >&2
  exit 1
fi
if [[ -z "${STDLIB_PATH:-}" ]]; then
  echo "error: STDLIB_PATH environment variable is required" >&2
  exit 1
fi

# Remaining positional args are component names.
COMPONENTS=("$@")
if [[ ${#COMPONENTS[@]} -eq 0 ]]; then
  echo "usage: MEOWCTL_BIN=<bin> STDLIB_PATH=<path> pm-smoke-test.sh <component>..." >&2
  echo "  e.g. MEOWCTL_BIN=~/.local/bin/meowctl STDLIB_PATH=. pm-smoke-test.sh test-apt test-mise test-npm" >&2
  exit 1
fi

# --- set up temp config dir ---
CONFIG_DIR="$(mktemp -d)"
trap 'rm -rf "$CONFIG_DIR"' EXIT

mkdir -p "$CONFIG_DIR/components"

# Copy fixture test-pkg components (user test components only).
cp "$REPO_ROOT"/tests/fixtures/components/*.star "$CONFIG_DIR/components/"

# Copy fixture init.star (stdlib PM deps are auto-discovered at runtime via
# each test component's after= globals).
cp "$REPO_ROOT/tests/fixtures/init.star" "$CONFIG_DIR/init.star"

# Write local.star declaring all test-* components. meowctl remove requires
# components to be declared in local.star (init.star is read-only).
{
  echo "# local.star — test-* component declarations for smoke test"
  for component in "${COMPONENTS[@]}"; do
    [[ "$component" != test-* ]] && continue
    echo "component(name = \"$component\")"
  done
} > "$CONFIG_DIR/local.star"

# Write deps.mod with a replace() directive so @stdlib// resolves to the
# local STDLIB_PATH checkout instead of the registry.
cat > "$CONFIG_DIR/deps.mod" <<EOF
module(name = "test-fixtures", version = "0.0.0")

replace(module = "stdlib", path = "$STDLIB_PATH")
EOF

# --- phase 1: apply all components together so after= ordering is respected ---
echo "==> apply: ${COMPONENTS[*]}"
"$MEOWCTL_BIN" --config "$CONFIG_DIR" apply --verbose "${COMPONENTS[@]}"

# --- phase 2: upgrade all components together (tests upgrade path for all PMs) ---
echo "==> upgrade: ${COMPONENTS[*]}"
"$MEOWCTL_BIN" --config "$CONFIG_DIR" upgrade --verbose "${COMPONENTS[@]}"

# --- phase 3: verify + remove each test-pkg component individually ---
FAILED=()

run_phase() {
  local phase="$1"
  local component="$2"
  echo "  [${phase}] ${component}"
  if ! "$MEOWCTL_BIN" --config "$CONFIG_DIR" "$phase" --verbose "$component"; then
    echo "FAIL: ${component} / ${phase}" >&2
    return 1
  fi
}

for component in "${COMPONENTS[@]}"; do
  # Only verify/remove test-pkg components; PM bootstrap components are
  # intentionally left installed (other components depend on them).
  [[ "$component" != test-* ]] && continue
  echo "==> smoke: ${component}"
  if run_phase verify  "$component" \
  && run_phase remove  "$component"; then
    echo "  OK"
  else
    FAILED+=("$component")
  fi
done

if [[ ${#FAILED[@]} -gt 0 ]]; then
  echo ""
  echo "FAILED components: ${FAILED[*]}" >&2
  exit 1
fi

echo ""
echo "All components passed."
