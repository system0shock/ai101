# 01. Commands

Цель: управлять контекстом через команды.

## Конкретная цель
<!-- concrete-goal -->

Создать custom command `.gigacode/commands/prepare-credit-launch-meeting.md`, которая готовит встречу по запуску онлайн-кредита «Быстрый старт»: собирает факты, конфликты и вопросы владельцам без правки документов.

## Документация
<!-- docs-links -->

- Official Qwen Code Commands: https://qwenlm.github.io/qwen-code-docs/en/users/features/commands/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/commands-tools.md`

## Базовое задание

Выполните `/tools`, `/skills`, `/mcp`, добавьте `@analyst-track/docs/prd.md` и `@analyst-track/docs/stakeholder-notes.md`, затем запустите `/summarize-context`.

## Самостоятельно

Напишите custom command для подготовки встречи: `description`, факты, конфликты, вопросы, без правок документов.

## Подсказка для самостоятельной части
<!-- self-hint -->

Сделайте команду как reusable agenda: сначала собрать источники, затем выписать конфликты, потом сформулировать вопросы владельцам. Успех: после запуска команды агент выдаёт список вопросов вроде "для кого действует 3-дневный срок" и "можно ли обещать одобрение за 1 час всем клиентам", но не меняет `faq.md`.
