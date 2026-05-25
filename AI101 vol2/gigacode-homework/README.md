# Домашнее задание AI101 vol.2: GigaCode tools

Этот мини-репозиторий помогает попробовать основные инструменты GigaCode после презентации:

- Commands
- Tools
- Skills
- Hooks
- MCP
- Subagents

В комплекте два режима:

- `developer-track/` — задания для разработчиков на небольшом JVM-проекте.
- `analyst-track/` — задания для аналитиков на документации.

## Требования

- Установленный GigaCode CLI.
- JDK 17 или новее для режима разработчика.
- Python 3.10 или новее для optional hook-упражнения.
- Терминал PowerShell, Bash или совместимый shell.

Проверка окружения:

```bash
java -version
gigacode --version
```

## Как проходить

1. Откройте эту папку в терминале.
2. Запустите GigaCode CLI из корня `gigacode-homework/`.
3. Выберите режим:
   - разработчики начинают с `developer-track/README.md`;
   - аналитики начинают с `analyst-track/README.md`.
4. Идите по заданиям выбранного режима: `developer-track/tasks/01-commands.md` ... `developer-track/tasks/06-subagents.md` или `analyst-track/tasks/01-commands.md` ... `analyst-track/tasks/06-subagents.md`.
5. После каждого задания сверяйтесь с expected outputs выбранного режима: `developer-track/expected/` или `analyst-track/expected/`, и checklist.

## Правило домашки

Не просите агента сразу переписать все. Сначала дайте ему контекст, попросите исследовать факты, затем разрешайте изменения.
