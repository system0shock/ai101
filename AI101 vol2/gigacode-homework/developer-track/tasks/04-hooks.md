# 04. Hooks

Цель: настроить guardrail и увидеть, как hook направляет работу.

## Конкретная цель
<!-- concrete-goal -->

Сделать hook, который блокирует попытку изменить файлы `developer-track/tasks/` и возвращает понятную причину: "задания являются исходным материалом, редактируйте код в app/ или явно попросите изменить домашку".

## Документация
<!-- docs-links -->

- Official Qwen Code Hooks: https://qwenlm.github.io/qwen-code-docs/en/users/features/hooks/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/skills-hooks.md`

## Базовое задание

Изучите `.gigacode/settings.example.json`. Matcher должны быть lowercase: `run_shell_command`, `edit|write_file`, `task`.

## Самостоятельно

Опишите или реализуйте hook для защиты `developer-track/tasks/`: lowercase matcher `edit|write_file`, условие на путь, `permissionDecisionReason`, timeout и два примера проверки.

## Подсказка для самостоятельной части
<!-- self-hint -->

Если реализуете рабочий hook, используйте существующий `.gigacode/hooks/protect_sources.py` как основу. Проверка успеха: попытка правки `developer-track/tasks/02-tools.md` блокируется, а правка `developer-track/app/src/main/java/...` не блокируется. Если hook не сработал, первым делом проверьте lowercase matcher.

