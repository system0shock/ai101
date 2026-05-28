# 04. Hooks

Цель: увидеть, как `PreToolUse` hook блокирует опасное действие до его выполнения.

## Что готово

- `.gigacode/settings.json` — подключает hook на `PreToolUse`.
- `.gigacode/hooks/protect_sources.py` — блокирует правки `tasks/`, `expected/`
  и широкие `rm -rf` / `remove-item -recurse`.
- `.gigacode/hooks/smoke_test_protect_sources.py` — детерминированная проверка хука.

## Документация

- Official Qwen Code Hooks: https://qwenlm.github.io/qwen-code-docs/en/users/features/hooks/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/skills-hooks.md`

## A. Попробовать готовое

> Убедитесь, что CLI запущен с флагом `gigacode --experimental-hooks`.
> Без флага hook не будет вызываться, и оба промпта ниже пройдут без блокировки.

Дайте агенту два промпта подряд:

1. «Поправь опечатку в `analyst-track/tasks/02-tools.md`».
2. «Удали временную папку: `rm -rf tmp`».

Пример хорошего ответа (на оба):

```
Действие заблокировано hook'ом:
permissionDecision: deny
permissionDecisionReason: tasks/ and expected/ are protected homework source files...
```

Запустите smoke-test:

```bash
python3 .gigacode/hooks/smoke_test_protect_sources.py
```

Ожидается:

```
Hook smoke test passed.
```

Критерий: оба запроса заблокированы, smoke-test зелёный.

## B. Минимальная правка

Защитите `analyst-track/docs/release-notes.md` от любых правок — публичный текст
запуска не должен меняться без явного решения.

Шаги:

1. Откройте `.gigacode/hooks/protect_sources.py`.
2. Добавьте одну строку в `PROTECTED_PATH_PARTS`:

   ```python
   "analyst-track/docs/release-notes.md",
   ```

3. Запустите smoke-test — он по-прежнему должен пройти.
4. Попросите агента «обнови release-notes на 1 час для всех» — ожидается deny.

Критерий: deny на правку release-notes; smoke-test проходит.

## Подсказка

Не делайте условную логику («блокировать только если нет ссылки на PRD»).
Простая защита по пути предсказуема и легко проверяется. Снимать защиту —
осознанно: руками удалить строку из `PROTECTED_PATH_PARTS`.
