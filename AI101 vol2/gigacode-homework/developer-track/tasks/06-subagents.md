# 06. Subagents

Цель: делегировать узкие read-only проверки именованным субагентам.

Fork-субагенты отключены. Не вызывайте `Task` без поля `subagent_type`.

## Базовое задание

Вызовите `Task(subagent_type="code-reviewer", prompt="проверь публичный контракт OrderService, выводы с file:line")` и `Task(subagent_type="test-investigator", prompt="найди тесты и сценарии, которые затрагивает изменение скидки")`.

## Параллельное упражнение

Попросите главного агента запустить два независимых именованных subagents параллельно, если среда поддерживает parallel tool calls: `code-reviewer` проверяет контракт, `test-investigator` проверяет покрытие. Оба работают read-only, результаты объединяет главный агент, fork не используется.

## Самостоятельно

Напишите своего именованного subagent: `name`, `description`, явный `tools` allowlist, `approvalMode: plan`, prompt с требованием evidence. Затем сформулируйте вызов через `subagent_type`.

