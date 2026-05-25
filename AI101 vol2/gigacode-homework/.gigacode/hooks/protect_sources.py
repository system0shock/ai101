#!/usr/bin/env python3
import json
import sys

PROTECTED_PARTS = [
    "analyst-track/docs/stakeholder-notes.md",
    "developer-track/docs/code-standards.md",
]


def main() -> int:
    raw = sys.stdin.read()
    try:
        payload = json.loads(raw) if raw.strip() else {}
    except json.JSONDecodeError:
        print("Не удалось прочитать JSON hook payload", file=sys.stderr)
        return 2

    path = str(payload.get("path") or payload.get("file_path") or "")
    normalized = path.replace("\\", "/")

    for protected in PROTECTED_PARTS:
        if protected in normalized:
            response = {
                "permissionDecision": "deny",
                "permissionDecisionReason": f"Файл {protected} защищен в учебном комплекте. Создайте заметку в expected/ или предложите patch в ответе.",
            }
            print(json.dumps(response, ensure_ascii=False))
            return 0

    response = {
        "permissionDecision": "ask",
        "permissionDecisionReason": "Учебный hook просит подтвердить изменение файла.",
    }
    print(json.dumps(response, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
