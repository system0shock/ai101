# 03. Skills

Цель: понять, когда skill полезнее длинного prompt.

## Конкретная цель
<!-- concrete-goal -->

Создать skill `.gigacode/skills/junit-failure-review/SKILL.md`, который помогает разбирать JUnit-падения: требует команду воспроизведения, expected/actual, минимальную гипотезу и проверку после правки.

## Документация
<!-- docs-links -->

- Official Qwen Code Skills: https://qwenlm.github.io/qwen-code-docs/en/users/features/skills/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/skills-hooks.md`

## Базовое задание

Попросите агента применить `code-review` или `evidence-first` к изменению.

## Самостоятельно

Создайте `junit-failure-review`: `name`, `description`, 4-6 правил и формат ответа. Примените его к `OrderServiceTest.java` и текущей правке скидки.

## Подсказка для самостоятельной части
<!-- self-hint -->

Начните с копии `.gigacode/skills/code-review/SKILL.md`. В `description` напишите: "Use when a JUnit test fails or Java test output needs diagnosis". Успех: агент сам структурирует ответ как reproduction -> evidence -> hypothesis -> minimal fix -> verification.

