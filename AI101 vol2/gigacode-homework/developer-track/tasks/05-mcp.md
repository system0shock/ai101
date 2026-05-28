# 05. MCP

Цель: подключить готовый локальный stdio MCP server и получить ответ через MCP tool.

## Конкретная цель
<!-- concrete-goal -->

Подключить сервер `ai101Local` из `shared/mcp/local_knowledge_server.py`, вызвать tool `get_discount_policy` и получить ответ: `10% discount starts from 10 items inclusive`.

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
   Через MCP ai101Local вызови get_discount_policy для bulk-discount и верни только правило скидки и источник.
   ```

## Самостоятельно

Настройте подключение так, чтобы через `includeTools` были доступны только:

- `get_discount_policy`
- `search_credit_policy`

Затем попросите агента объяснить, почему `trust: false` безопаснее для учебного сервера.

## Подсказка для самостоятельной части
<!-- self-hint -->

Сервер писать не нужно. Он уже есть. Ваша работа — подключить stdio process через `command`, `args`, `cwd`, проверить `/mcp` и получить простой read-only ответ. Если сервер не стартует, сначала проверьте, что команда `python3 shared/mcp/local_knowledge_server.py` запускается из корня `gigacode-homework/`.
