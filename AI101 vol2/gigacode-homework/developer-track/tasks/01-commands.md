# 01. Commands

Цель: использовать встроенные команды контекста и создать свою.

## Что готово

- `.gigacode/commands/summarize-context.md` — собирает цель, файлы, ограничения.
- `.gigacode/commands/review-changes.md` — проверяет текущие изменения.
- `.gigacode/commands/write-handoff.md` — формирует handoff в конце упражнения.
- Встроенные: `/tools`, `/skills`, `/mcp`, `@path`, `!shell`.

## Документация

- Official Qwen Code Commands: https://qwenlm.github.io/qwen-code-docs/en/users/features/commands/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/commands-tools.md`

## A. Попробовать готовое

1. Выполните `/tools` и `/skills` — посмотрите, что подключено.
2. Добавьте в контекст основной файл с багом:

   ```
   @developer-track/app/src/main/java/ru/ai101/gigacode/shop/DiscountPolicy.java
   ```

3. Запустите `/summarize-context`.

Пример хорошего ответа:

```
Цель: разобрать упражнение с падающим тестом.
Файлы в контексте:
- DiscountPolicy.java — текущее правило bulk-скидки.
Ограничения: правки только в developer-track/app/, не трогать tasks/ и expected/.
Следующий безопасный шаг: запустить mvn test, прочитать тестовый файл,
сформулировать гипотезу.
```

Критерий: краткая сводка контекста без правок кода.

## B. Минимальная правка

Скопируйте `.gigacode/commands/summarize-context.md` в
`.gigacode/commands/explain-test-failure.md` и подмените содержимое
под разбор падающего теста.

Пример результата:

```markdown
---
description: Разобрать падающий JUnit-тест без правки кода
---

Разбери падающий тест: запусти `mvn test`, прочитай тест и связанный код,
сформулируй гипотезу про причину падения. Не правь код.

В конце выдай: expected vs actual, file:line с подозрительным местом,
минимальную предлагаемую правку (diff) и команду проверки.
```

Проверка: запустите `/explain-test-failure`. Агент должен предложить план
диагностики (mvn test → read → гипотеза → правка-предложение), а не сразу
переписать `DiscountPolicy.java`.

## Подсказка

Не пишите команду с нуля — копия и подмена текста. Frontmatter c `description`
обязателен: без него команда не появится в `/help` и не будет вызываться по имени.
