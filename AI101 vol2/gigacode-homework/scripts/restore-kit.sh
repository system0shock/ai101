#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
SNAPSHOT="$ROOT/shared/restore/snapshot"

if [ ! -d "$SNAPSHOT" ]; then
  echo "Snapshot not found at $SNAPSHOT. Restore is not possible." >&2
  exit 1
fi

TARGETS="
.gigacode
analyst-track/docs
developer-track/app
"

echo "This will reset to the pristine homework state:"
for path in $TARGETS; do
  echo "  - $path"
done
echo "All your local edits to these paths will be lost."

if [ "${1-}" != "--yes" ] && [ "${1-}" != "-y" ]; then
  printf "Continue? [y/N] "
  read answer
  case "$answer" in
    y|Y) ;;
    *) echo "Aborted."; exit 1;;
  esac
fi

for path in $TARGETS; do
  rm -rf "$ROOT/$path"
  cp -R "$SNAPSHOT/$path" "$ROOT/$path"
  echo "Restored: $path"
done

echo "Restore complete. Run ./scripts/verify-kit.sh to confirm."
