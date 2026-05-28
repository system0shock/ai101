# 03. Skills

Цель: упаковать аналитическое правило в skill.

## Конкретная цель
<!-- concrete-goal -->

Создать skill `.gigacode/skills/launch-claims-review/SKILL.md`, который проверяет публичные формулировки запуска: не обещают ли FAQ/release notes больше, чем PRD и юридические ограничения.

## Документация
<!-- docs-links -->

- Official Qwen Code Skills: https://qwenlm.github.io/qwen-code-docs/en/users/features/skills/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/skills-hooks.md`

## Базовое задание

Попросите агента применить `doc-review` к документам трека.

## Самостоятельно

Создайте skill для аналитической практики: `name`, `description`, правила проверки требований и формат ответа.

## Подсказка для самостоятельной части
<!-- self-hint -->

В `description` укажите триггер: "Use when checking release notes, FAQ, or launch claims against PRD constraints". В правила включите проверку аудитории (зарплатный сегмент), срока рассмотрения (3 рабочих дня), лимита (500 000 руб.) и ставки (14,9%). Успех: агент применяет skill к `faq.md` и находит завышенные обещания по всем четырём параметрам.
