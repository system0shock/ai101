#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

test -f "$ROOT/README.md"
test -f "$ROOT/GIGACODE.md"
test -f "$ROOT/.gigacode/settings.json"
test -f "$ROOT/.gigacode/settings.example.json"
test -f "$ROOT/.gigacode/hooks/protect_sources.py"
test -f "$ROOT/.gigacode/hooks/smoke_test_protect_sources.py"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/SKILL.md"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/references/source-index.md"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/references/commands-tools.md"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/references/skills-hooks.md"
test -f "$ROOT/.gigacode/skills/qwen-code-helper/references/mcp-subagents.md"
test -f "$ROOT/shared/qwen-code-docs/README.md"
test -f "$ROOT/shared/mcp/local_knowledge_server.py"
test -f "$ROOT/shared/mcp/smoke_test_local_server.py"
test -f "$ROOT/shared/mcp/local-stdio-server.config.example.json"
test -f "$ROOT/developer-track/pom.xml"

for file in "$ROOT"/developer-track/tasks/*.md "$ROOT"/analyst-track/tasks/*.md; do
  grep -q "^## A\." "$file"
  grep -q "^## B\." "$file"
  grep -q "qwen-code-docs" "$file"
  grep -q "qwen-code-helper/references" "$file"
done

grep -q "subagent_type" "$ROOT/developer-track/tasks/06-subagents.md"
grep -q "subagent_type" "$ROOT/analyst-track/tasks/06-subagents.md"
grep -q "matcher casing" "$ROOT/.gigacode/skills/qwen-code-helper/SKILL.md"
grep -q '"command": "python3 .gigacode/hooks/protect_sources.py"' "$ROOT/.gigacode/settings.json"
grep -q '"command": "python3 .gigacode/hooks/protect_sources.py"' "$ROOT/.gigacode/settings.example.json"
python3 "$ROOT/shared/mcp/smoke_test_local_server.py"
python3 "$ROOT/.gigacode/hooks/smoke_test_protect_sources.py"

echo "Homework kit verification passed."
