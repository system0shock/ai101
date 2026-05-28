# 06. Subagents

Цель: разделить анализ между именованными субагентами.

Fork-субагенты отключены. Используйте только `subagent_type`.

## Конкретная цель
<!-- concrete-goal -->

Получить финальное решение по release notes из двух named subagents: `doc-analyst` находит противоречия в источниках, `consistency-reviewer` проверяет итоговую формулировку. Главный агент объединяет результаты в один список правок.

## Документация
<!-- docs-links -->

- Official Qwen Code Subagents: https://qwenlm.github.io/qwen-code-docs/en/users/features/sub-agents/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/mcp-subagents.md`

## Базовое задание

Вызовите `Task(subagent_type="doc-analyst", prompt="найди противоречия в analyst-track/docs, выводы с file:line")` и `Task(subagent_type="consistency-reviewer", prompt="проверь, что release-notes не обещает больше, чем PRD")`.

## Параллельное упражнение

Попросите главного агента параллельно вызвать двух именованных subagents, если среда поддерживает parallel tool calls: `doc-analyst` ищет противоречия, `consistency-reviewer` проверяет финальную формулировку. Оба read-only, главный агент объединяет результаты, fork не используется.

## Самостоятельно

Создайте subagent `legal-constraints-reviewer`: `name`, `description`, read-only `tools` allowlist, `approvalMode: plan`, prompt с требованием источников.

## Подсказка для самостоятельной части
<!-- self-hint -->

Сузьте subagent до одной роли: "проверяет юридические и регуляторные ограничения кредитного продукта". Вызов через `subagent_type` должен передавать пути `prd.md`, `stakeholder-notes.md`, `faq.md`, `release-notes.md` и требовать вывод `finding -> source -> recommended wording`. Успех: subagent находит нарушение требования юристов по сроку одобрения и не спорит с маркетинговыми пожеланиями без источника.
