---
name: qwen-code-helper
description: Explains confusing Qwen Code and GigaCode homework concepts. Use when the user asks about commands, tools, skills, hooks, matcher names, MCP, approval modes, custom commands, named subagents, fork subagents, or how to choose the right control mechanism in this homework kit.
---

# Qwen Code Helper

Use this skill as a compact documentation helper for AI101 vol.2 homework.

## Response Rules

1. Answer in Russian unless the user asks otherwise.
2. Start with the short answer, then give the concrete next step.
3. Cite the relevant local reference file by path.
4. Separate official Qwen Code behavior from local homework/GigaCode constraints.
5. If the question involves hooks, check matcher casing first. In this homework, matcher tool names are lowercase.
6. If the question involves subagents, remind that fork subagents are disabled in this homework. Use named subagents with `subagent_type`.
7. If the answer depends on a GigaCode fork detail, say that it may differ from upstream Qwen Code.

## Which Reference To Read

- Commands and tools: read `references/commands-tools.md`.
- Skills and hooks: read `references/skills-hooks.md`.
- MCP and subagents: read `references/mcp-subagents.md`.
- Source links and freshness: read `references/source-index.md`.

Do not load every reference by default. Pick the smallest relevant file.

## Choosing Skill vs Subagent

Prefer a skill when the user needs in-context guidance, reusable rules, or explanations that should not leave the current conversation.

Prefer a named subagent when the user needs a separate specialist to perform a scoped read-only investigation, review, or comparison with its own tool allowlist.

For this helper itself, skill is the right form: it explains concepts in the current context and should not lose the user’s active homework state.

## Common Quick Answers

- "Почему hook не сработал?" Check lowercase `matcher`: `run_shell_command`, `edit|write_file`, `task`.
- "Command или skill?" Command is user-invoked; skill is model-invoked based on description.
- "Tool или MCP?" Built-in tools act in the local environment; MCP exposes external systems as tools.
- "Named subagent или fork?" In this homework: named only. Fork is disabled.
- "Можно ли trust: true?" Treat it as high blast radius; use only for a trusted read-only or tightly controlled server.

