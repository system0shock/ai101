# 05. MCP

Цель: спроектировать read-only источник знаний.

## Конкретная цель
<!-- concrete-goal -->

Спроектировать MCP tool `mcp__knowledge__search_credit_policy`, который ищет актуальную внутреннюю кредитную политику и возвращает цитату, источник и дату обновления без возможности менять документы.

## Документация
<!-- docs-links -->

- Official Qwen Code MCP: https://qwenlm.github.io/qwen-code-docs/en/users/features/mcp/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/mcp-subagents.md`

## Базовое задание

Попросите агента объяснить `shared/mcp/local-knowledge-server.example.json` с точки зрения аналитика.

## Самостоятельно

Спроектируйте MCP tool `mcp__knowledge__search_credit_policy`: параметры поиска, read-only гарантия, пример ответа и exclude для write-tools.

## Подсказка для самостоятельной части
<!-- self-hint -->

Параметры могут быть такими: `{ "query": "online credit approval policy", "clientSegment": "salary" }`. Ответ должен содержать `quote`, `source`, `updatedAt`. Успех: по описанию ясно, как агент проверит спор "одобряют ли клиентов без зарплатного счёта", не получая write-доступа.
