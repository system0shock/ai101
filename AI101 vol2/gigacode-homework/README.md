# Домашнее задание AI101 vol.2: GigaCode tools

Практический комплект к лекции про команды, tools, skills, hooks, MCP и субагентов.

## Что такое GigaCode

GigaCode — корпоративный форк Qwen Code. API и концепции те же, но конфигурация лежит в
`.gigacode/` вместо `.qwen/`. Если видите расхождение с официальной документацией Qwen Code —
уточните у qwen-code-helper, это может быть локальное ограничение.

## Что потребуется

| Трек | Нужно |
|---|---|
| Оба | GigaCode CLI, Python 3.9+ (для hooks) |
| Developer | Java 17+, Gradle (можно через `./gradlew`) |
| Analyst | ничего дополнительного |

## Как проходить

1. Откройте терминал в `gigacode-homework/`.
2. Запустите GigaCode CLI командой `gigacode` (или `gc`).
3. Выберите трек: `developer-track/` или `analyst-track/`.
4. Идите по заданиям `tasks/01-commands.md` ... `tasks/06-subagents.md`.
5. После каждого задания сверьтесь с `shared/checklists/exercise-done.md`.

Один трек — примерно 60–90 минут.

## Где набирать команды

`/tools`, `/skills`, `@path`, `!shell` — всё это вводится в строку чата GigaCode CLI,
не в системный терминал. Терминал нужен только для `.\scripts\verify-kit.ps1`.

## Если что-то непонятно

Попросите GigaCode применить skill `qwen-code-helper`. Например:
> Я не понимаю, почему hook не срабатывает. Применить qwen-code-helper.

Fork-субагенты в этом комплекте отключены. Для делегирования используйте только
именованных subagents через `subagent_type`.

## Проверка структуры кита

```powershell
.\scripts\verify-kit.ps1
```

Скрипт проверяет, что все файлы на месте и структура заданий корректна.
Он не оценивает ваши ответы — только целостность кита.
