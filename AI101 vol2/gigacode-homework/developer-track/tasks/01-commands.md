# 01. Commands

Цель: попробовать `/`, `@`, `!` и custom commands.

## Конкретная цель
<!-- concrete-goal -->

К концу задания у вас должна появиться custom command `.gigacode/commands/explain-test-failure.md`, которая готовит агента к разбору падающего теста: просит собрать evidence, назвать нужные файлы и не править код без плана.

## Документация
<!-- docs-links -->

- Official Qwen Code Commands: https://qwenlm.github.io/qwen-code-docs/en/users/features/commands/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/commands-tools.md`

## Базовое задание

Выполните `/tools`, `/skills`, добавьте `@developer-track/app/src/main/java/ru/ai101/gigacode/shop/OrderService.java`, затем выполните `!git status --short`.

## Самостоятельно

Создайте `.gigacode/commands/explain-test-failure.md`. Команда должна:

- иметь `description`;
- просить агента сначала запустить или запросить точечную проверку;
- требовать evidence-first вывод;
- запрещать правки без короткого плана.

## Подсказка для самостоятельной части
<!-- self-hint -->

Скопируйте структуру из `.gigacode/commands/review-changes.md`: YAML frontmatter с `description`, затем короткий prompt. Проверьте результат так: запустите команду и убедитесь, что агент предлагает план диагностики, а не сразу переписывает код.

