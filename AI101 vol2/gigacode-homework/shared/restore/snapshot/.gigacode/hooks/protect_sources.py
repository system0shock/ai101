import json
import sys


PROTECTED_PATH_PARTS = (
    "/tasks/",
    "\\tasks\\",
    "/expected/",
    "\\expected\\",
)

DANGEROUS_COMMAND_PARTS = (
    "rm -rf",
    "remove-item -recurse",
)


def deny(reason: str) -> None:
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "deny",
            "permissionDecisionReason": reason,
        }
    }, ensure_ascii=False))


def normalized_payload_text(payload: dict) -> str:
    return json.dumps(payload, ensure_ascii=False).replace("\\/", "/").lower()


def main() -> int:
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0

    text = normalized_payload_text(payload)

    if any(part in text for part in PROTECTED_PATH_PARTS):
        deny(
            "tasks/ and expected/ are protected homework source files. "
            "Edit track working files instead, or explicitly ask to change the homework itself."
        )
        return 0

    if any(part in text for part in DANGEROUS_COMMAND_PARTS):
        deny(
            "The shell command is too broad. Specify an exact target and show a listing or dry run first."
        )
        return 0

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

