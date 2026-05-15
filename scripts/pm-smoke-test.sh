#!/usr/bin/env bash
# scripts/pm-smoke-test.sh
#
# Platform smoke test runner for meowctl-stdlib PM components.
#
# Usage:
#   pm-smoke-test.sh <meowctl-bin> <stdlib-path> <component>...
#
# Each <component> must match a test-<pm> fixture component name (e.g. test-apt).
# The script:
#   1. Creates a temp config dir and copies stdlib + fixture components into it.
#   2. Runs meowctl install for all requested components in one call so that
#      dependency ordering (after=) is respected — PM components are installed
#      before the test-pkg components that depend on them.
#   3. Then for each test component individually: verify → update → uninstall.
#   4. Exits non-zero on first failure, printing which component and phase failed.
#
# Environment:
#   MEOWCTL_BIN   - path to meowctl binary (overrides $1)
#   STDLIB_PATH   - path to meowctl-stdlib checkout (overrides $2)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# --- argument / env resolution ---
# If MEOWCTL_BIN/STDLIB_PATH are not set in the environment, consume them from
# positional args $1 and $2, then shift so $@ contains only component names.
# If they are already set via env, all positional args are component names.
if [[ -z "${MEOWCTL_BIN:-}" ]]; then
  MEOWCTL_BIN="${1:-}"
  STDLIB_PATH="${2:-}"
  shift 2 2>/dev/null || true
fi
STDLIB_PATH="${STDLIB_PATH:-}"

if [[ -z "$MEOWCTL_BIN" ]]; then
  echo "error: meowctl binary path required (arg 1 or MEOWCTL_BIN env)" >&2
  exit 1
fi
if [[ -z "$STDLIB_PATH" ]]; then
  echo "error: stdlib path required (arg 2 or STDLIB_PATH env)" >&2
  exit 1
fi

# Remaining positional args are component names.
COMPONENTS=("$@")
if [[ ${#COMPONENTS[@]} -eq 0 ]]; then
  echo "usage: pm-smoke-test.sh <meowctl-bin> <stdlib-path> <component>..." >&2
  echo "  e.g. pm-smoke-test.sh ./meowctl . test-apt test-mise test-npm" >&2
  exit 1
fi

# --- set up temp config dir ---
CONFIG_DIR="$(mktemp -d)"
trap 'rm -rf "$CONFIG_DIR"' EXIT

mkdir -p "$CONFIG_DIR/components"

# Copy stdlib PM components (the sources under test).
cp "$STDLIB_PATH"/components/*.star "$CONFIG_DIR/components/"

# Copy fixture test-pkg components.
cp "$REPO_ROOT"/tests/fixtures/components/*.star "$CONFIG_DIR/components/"

# Copy fixture meowctl.star (declares component() graph).
cp "$REPO_ROOT/tests/fixtures/meowctl.star" "$CONFIG_DIR/meowctl.star"

# --- phase 1: install all components together so after= ordering is respected ---
# PM components (mise, node, ruby, etc.) are installed before the test-pkg
# components that depend on them.
echo "==> install: ${COMPONENTS[*]}"
"$MEOWCTL_BIN" --config "$CONFIG_DIR" install "${COMPONENTS[@]}"

# --- phase 2: update all components together (tests update path for all PMs) ---
echo "==> update: ${COMPONENTS[*]}"
"$MEOWCTL_BIN" --config "$CONFIG_DIR" update "${COMPONENTS[@]}"

# --- phase 3: verify + uninstall each test-pkg component individually ---
FAILED=()

run_phase() {
  local phase="$1"
  local component="$2"
  echo "  [${phase}] ${component}"
  if ! "$MEOWCTL_BIN" --config "$CONFIG_DIR" "$phase" "$component"; then
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
