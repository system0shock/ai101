# Пример hook

`protect_sources.py` показывает учебный PreToolUse hook.

Семантика:

- exit code `0` -- hook успешно вернул JSON;
- exit code `2` -- блокирующая ошибка, stderr передается агенту;
- другой exit code -- неблокирующая ошибка, обычно видна только в debug mode.

Для PreToolUse ответ должен вернуть решение в `hookSpecificOutput`:

- `hookEventName`: `PreToolUse`;
- `permissionDecision`: `allow`, `deny` или `ask`;
- `permissionDecisionReason`: понятное объяснение решения.

Hook читает путь из `tool_input.file_path` или `tool_input.path`. Для старых payload оставлен fallback на верхнеуровневые `file_path` и `path`.

Hook защищает исходные материалы задания и просит подтверждение для остальных изменений.
