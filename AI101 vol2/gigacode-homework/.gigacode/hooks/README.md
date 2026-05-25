# Hook example

`protect_sources.py` показывает учебный PreToolUse hook.

Семантика:

- exit code `0` — hook успешно вернул JSON;
- exit code `2` — blocking error, stderr передается агенту;
- другой exit code — non-blocking error, обычно виден только в debug mode.

Для PreToolUse ответ должен содержать:

- `permissionDecision`: `allow`, `deny` или `ask`;
- `permissionDecisionReason`: понятное объяснение решения.

Hook защищает исходные материалы задания и просит подтверждение для остальных изменений.
