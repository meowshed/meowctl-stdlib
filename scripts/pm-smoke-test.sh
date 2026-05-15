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
#      meowctl.star into it, and writes a meowctl.mod with a replace() directive
#      pointing @stdlib// to the local STDLIB_PATH checkout.
#   2. Runs meowctl install for all requested components in one call so that
#      dependency ordering (after=) is respected — PM components are installed
#      before the test-pkg components that depend on them.
#   3. Then for each test component individually: verify → update → uninstall.
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

# Copy fixture meowctl.star (declares test-* components; stdlib PM deps are
# auto-discovered at runtime via each test component's after= globals).
cp "$REPO_ROOT/tests/fixtures/meowctl.star" "$CONFIG_DIR/meowctl.star"

# Write meowctl.mod with a replace() directive so @stdlib// resolves to the
# local STDLIB_PATH checkout instead of the registry.
cat > "$CONFIG_DIR/meowctl.mod" <<EOF
module(name = "test-fixtures", version = "0.0.0")

replace(module = "stdlib", path = "$STDLIB_PATH")
EOF

# --- phase 1: install all components together so after= ordering is respected ---
echo "==> install: ${COMPONENTS[*]}"
"$MEOWCTL_BIN" --config "$CONFIG_DIR" install --verbose "${COMPONENTS[@]}"

# --- phase 2: update all components together (tests update path for all PMs) ---
echo "==> update: ${COMPONENTS[*]}"
"$MEOWCTL_BIN" --config "$CONFIG_DIR" update --verbose "${COMPONENTS[@]}"

# --- phase 3: verify + uninstall each test-pkg component individually ---
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
  # Only verify/uninstall test-pkg components; PM bootstrap components are
  # intentionally left installed (other components depend on them).
  [[ "$component" != test-* ]] && continue
  echo "==> smoke: ${component}"
  if run_phase verify    "$component" \
  && run_phase uninstall "$component"; then
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
