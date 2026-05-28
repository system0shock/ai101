# 06. Subagents

Цель: делегировать узкие read-only проверки именованным субагентам.

Fork-субагенты отключены. Не вызывайте `Task` без поля `subagent_type`.

## Конкретная цель
<!-- concrete-goal -->

Получить объединенный отчет из двух named subagents: один проверяет контракт скидки, второй проверяет тестовое покрытие. Итоговый отчет должен содержать два evidence-блока и одно решение, которое принимает главный агент.

## Документация
<!-- docs-links -->

- Official Qwen Code Subagents: https://qwenlm.github.io/qwen-code-docs/en/users/features/sub-agents/
- Локальная справка: `../../.gigacode/skills/qwen-code-helper/references/mcp-subagents.md`

## Базовое задание

Вызовите `Task(subagent_type="code-reviewer", prompt="проверь публичный контракт OrderService, выводы с file:line")` и `Task(subagent_type="test-investigator", prompt="найди тесты и сценарии, которые затрагивает изменение скидки")`.

## Параллельное упражнение

Попросите главного агента запустить два независимых именованных subagents параллельно, если среда поддерживает parallel tool calls: `code-reviewer` проверяет контракт, `test-investigator` проверяет покрытие. Оба работают read-only, результаты объединяет главный агент, fork не используется.

## Самостоятельно

Создайте named subagent `discount-policy-reviewer`: `name`, `description`, read-only `tools` allowlist, `approvalMode: plan`, prompt с требованием evidence. Затем сформулируйте вызов через `subagent_type`.

## Подсказка для самостоятельной части
<!-- self-hint -->

Скопируйте `.gigacode/agents/code-reviewer.md` и сузьте ответственность до скидок. В prompt для вызова передайте пути `DiscountPolicy.java`, `OrderService.java`, `OrderServiceTest.java`, потому что named subagent стартует без истории родителя. Успех: subagent возвращает file:line evidence и не предлагает править файлы сам.

