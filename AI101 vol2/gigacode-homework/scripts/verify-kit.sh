#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

test -f "$ROOT/README.md"
test -f "$ROOT/GIGACODE.md"
test -f "$ROOT/.gigacode/settings.example.json"
test -f "$ROOT/.gigacode/hooks/protect_sources.py"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/SKILL.md"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/references/source-index.md"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/references/commands-tools.md"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/references/skills-hooks.md"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/references/mcp-subagents.md"
test -f "$ROOT/shared/qwen-code-docs/README.md"

for file in "$ROOT"/developer-track/tasks/*.md "$ROOT"/analyst-track/tasks/*.md; do
  grep -q "Самостоятельно" "$file"
done

grep -q "Параллельное упражнение" "$ROOT/developer-track/tasks/06-subagents.md"
grep -q "Параллельное упражнение" "$ROOT/analyst-track/tasks/06-subagents.md"
grep -q "matcher casing" "$ROOT/.gigacode/skills/qwen-code-helper/SKILL.md"

echo "Homework kit verification passed."
