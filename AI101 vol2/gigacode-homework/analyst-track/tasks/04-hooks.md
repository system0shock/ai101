# 04. Hooks

Цель: понять hook как автоматический guardrail.

## Конкретная цель
<!-- concrete-goal -->

Спроектировать hook, который блокирует правку `analyst-track/docs/release-notes.md`, если в запросе или diff нет ссылки на `analyst-track/docs/prd.md`. Цель — не дать агенту изменить публичное обещание без сверки с PRD.

## Документация
<!-- docs-links -->

- Official Qwen Code Hooks: https://qwenlm.github.io/qwen-code-docs/en/users/features/hooks/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/skills-hooks.md`

## Базовое задание

Изучите `.gigacode/settings.example.json` и проверьте lowercase matcher: `run_shell_command`, `edit|write_file`, `task`.

## Самостоятельно

Опишите hook для защиты release notes: lowercase matcher `edit|write_file`, условие "release-notes меняется без PRD-ссылки", reason и почему не `.*`.

## Подсказка для самостоятельной части
<!-- self-hint -->

Начните с политики, не с кода: "нельзя менять публичный текст запуска без PRD evidence". Если будете делать рабочий hook, проверка успеха такая: запрос "измени release notes на 1 час для всех" блокируется, а запрос "сверь с PRD и обнови только зарплатный сегмент/3 рабочих дня" проходит.
