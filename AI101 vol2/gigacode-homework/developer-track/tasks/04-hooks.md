# 04. Hooks

Цель: настроить guardrail и увидеть, как hook блокирует опасное действие до выполнения инструмента.

## Конкретная цель
<!-- concrete-goal -->

Добиться, чтобы готовый `PreToolUse` hook блокировал попытку изменить файлы `developer-track/tasks/` и возвращал понятную причину: задания являются исходным материалом, редактируйте код в `app/` или явно попросите изменить домашку. Разрешенные изменения в `developer-track/app/` не должны блокироваться.

## Документация
<!-- docs-links -->

- Official Qwen Code Hooks: https://qwenlm.github.io/qwen-code-docs/en/users/features/hooks/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/skills-hooks.md`
- Готовый settings: `../../.gigacode/settings.json`
- Smoke-test hook-а: `../../.gigacode/hooks/smoke_test_protect_sources.py`

## Базовое задание

Изучите `.gigacode/settings.json` и `.gigacode/hooks/protect_sources.py`. Проверьте три обязательных свойства рабочей конфигурации:

- matcher написаны lowercase: `run_shell_command`, `edit|write_file`, `task`;
- команда hook-а запускается через `python3 .gigacode/hooks/protect_sources.py`;
- отказ возвращается в формате `hookSpecificOutput` с `hookEventName: "PreToolUse"` и `permissionDecision: "deny"`.

Запустите проверку:

```bash
python3 .gigacode/hooks/smoke_test_protect_sources.py
```

Ожидаемый результат: `Hook smoke test passed.`

## Самостоятельно

Добавьте в `protect_sources.py` второе правило: блокировать shell-команды, которые пытаются удалить каталог `developer-track/app/src/main/resources/` целиком. Цель правила: защитить тестовые данные приложения от случайного удаления, но не запрещать обычное чтение и точечное редактирование файлов в этом каталоге.

Критерий готовности:

- команда удаления всего каталога получает `permissionDecision: "deny"`;
- причина отказа объясняет, что тестовые данные нельзя удалять целиком;
- команда чтения файла из `developer-track/app/src/main/resources/` не блокируется.

## Подсказка для самостоятельной части
<!-- self-hint -->

Скопируйте структуру проверки опасных shell-команд из `protect_sources.py`: нормализуйте команду в lowercase, ищите одновременно действие удаления и защищенный путь. Для отказа используйте существующую функцию `deny(...)`, потому что она уже печатает корректный формат `hookSpecificOutput`.
