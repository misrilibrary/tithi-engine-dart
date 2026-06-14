#!/usr/bin/env bash
# Fast-fail preflight — run before pushing or publishing.
# Mirrors CI but runs the cheapest, easiest-to-forget check (format) FIRST.
#
#   bash tools/preflight.sh
#
set -euo pipefail
cd "$(dirname "$0")/.."

echo "==> dart pub get"
dart pub get >/dev/null

echo "==> dart format (check only)"
if ! dart format --output=none --set-exit-if-changed . ; then
  echo "✗ Unformatted files above. Fix with:  dart format ." >&2
  exit 1
fi

echo "==> dart analyze (--fatal-infos)"
dart analyze --fatal-infos

echo "==> dart test"
dart test

echo "==> dart pub publish --dry-run"
dart pub publish --dry-run

echo "✓ preflight passed — safe to push/publish"
