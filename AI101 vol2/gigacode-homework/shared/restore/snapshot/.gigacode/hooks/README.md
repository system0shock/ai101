# Hooks

`settings.json` and `settings.example.json` contain a working `PreToolUse` hook.

Important details:

- Commands use `python3`, not `python`.
- Command hook timeout is in milliseconds, so examples use `5000`.
- In this GigaCode homework setup, matcher tool names are lowercase:
  - `run_shell_command`
  - `edit`
  - `write_file`
  - `task`
- For `PreToolUse`, blocking output must use `hookSpecificOutput`:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Reason shown to the model/user"
  }
}
```

Smoke-test the hook from the `gigacode-homework/` root:

```powershell
python3 .gigacode/hooks/smoke_test_protect_sources.py
```

