# GigaCode project rules

- Сначала показывай evidence: файлы, строки, команды.
- Не редактируй файлы без короткого плана.
- Не используй fork-субагентов.
- Для субагентов используй только `Task(subagent_type="...")`.
- Не меняй `tasks/` и `expected/`, если пользователь явно не просит править домашку.
- Если пользователь спрашивает про Qwen Code/GigaCode commands, tools, skills, hooks, MCP или subagents, используй skill `qwen-code-helper`.
