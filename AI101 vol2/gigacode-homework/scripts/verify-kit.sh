#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

test -f "$ROOT/README.md"
test -f "$ROOT/GIGACODE.md"
test -f "$ROOT/.gigacode/settings.example.json"
test -f "$ROOT/.gigacode/hooks/protect_sources.py"

for file in "$ROOT"/developer-track/tasks/*.md "$ROOT"/analyst-track/tasks/*.md; do
  grep -q "Самостоятельно" "$file"
done

grep -q "Параллельное упражнение" "$ROOT/developer-track/tasks/06-subagents.md"
grep -q "Параллельное упражнение" "$ROOT/analyst-track/tasks/06-subagents.md"

echo "Homework kit verification passed."

