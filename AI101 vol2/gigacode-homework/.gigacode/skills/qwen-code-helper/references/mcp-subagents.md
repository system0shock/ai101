# MCP And Subagents

## MCP

Official Qwen Code docs describe MCP as the way to connect Qwen Code to external tools and data sources through Model Context Protocol servers.

MCP servers can expose:

- repo and file tools;
- database inspection and query tools;
- internal service wrappers;
- repeatable workflow automation;
- prompts and resources.

Configuration basics:

- Qwen Code loads MCP servers from `mcpServers` in `settings.json`.
- Servers can be configured manually or with `qwen mcp`.
- Project scope is usually `.qwen/settings.json`; user scope is `~/.qwen/settings.json`.
- This homework uses `.gigacode/` paths as the local fork convention.

Transports:

- `stdio`: local process, configured with `command`, `args`, optional `cwd` and `env`.
- `http`: recommended for remote services, configured with `httpUrl`.
- `sse`: legacy/deprecated remote transport.

Safety:

- `trust: true` skips confirmations for server tools and should be treated as high blast radius.
- Prefer read-only tools for homework.
- Use tool filtering when a server has both read and write tools.

## Subagents

Official Qwen Code docs describe subagents as specialized AI assistants with focused prompts, separate context, controlled tools, and autonomous execution.

Named subagents:

- start with fresh context, not the parent history;
- use their own configured system prompt;
- block the parent until done;
- are best for specialized tasks like testing, docs, code review, or focused analysis.

Fork subagents:

- happen when the AI omits `subagent_type`;
- inherit the parent conversation context;
- run in the background while the parent continues;
- fit parallel research that needs current context.

Homework constraint:

- Fork subagents are disabled.
- Always call named subagents with `Task(subagent_type="name", prompt="...")`.
- Give each named subagent all required facts in the prompt because it starts fresh.
- Keep homework subagents read-only unless the exercise explicitly says otherwise.

Parallel named-subagent exercise:

- Run independent named subagents only when their scopes do not overlap.
- Make each prompt self-contained.
- Require evidence with `file:line`.
- Let the main agent merge results.

