# Skills And Hooks

## Skills

Official Qwen Code docs define skills as folders with a required `SKILL.md` and optional supporting files. A skill packages expertise into a discoverable capability.

Key points:

- Skills are model-invoked: the model chooses them based on the user request and the skill `description`.
- A user can explicitly invoke a skill with `/skills <skill-name>`.
- Personal skills normally live under `~/.qwen/skills/`.
- Project skills normally live under `.qwen/skills/` and can be committed to git.

Homework adaptation:

- This kit uses `.gigacode/skills/`.
- Use skills for reusable guidance, standards, review rules, and explanations.
- Keep `description` specific. It is the main trigger.

## Hooks

Official Qwen Code docs describe hooks as user-defined scripts or programs executed at specific lifecycle points.

Common uses:

- audit tool usage;
- enforce security policy;
- inject context;
- modify tool input or response;
- integrate with external systems.

Executor types:

- `command`: shell command, JSON via stdin/stdout;
- `http`: POST JSON to a URL;
- `function`: registered JavaScript function for session-level hooks.

Common events:

- `PreToolUse`;
- `PostToolUse`;
- `PostToolUseFailure`;
- `UserPromptSubmit`;
- `SessionStart`;
- `SessionEnd`;
- `SubagentStart`;
- `SubagentStop`;
- `PermissionRequest`.

## Matcher Rule For This Homework

In this homework/GigaCode setup, matcher tool names must be lowercase:

- `run_shell_command`
- `edit`
- `write_file`
- `task`

If a hook is configured with `RunShellCommand`, `WriteFile`, or `Task`, assume the first debugging step is to rewrite matcher names to lowercase and retest.

Avoid `.*` unless the exercise explicitly asks for a global hook. Broad matchers slow the workflow and cause confusing blocks.

## Working Hook Example In This Homework

The ready settings files are:

- `.gigacode/settings.json`
- `.gigacode/settings.example.json`

Both use:

- `python3 .gigacode/hooks/protect_sources.py`
- timeout `5000`
- lowercase matchers

For `PreToolUse`, deny output must be nested under `hookSpecificOutput`:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Reason shown to the model/user"
  }
}
```

Run the hook smoke test from the homework root:

```bash
python3 .gigacode/hooks/smoke_test_protect_sources.py
```
