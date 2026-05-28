# 06. Subagents

Цель: делегировать узкие read-only проверки именованным субагентам.

> Fork-субагенты отключены. Зовите subagents естественным языком — главный агент
> сам решит, когда вызвать `Task(subagent_type=...)`.

## Что готово

- `.gigacode/agents/code-reviewer.md` — read-only проверка контракта в Java-коде.
- `.gigacode/agents/test-investigator.md` — read-only поиск тестов
  и сценариев, которые затрагивает изменение.

## Документация

- Official Qwen Code Subagents: https://qwenlm.github.io/qwen-code-docs/en/users/features/sub-agents/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/mcp-subagents.md`

## A. Попробовать готовое

Промпт (после правки скидки из задания 02):

```
Используй code-reviewer, чтобы проверить публичный контракт DiscountPolicy.java
после правки. Параллельно используй test-investigator, чтобы найти, какие тесты
затрагивает это изменение. Сведи результаты в один отчёт.
```

Пример хорошего ответа:

```
code-reviewer (read-only):
- DiscountPolicy.java:5 — изменение границы > → >= консервативное:
  расширяет покрытие (10 теперь скидывается), не сужает.

test-investigator (read-only):
- OrderServiceTest.java:9 — единственный тест, покрывает ровно 10 элементов.
  Граничные точки 9 и 11 не покрыты.

Решение (главный агент):
- Принять правку.
- Добавить два теста: на 9 элементов (0% скидки) и на 11 (10% скидки).
```

Критерий: в логе видно два вызова subagent (parallel tool calls — если среда
поддерживает; иначе последовательно), итоговое решение собирает главный агент.

## B. Минимальная правка

Скопируйте `.gigacode/agents/code-reviewer.md` в
`.gigacode/agents/discount-policy-reviewer.md` и сузьте роль до политики скидок.

Пример результата:

```markdown
---
name: discount-policy-reviewer
description: Read-only проверка контракта и граничных условий правил скидок.
tools:
  - read_file
  - grep_search
  - glob
approvalMode: plan
---

Проверяй только код, относящийся к политикам скидок (DiscountPolicy
и его потребители). Особое внимание: граничные условия (`>`, `>=`, `<`, `<=`)
и наличие тестов на обе стороны границы. Возвращай findings с `file:line`.
Файлы не редактируй.
```

Проверка: «используй discount-policy-reviewer, проверь DiscountPolicy.java».
Subagent должен прокомментировать границу `>= 10` и упомянуть отсутствие
тестов на 9 и 11 элементов.

## Подсказка

Subagent стартует без истории родителя. Если зовёте на конкретные файлы —
назовите их в промпте, иначе он не будет знать, где искать.
