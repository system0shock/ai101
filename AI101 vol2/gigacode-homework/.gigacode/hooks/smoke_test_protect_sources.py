import json
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
HOOK = ROOT / ".gigacode" / "hooks" / "protect_sources.py"


def run_hook(payload):
    completed = subprocess.run(
        [sys.executable, str(HOOK)],
        input=json.dumps(payload),
        text=True,
        encoding="utf-8",
        capture_output=True,
        check=True,
    )
    return completed.stdout.strip()


def parse_output(stdout):
    assert stdout, "Expected hook to emit a decision"
    output = json.loads(stdout)
    specific = output["hookSpecificOutput"]
    assert specific["hookEventName"] == "PreToolUse"
    return specific


def main():
    protected = run_hook({
        "hook_event_name": "PreToolUse",
        "tool_name": "edit",
        "tool_input": {"file_path": "developer-track/tasks/02-tools.md"},
    })
    protected_specific = parse_output(protected)
    assert protected_specific["permissionDecision"] == "deny"
    assert "protected homework source files" in protected_specific["permissionDecisionReason"]

    dangerous = run_hook({
        "hook_event_name": "PreToolUse",
        "tool_name": "run_shell_command",
        "tool_input": {"command": "rm -rf tmp"},
    })
    dangerous_specific = parse_output(dangerous)
    assert dangerous_specific["permissionDecision"] == "deny"
    assert "too broad" in dangerous_specific["permissionDecisionReason"]

    allowed = run_hook({
        "hook_event_name": "PreToolUse",
        "tool_name": "edit",
        "tool_input": {"file_path": "developer-track/app/src/main/java/ru/ai101/gigacode/shop/OrderService.java"},
    })
    assert allowed == "", f"Expected no hook output for allowed edit, got: {allowed}"

    print("Hook smoke test passed.")


if __name__ == "__main__":
    main()
