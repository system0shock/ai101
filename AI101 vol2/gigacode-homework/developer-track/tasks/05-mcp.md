# 05. MCP

Цель: подключить готовый MCP-сервер и получить через него read-only ответ.

> Лучше делать **после** задания 02 — MCP-сервер содержит формулировку правила
> скидки и может стать спойлером для самостоятельной диагностики бага.

## Что готово

- `shared/mcp/local_knowledge_server.py` — локальный stdio MCP-сервер без зависимостей.
- `shared/mcp/local-stdio-server.config.example.json` — пример блока `mcpServers`.
- `shared/mcp/smoke_test_local_server.py` — проверка, что сервер стартует и отвечает.
- Read-only tools: `get_discount_policy`, `search_credit_policy`.

## Документация

- Official Qwen Code MCP: https://qwenlm.github.io/qwen-code-docs/en/users/features/mcp/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/mcp-subagents.md`
- README сервера: `../../shared/mcp/README.md`

## A. Попробовать готовое

1. Из корня `gigacode-homework/` проверьте сервер:

   ```bash
   python3 shared/mcp/smoke_test_local_server.py
   ```

   Ожидается: `Local MCP stdio smoke test passed.`

2. Откройте `shared/mcp/local-stdio-server.config.example.json` и скопируйте
   блок `mcpServers.ai101Local` в локальный settings-файл вашей GigaCode/Qwen Code среды.

3. Перезапустите GigaCode CLI в корне `gigacode-homework/`.

4. Выполните `/mcp` — должен появиться сервер `ai101Local` с tools.

5. Промпт:

   ```
   Через MCP ai101Local вызови get_discount_policy для bulk-discount
   и верни правило скидки и источник.
   ```

Пример хорошего ответа:

```
Bulk discount policy: 10% discount starts from 10 items inclusive.
Source: AI101 local policy fixture. Updated: 2026-05-28.
```

Критерий: `/mcp` показывает `ai101Local`, агент возвращает цитату из MCP,
а не пересказ из кода `DiscountPolicy.java`.

## B. Минимальная правка

Сузьте `includeTools`, чтобы разработчику не предлагался analyst-tool.

В вашем settings оставьте только один tool:

```json
"includeTools": ["get_discount_policy"]
```

Перезапустите CLI, выполните `/mcp`. У сервера `ai101Local` должен остаться один tool.

Критерий: `search_credit_policy` больше не виден в `/mcp`; запрос из блока A работает.

## Подсказка

Собственный MCP-сервер писать не нужно — он уже есть. Если сервер не стартует,
проверьте, что команда `python3 shared/mcp/local_knowledge_server.py` запускается
из корня `gigacode-homework/` и что в конфиге `cwd` указывает туда же.
