# MCP exercise reference

В этом комплекте MCP не требует внешних credentials.

Что нужно понять:

- MCP server добавляет внешние tools и sources.
- `includeTools` открывает только выбранные tools.
- `excludeTools` имеет приоритет над `includeTools`.
- Permissions могут блокировать `mcp__server__tool_name` или весь `mcp__server`.
- `/mcp auth` используется для OAuth, если remote MCP требует авторизацию.
- Default timeout для MCP server: `600000` ms.

В заданиях MCP используется как read-only концепция, чтобы не расширять blast radius.
