# Local MCP Server

This folder contains a ready-to-run local MCP server for the homework.

The server uses stdio and has no external dependencies:

```powershell
python3 shared/mcp/local_knowledge_server.py
```

Do not type requests into it manually during normal homework flow. GigaCode/Qwen Code starts the process and talks to it over stdio.

## Tools

- `get_discount_policy` - returns the developer-track bulk discount rule.
- `search_credit_policy` - returns a quote from the analyst-track credit policy.

Both tools are read-only.

## Smoke Test

From the `gigacode-homework/` root:

```powershell
python3 shared/mcp/smoke_test_local_server.py
```

Expected output:

```text
Local MCP stdio smoke test passed.
```

## GigaCode/Qwen Code Config

Use `local-stdio-server.config.example.json` as the example `mcpServers` block:

```json
{
  "mcpServers": {
    "ai101Local": {
      "command": "python3",
      "args": ["shared/mcp/local_knowledge_server.py"],
      "cwd": ".",
      "includeTools": ["get_discount_policy", "search_credit_policy"],
      "timeout": 15000,
      "trust": false
    }
  }
}
```

In upstream Qwen Code this usually goes to `.qwen/settings.json`. In this homework/GigaCode fork, use the local `.gigacode/` convention if your environment expects it.
