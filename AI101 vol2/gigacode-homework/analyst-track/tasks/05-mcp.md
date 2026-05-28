# 05. MCP

Цель: подключить готовый локальный stdio MCP server и получить policy quote через MCP tool.

## Конкретная цель
<!-- concrete-goal -->

Подключить сервер `ai101Local` из `shared/mcp/local_knowledge_server.py`, вызвать tool `search_credit_policy` и получить quote о том, что онлайн-кредит доступен только зарплатным клиентам с историей от 6 месяцев.

## Документация
<!-- docs-links -->

- Official Qwen Code MCP: https://qwenlm.github.io/qwen-code-docs/en/users/features/mcp/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/mcp-subagents.md`
- Готовый сервер: `../../shared/mcp/README.md`

## Базовое задание

1. Из корня `gigacode-homework/` проверьте сервер:

   ```powershell
   python3 shared/mcp/smoke_test_local_server.py
   ```

2. Откройте `shared/mcp/local-stdio-server.config.example.json`.

3. Добавьте блок `mcpServers.ai101Local` в локальный settings-файл вашей GigaCode/Qwen Code среды.

4. Перезапустите GigaCode CLI в корне `gigacode-homework/`.

5. Выполните `/mcp` и убедитесь, что сервер `ai101Local` подключен.

6. Попросите агента:

   ```text
   Через MCP ai101Local вызови search_credit_policy с query "online credit salary clients" и верни quote, source и updatedAt.
   ```

## Самостоятельно

Ограничьте сервер через `includeTools`, чтобы были доступны только read-only tools `get_discount_policy` и `search_credit_policy`. Затем попросите агента объяснить, почему в этом упражнении не нужен OAuth и почему `trust: true` не нужен.

## Подсказка для самостоятельной части
<!-- self-hint -->

Сервер писать не нужно. Он уже лежит в `shared/mcp/`. Ваша работа — подключить stdio process, увидеть tools в `/mcp` и получить простой policy quote. Если агент не видит tool, проверьте `cwd`, путь в `args` и перезапуск GigaCode CLI.
