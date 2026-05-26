# 05. MCP для разработчика

## Цель

Разобрать MCP только для чтения как внешний источник фактов проекта.

## Шаги

1. Откройте `shared/mcp/README.md`.
2. Откройте `shared/mcp/local-knowledge-server.example.json`.
3. Попросите агента объяснить, какие Tools доступны и какие заблокированы.

## Запрос

```text
@shared/mcp/README.md
@shared/mcp/local-knowledge-server.example.json
Объясни, какие MCP Tools доступны агенту и почему write_note недоступен.
```

## Самопроверка

- Агент упомянул приоритет `excludeTools`.
- Агент не предлагает подключать внешний сервис.
