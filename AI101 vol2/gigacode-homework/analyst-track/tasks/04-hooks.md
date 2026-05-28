# 04. Hooks

Цель: понять hook как автоматический guardrail для аналитического артефакта.

## Конкретная цель
<!-- concrete-goal -->

Добиться, чтобы `PreToolUse` hook блокировал правку `analyst-track/docs/release-notes.md`, если в запросе или diff нет ссылки на `analyst-track/docs/prd.md`. Цель правила: не дать агенту изменить публичное обещание релиза без сверки с PRD.

## Документация
<!-- docs-links -->

- Official Qwen Code Hooks: https://qwenlm.github.io/qwen-code-docs/en/users/features/hooks/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/skills-hooks.md`
- Готовый settings: `../../.gigacode/settings.json`
- Smoke-test базового hook-а: `../../.gigacode/hooks/smoke_test_protect_sources.py`

## Базовое задание

Изучите `.gigacode/settings.json` и `.gigacode/hooks/protect_sources.py`. Проверьте, что базовая защита действительно рабочая:

- matcher написаны lowercase: `run_shell_command`, `edit|write_file`, `task`;
- команда hook-а запускается через `python3 .gigacode/hooks/protect_sources.py`;
- отказ возвращается в формате `hookSpecificOutput` с `hookEventName: "PreToolUse"` и `permissionDecision: "deny"`.

Запустите проверку:

```bash
python3 .gigacode/hooks/smoke_test_protect_sources.py
```

Ожидаемый результат: `Hook smoke test passed.`

## Самостоятельно

Спроектируйте или реализуйте правило для release notes: если инструмент пытается изменить `analyst-track/docs/release-notes.md`, в данных hook-а должна быть ссылка на `analyst-track/docs/prd.md`. Без такой ссылки hook должен вернуть deny с причиной "release notes можно менять только после сверки с PRD".

Критерий готовности:

- запрос "измени release notes на 1 час для всех" блокируется;
- запрос "сверь с PRD и обнови только зарплатный сегмент/3 рабочих дня" проходит;
- matcher остается точным `edit|write_file`, а не широким `.*`.

## Подсказка для самостоятельной части
<!-- self-hint -->

Начните с политики, не с кода: правило должно защищать только публичный текст релиза. Если реализуете hook, проверьте `tool_input.file_path` или похожее поле на `release-notes.md`, а затем ищите `analyst-track/docs/prd.md` в доступном тексте запроса или diff. Для отказа используйте тот же вложенный формат `hookSpecificOutput`, что и в готовом `protect_sources.py`.
