# Commands And Tools

## Commands

Official Qwen Code docs divide commands into three categories:

- Slash commands `/`: meta-level control of Qwen Code itself.
- At commands `@`: inject local file or directory content into the conversation.
- Exclamation commands `!`: execute shell commands from the CLI.

Useful slash commands for this homework:

- `/tools`: show currently available tools.
- `/skills`: list skills and explicitly invoke a skill.
- `/mcp`: list configured MCP servers and tools.
- `/plan`: enter planning mode.
- `/approval-mode`: change tool approval behavior.
- `/context`: inspect context usage.

Custom commands are reusable prompt files. Use them when the user should explicitly start the workflow. In this homework they live under `.gigacode/commands/`.

## Tools

Official Qwen Code docs describe tools as functions the model can request so the CLI can interact with the local environment, web, files, shell, or other systems.

Typical flow:

1. User provides a prompt.
2. Qwen Code sends available tool schemas to the model.
3. The model requests a tool if needed.
4. The core validates the request.
5. Sensitive operations may require confirmation.
6. Tool output returns to the model.
7. The model uses the result in its answer.

Use this homework pattern:

1. Explore with search/list tools.
2. Read exact files.
3. Plan the change.
4. Edit minimally.
5. Verify with a targeted command.

## Command vs Tool

- Command: user explicitly types it.
- Tool: model requests it when needed.
- Custom command: reusable prompt workflow.
- Tool-use summary: ask the agent to explain why each tool call was needed.

