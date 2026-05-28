# 06. Subagents

Цель: разделить анализ между именованными субагентами.

Fork-субагенты отключены. Используйте только `subagent_type`.

## Базовое задание

Вызовите `Task(subagent_type="doc-analyst", prompt="найди противоречия в analyst-track/docs, выводы с file:line")` и `Task(subagent_type="consistency-reviewer", prompt="проверь, что release-notes не обещает больше, чем PRD")`.

## Параллельное упражнение

Попросите главного агента параллельно вызвать двух именованных subagents, если среда поддерживает parallel tool calls: `doc-analyst` ищет противоречия, `consistency-reviewer` проверяет финальную формулировку. Оба read-only, главный агент объединяет результаты, fork не используется.

## Самостоятельно

Напишите своего subagent для проверки требований: `name`, `description`, read-only `tools` allowlist, `approvalMode: plan`, prompt с требованием источников.

