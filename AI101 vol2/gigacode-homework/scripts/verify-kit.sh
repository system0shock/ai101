#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

assert_file() {
  local path="$1"
  if [[ ! -f "$ROOT/$path" ]]; then
    echo "Не найден файл: $path" >&2
    exit 1
  fi
}

assert_contains() {
  local path="$1"
  local pattern="$2"
  local message="$3"
  if ! grep -qE "$pattern" "$ROOT/$path"; then
    echo "$message" >&2
    exit 1
  fi
}

echo "Проверка upstream path leakage"
if grep -R -n -E '\.qwen/|QWEN\.md' "$ROOT" --include='*.md'; then
  echo "Найдены upstream-пути Qwen Code в Markdown" >&2
  exit 1
fi

echo "Проверка обязательных файлов"
for path in \
  "README.md" \
  "README-quickstart.md" \
  "GIGACODE.md" \
  ".gigacode/settings.example.json" \
  ".gigacode/hooks/README.md" \
  ".gigacode/hooks/protect_sources.py" \
  "developer-track/README.md" \
  "developer-track/tasks/01-commands.md" \
  "developer-track/tasks/06-subagents.md" \
  "developer-track/expected/baseline-test-output.md" \
  "analyst-track/README.md" \
  "analyst-track/tasks/01-commands.md" \
  "analyst-track/tasks/06-subagents.md" \
  "analyst-track/expected/contradiction-report.md" \
  "shared/mcp/README.md" \
  "shared/mcp/local-knowledge-server.example.json"; do
  assert_file "$path"
done

echo "Проверка analyst expected report"
assert_contains "analyst-track/expected/contradiction-report.md" "Формат" "В contradiction-report нет темы Формат"
assert_contains "analyst-track/expected/contradiction-report.md" "Период" "В contradiction-report нет темы Период"
assert_contains "analyst-track/expected/contradiction-report.md" "Роль" "В contradiction-report нет темы Роль"
assert_contains "analyst-track/expected/contradiction-report.md" "Уведомление" "В contradiction-report нет темы Уведомление"
assert_contains "analyst-track/expected/contradiction-report.md" "Хранение" "В contradiction-report нет темы Хранение"

echo "Проверка hook и MCP справок"
assert_contains ".gigacode/hooks/README.md" "hookSpecificOutput" "Hook README не объясняет hookSpecificOutput"
assert_contains ".gigacode/hooks/README.md" "permissionDecision" "Hook README не объясняет permissionDecision"
assert_contains ".gigacode/hooks/README.md" "permissionDecisionReason" "Hook README не объясняет permissionDecisionReason"
assert_contains "shared/mcp/README.md" "includeTools" "MCP README не объясняет includeTools"
assert_contains "shared/mcp/README.md" "excludeTools" "MCP README не объясняет excludeTools"
assert_contains "shared/mcp/README.md" "/mcp auth" "MCP README не объясняет /mcp auth"
assert_contains "shared/mcp/README.md" "600000" "MCP README не объясняет timeout"

echo "Проверка завершена"
