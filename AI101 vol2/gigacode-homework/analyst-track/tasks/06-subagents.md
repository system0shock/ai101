# 06. Subagents

Цель: делегировать узкие read-only проверки именованным субагентам.

> Fork-субагенты отключены. Зовите subagents естественным языком — главный агент
> сам решит, когда вызвать `Task(subagent_type=...)`.

## Что готово

- `.gigacode/agents/doc-analyst.md` — read-only поиск противоречий в документах.
- `.gigacode/agents/consistency-reviewer.md` — read-only проверка согласованности
  итоговой формулировки.

## Документация

- Official Qwen Code Subagents: https://qwenlm.github.io/qwen-code-docs/en/users/features/sub-agents/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/mcp-subagents.md`

## A. Попробовать готовое

Промпт:

```
Используй doc-analyst, чтобы найти противоречия в analyst-track/docs.
Затем используй consistency-reviewer, чтобы проверить, не обещает ли
release-notes.md больше, чем PRD. Сведи всё в один список правок.
```

Пример хорошего ответа:

```
doc-analyst нашёл (read-only):
- аудитория: faq.md vs prd.md
- срок одобрения: faq.md vs prd.md
- лимит: faq.md vs prd.md
- ставка: faq.md vs prd.md

consistency-reviewer (read-only):
- release-notes.md соответствует PRD по всем четырём параметрам.

Список правок (главный агент):
- faq.md: ограничить аудиторию зарплатным сегментом.
- faq.md: исправить срок на «до 3 рабочих дней».
- faq.md: исправить лимит на 500 000 руб.
- faq.md: убрать ставку 9,9% или явно пометить как промо.
```

Критерий: в логе видно два вызова subagent (parallel tool calls — если среда
поддерживает; иначе последовательно), итоговый список собирает главный агент.

## B. Минимальная правка

Задача: завести своего read-only subagent `legal-constraints-reviewer`,
который проверяет только юридические и регуляторные ограничения кредитного продукта.

Критерий готовности: запрос «используй legal-constraints-reviewer, проверь
release-notes» возвращает finding по сроку одобрения (1 час в FAQ против требования
юристов писать реальный срок) с указанием источника. Subagent не редактирует файлы.

Посмотрите в доках по subagents (ссылка выше) формат `.md`-файла агента
(frontmatter с `name`, `description`, `tools`, `approvalMode`).

## Подсказка

Не пишите agent с нуля. Готовый `.gigacode/agents/doc-analyst.md` — близкий
шаблон. Скопируйте его и сузьте `description` и тело промпта.

Subagent стартует без истории родителя. Если зовёте его на конкретные файлы —
перечислите пути в промпте, иначе он не будет знать, где искать.

### Если застряли

> Подглядывайте сюда, только если самостоятельно не получается.

Скопируйте `.gigacode/agents/doc-analyst.md` в
`.gigacode/agents/legal-constraints-reviewer.md` и сузьте роль до юридических ограничений.

Пример результата:

```markdown
---
name: legal-constraints-reviewer
description: Read-only проверка юридических и регуляторных ограничений в документах кредитного продукта.
tools:
  - read_file
  - grep_search
  - glob
approvalMode: plan
---

Проверяй только юридические и регуляторные требования: согласие юристов
на формулировки, соответствие срокам, ограничениям и обязательным дисклеймерам.
Возвращай вывод в формате `finding -> source (file:line) -> recommended wording`.
Файлы не редактируй.
```
