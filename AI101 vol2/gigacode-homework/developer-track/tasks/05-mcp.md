# 05. MCP

Цель: спроектировать безопасное подключение внешнего источника.

## Конкретная цель
<!-- concrete-goal -->

Спроектировать read-only MCP tool `mcp__quality__get_discount_policy`, который возвращает правило bulk discount из внутренней базы знаний и не имеет возможности менять код или настройки.

## Документация
<!-- docs-links -->

- Official Qwen Code MCP: https://qwenlm.github.io/qwen-code-docs/en/users/features/mcp/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/mcp-subagents.md`

## Базовое задание

Откройте `shared/mcp/local-knowledge-server.example.json` и объясните read-only tools, риск `trust: true` и include/exclude фильтрацию.

## Самостоятельно

Опишите mock MCP tool `mcp__quality__get_discount_policy`: параметры, read-only режим, permissions, пример ответа и какие write-tools должны быть исключены.

## Подсказка для самостоятельной части
<!-- self-hint -->

Параметры могут быть такими: `{ "policy": "bulk-discount", "version": "current" }`. Пример ответа должен прямо сказать: "10% discount starts from 10 items inclusive". Успех: из описания понятно, что агент может только прочитать правило, но не изменить его.

