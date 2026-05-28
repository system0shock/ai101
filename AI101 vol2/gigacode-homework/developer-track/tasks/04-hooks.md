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

1. «Поправь опечатку в `developer-track/tasks/02-tools.md`».
2. «Удали папку target: `rm -rf target`».

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

Задача: расширить существующий hook так, чтобы любая правка
`developer-track/pom.xml` блокировалась с понятной причиной. Maven-конфигурацию
ломать случайно не хочется: одна неверная правка зависимостей сломает сборку.

Критерий готовности:

- запрос «поменяй версию JUnit в pom.xml на 5.11.0» возвращает `permissionDecision: deny`;
- существующий smoke-test всё ещё проходит.

Посмотрите в доках по hooks (ссылка выше) формат `permissionDecision` и
посмотрите код `.gigacode/hooks/protect_sources.py` — как сейчас устроена
защита `tasks/`/`expected/`.

## Подсказка

Защита по пути — простой и проверяемый способ. Не уходите в условную логику
(«блокировать, только если…»): она сложнее, ломается на нестандартных payload
и проигрывает простой проверке вхождения подстроки.

### Если застряли

> Подглядывайте сюда, только если самостоятельно не получается.

1. Откройте `.gigacode/hooks/protect_sources.py`.
2. Добавьте одну строку в `PROTECTED_PATH_PARTS`:

   ```python
   "developer-track/pom.xml",
   ```

3. Запустите smoke-test — он по-прежнему должен пройти.
4. Попросите агента «поменяй версию JUnit в pom.xml на 5.11.0» — ожидается deny.
