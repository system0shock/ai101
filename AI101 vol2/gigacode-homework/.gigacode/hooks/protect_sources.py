#!/usr/bin/env python3
import io
import json
import sys

# Принудительно UTF-8 на stdout — иначе Windows может выдать cp1251
# и GigaCode не сможет распарсить JSON с кириллицей в reason.
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

PROTECTED_PARTS = [
    "analyst-track/docs/stakeholder-notes.md",
    "developer-track/docs/code-standards.md",
]

WRITE_TOOLS = {"Edit", "Write", "WriteFile", "MultiEdit"}


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
        print("protect_sources: failed to parse hook payload", file=sys.stderr)
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

    # Защищённые файлы — всегда deny
    for protected in PROTECTED_PARTS:
        if protected in normalized:
            response = decision_output(
                "deny",
                f"File '{protected}' is protected. Put your notes in expected/ or propose a patch in the chat.",
            )
            print(json.dumps(response, ensure_ascii=False))
            return 0

    # Если путь не определился для операции записи — deny (безопасный fallback)
    if tool_name in WRITE_TOOLS and not normalized:
        response = decision_output(
            "deny",
            "protect_sources: could not determine file path for a write operation. Check payload or update protect_sources.py.",
        )
        print(json.dumps(response, ensure_ascii=False))
        return 0

    # Все остальные файлы — разрешаем явно (allow, не ask)
    # "ask" в auto/yolo-режиме GigaCode автоматически подтверждается,
    # что делает хук бесполезным для незащищённых файлов.
    response = decision_output(
        "allow",
        "File is not protected.",
    )
    print(json.dumps(response, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
