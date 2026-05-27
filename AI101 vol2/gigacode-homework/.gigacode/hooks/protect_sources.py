#!/usr/bin/env python3
import json
import sys

PROTECTED_PARTS = [
    "analyst-track/docs/stakeholder-notes.md",
    "developer-track/docs/code-standards.md",
]

WRITE_TOOLS = {"Edit", "WriteFile"}


def decision_output(decision: str, reason: str) -> dict:
    return {
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": decision,
            "permissionDecisionReason": reason,
        }
    }


def main() -> int:
    raw = sys.stdin.read()
    try:
        payload = json.loads(raw) if raw.strip() else {}
    except json.JSONDecodeError:
        print("Не удалось прочитать JSON hook payload", file=sys.stderr)
        return 2

    tool_name = str(payload.get("tool_name") or "")
    tool_input = payload.get("tool_input")
    if not isinstance(tool_input, dict):
        tool_input = {}

    path = str(
        tool_input.get("file_path")
        or tool_input.get("filePath")
        or tool_input.get("path")
        or tool_input.get("absolute_path")
        or payload.get("file_path")
        or payload.get("filePath")
        or payload.get("path")
        or payload.get("absolute_path")
        or ""
    )
    normalized = path.replace("\\", "/")

    for protected in PROTECTED_PARTS:
        if protected in normalized:
            response = decision_output(
                "deny",
                f"Файл {protected} защищен в учебном комплекте. Создайте заметку в expected/ или предложите patch в ответе.",
            )
            print(json.dumps(response, ensure_ascii=False))
            return 0

    if tool_name in WRITE_TOOLS and not normalized:
        response = decision_output(
            "deny",
            "Hook не смог определить путь файла для операции записи. Проверьте payload или обновите protect_sources.py.",
        )
        print(json.dumps(response, ensure_ascii=False))
        return 0

    response = decision_output(
        "ask",
        "Учебный hook просит подтвердить изменение файла.",
    )
    print(json.dumps(response, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
