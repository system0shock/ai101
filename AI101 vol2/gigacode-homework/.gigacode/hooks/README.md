# Пример hook

`protect_sources.py` показывает учебный PreToolUse hook.

Семантика:

- exit code `0` -- hook успешно вернул JSON;
- exit code `2` -- блокирующая ошибка, stderr передается агенту;
- другой exit code -- неблокирующая ошибка, обычно видна только в debug mode.

Для PreToolUse ответ должен вернуть решение в `hookSpecificOutput`:

- `hookEventName`: `PreToolUse`;
- `permissionDecision`: `allow`, `deny` или `ask`, обязательное поле;
- `permissionDecisionReason`: понятное объяснение решения, обязательное поле.

`hookSpecificOutput` также обязателен для официального интерфейса PreToolUse. Top-level `decision` и `reason` могут поддерживаться внутренними классами, но для этого задания не используются.

Hook сначала читает путь из `tool_input.file_path`, `tool_input.filePath`, `tool_input.path` или `tool_input.absolute_path`. Для старых payload оставлен fallback на верхнеуровневые `file_path`, `filePath`, `path` и `absolute_path`.

Если эти поля не совпали с protected path, hook дополнительно ищет protected path во всем объекте `tool_input`. Это нужно для payload, где имя файла передано во вложенном или нестандартном поле.

Hook подключен в `.gigacode/settings.json`. `settings.example.json` оставлен как копия для разбора настройки.

Matcher настроен на `Edit`, `Write`, `WriteFile` и `MultiEdit`, потому что GigaCode может использовать разные write-инструменты для изменения файла.

Hook защищает исходные материалы задания и явно разрешает остальные изменения. Если операция записи пришла без распознанного пути, hook возвращает `deny`, чтобы protected-файл нельзя было изменить из-за неизвестного формата payload.
