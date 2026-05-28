import json
import sys


def main() -> int:
    try:
        payload = json.load(sys.stdin)
    except Exception:
        return 0

    text = json.dumps(payload, ensure_ascii=False).lower()
    if "/tasks/" in text or "\\tasks\\" in text or "/expected/" in text or "\\expected\\" in text:
        print(json.dumps({
            "permissionDecision": "deny",
            "permissionDecisionReason": "tasks/ и expected/ защищены: редактируйте рабочие файлы трека или явно попросите изменить домашку."
        }, ensure_ascii=False))
    elif "rm -rf" in text or "remove-item -recurse" in text:
        print(json.dumps({
            "permissionDecision": "deny",
            "permissionDecisionReason": "Команда слишком широкая. Укажите точную цель и сначала покажите listing."
        }, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

