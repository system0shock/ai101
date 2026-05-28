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

1. Выполните `/tools`, `/skills`, `/mcp` — посмотрите, что подключено.
2. Добавьте два документа в контекст:
   ```
   @analyst-track/docs/prd.md @analyst-track/docs/faq.md
   ```
3. Запустите `/summarize-context`.

Пример хорошего ответа:

```
Цель: разобрать конфликты по запуску онлайн-кредита «Быстрый старт».
Файлы в контексте:
- analyst-track/docs/prd.md — утверждённые ограничения продукта.
- analyst-track/docs/faq.md — черновик публичных формулировок.
Ограничения: источники не редактируем без явного запроса.
Следующий безопасный шаг: прочитать stakeholder-notes.md и release-notes.md,
сверить публичные обещания с PRD.
```

Критерий: вывод — это краткая сводка контекста, никаких правок файлов.

## B. Минимальная правка

Задача: добавить свою custom command `/prepare-credit-launch-meeting`, которая
готовит встречу владельцев по запуску онлайн-кредита: собирает факты из всех
четырёх документов, выписывает конфликты и формулирует вопросы.

Критерий готовности: команда видна в `/help`, запуск даёт список вопросов
владельцам (например, «какой лимит утверждён для старта»), документы `docs/`
не меняются.

Загляните в доки по commands (ссылка выше) — там описан формат custom command
и frontmatter.

## Подсказка

Готовая `.gigacode/commands/summarize-context.md` — самый близкий шаблон.
Структура простая: YAML frontmatter с `description`, потом текст промпта.

### Если застряли

> Подглядывайте сюда, только если самостоятельно не получается. Попытка сделать
> сначала и подсмотреть в доку — часть упражнения.

Скопируйте `.gigacode/commands/summarize-context.md` в
`.gigacode/commands/prepare-credit-launch-meeting.md` и подмените содержимое.

Пример результата:

```markdown
---
description: Подготовить агенду встречи по запуску онлайн-кредита
---

Подготовь встречу: собери ключевые факты из
@analyst-track/docs/prd.md, @analyst-track/docs/stakeholder-notes.md,
@analyst-track/docs/faq.md, @analyst-track/docs/release-notes.md.
Выпиши конфликты с указанием источников и сформулируй вопросы владельцам.
Документы не редактируй.
```
