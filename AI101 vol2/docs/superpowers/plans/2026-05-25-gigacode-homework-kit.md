# GigaCode Homework Kit Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Собрать скачиваемый мини-репозиторий `gigacode-homework/` с двумя русскоязычными режимами: разработчик на Java/Kotlin/JVM и аналитик на документации.

**Architecture:** Комплект лежит как отдельная папка внутри `AI101 vol2/` и не меняет существующую презентацию. Корень содержит общие правила GigaCode, `.gigacode/` активы и быстрый старт; `developer-track/` содержит JVM-проект с намеренно падающим JUnit-тестом; `analyst-track/` содержит документы с намеренными противоречиями и заданиями на анализ.

**Tech Stack:** Markdown на русском, GigaCode conventions (`GIGACODE.md`, `.gigacode/`), Java 17, JUnit Platform Console Standalone, PowerShell/Bash scripts, Python 3 для optional hook-примера.

---

## File Structure

Создать новую папку `AI101 vol2/gigacode-homework/`.

```text
gigacode-homework/
  README.md
  README-quickstart.md
  GIGACODE.md
  .gitignore
  .gigacode/
    settings.example.json
    commands/
      review-changes.md
      summarize-context.md
      write-handoff.md
    skills/
      code-review/SKILL.md
      doc-review/SKILL.md
      evidence-first/SKILL.md
    agents/
      code-reviewer.md
      consistency-reviewer.md
      doc-analyst.md
      test-investigator.md
    hooks/
      protect_sources.py
      README.md
  developer-track/
    README.md
    app/
      src/main/java/ru/ai101/gigacode/shop/
        CartItem.java
        DiscountPolicy.java
        OrderService.java
      src/test/java/ru/ai101/gigacode/shop/
        DiscountPolicyTest.java
        OrderServiceTest.java
    docs/
      code-standards.md
      investigation-template.md
    lib/
      README.md
    scripts/
      run-tests.ps1
      run-tests.sh
    tasks/
      01-commands.md
      02-tools.md
      03-skills.md
      04-hooks.md
      05-mcp.md
      06-subagents.md
    expected/
      baseline-test-output.md
      bugfix-summary.md
      review-summary.md
  analyst-track/
    README.md
    docs/
      faq.md
      prd.md
      release-notes.md
      stakeholder-notes.md
    tasks/
      01-commands.md
      02-tools.md
      03-skills.md
      04-hooks.md
      05-mcp.md
      06-subagents.md
    expected/
      contradiction-report.md
      prd-clean-section.md
      stakeholder-summary.md
    checklists/
      evidence-checklist.md
  shared/
    checklists/
      exercise-done.md
    mcp/
      local-knowledge-server.example.json
      README.md
    references/
      commands-cheatsheet.md
      tool-use-patterns.md
```

Boundary decisions:

- Root files explain how to start and which track to choose.
- `.gigacode/` contains reusable behavior and examples shared by both tracks.
- Developer track is runnable and intentionally starts with one failing test.
- Analyst track is document-only and intentionally starts with contradictions.
- Shared references are short Russian cheatsheets used by both tracks.

---

### Task 1: Root Homework Scaffold

**Files:**
- Create: `AI101 vol2/gigacode-homework/README.md`
- Create: `AI101 vol2/gigacode-homework/README-quickstart.md`
- Create: `AI101 vol2/gigacode-homework/GIGACODE.md`
- Create: `AI101 vol2/gigacode-homework/.gitignore`
- Create: `AI101 vol2/gigacode-homework/shared/checklists/exercise-done.md`
- Create: `AI101 vol2/gigacode-homework/shared/references/commands-cheatsheet.md`
- Create: `AI101 vol2/gigacode-homework/shared/references/tool-use-patterns.md`

- [ ] **Step 1: Create `README.md`**

Content:

```markdown
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
4. Идите по заданиям `tasks/01-commands.md` ... `tasks/06-subagents.md`.
5. После каждого задания сверяйтесь с `expected/` и checklist.

## Правило домашки

Не просите агента сразу переписать все. Сначала дайте ему контекст, попросите исследовать факты, затем разрешайте изменения.
```

- [ ] **Step 2: Create `README-quickstart.md`**

Content:

```markdown
# Быстрый старт

## Разработчик

```bash
cd developer-track
./scripts/run-tests.sh
```

На Windows:

```powershell
cd developer-track
.\scripts\run-tests.ps1
```

Первый прогон должен показать один падающий тест. Это часть задания.

Затем откройте GigaCode из корня комплекта и начните с:

```text
@developer-track/docs/code-standards.md
@developer-track/tasks/01-commands.md
Прочитай задание и предложи первый безопасный шаг.
```

## Аналитик

Откройте GigaCode из корня комплекта и начните с:

```text
@analyst-track/tasks/01-commands.md
@analyst-track/docs/prd.md
Прочитай задание и предложи первый безопасный шаг.
```

## Что сдавать самому себе

После каждого задания сохраните короткую заметку:

- какой контекст был добавлен;
- какие tools использовал агент;
- что изменилось;
- чем вы проверили результат.
```

- [ ] **Step 3: Create `GIGACODE.md`**

Content:

```markdown
# GigaCode project instructions

Ты помогаешь участнику пройти домашнее задание AI101 vol.2.

## Общие правила

- Отвечай на русском.
- Сначала исследуй контекст, потом предлагай изменения.
- Не меняй файлы, пока не объяснил, какие именно файлы будут затронуты.
- Для задач разработки сначала запускай или проси запустить релевантную проверку.
- Для задач аналитика опирайся на цитируемые факты из документов.
- Используй только GigaCode project paths из этого комплекта.

## Формат полезного ответа

Когда задача требует результата, используй структуру:

1. Что проверено.
2. Что найдено.
3. Что предлагается изменить.
4. Как проверить результат.
```

- [ ] **Step 4: Create `.gitignore`**

Content:

```gitignore
build/
out/
target/
.gradle/
.idea/
*.class
*.log
*.tmp
```

- [ ] **Step 5: Create shared checklist and references**

Create `shared/checklists/exercise-done.md`:

```markdown
# Самопроверка упражнения

- Я добавил в контекст только нужные файлы.
- Я понимаю, какие tools использовал агент.
- Я видел evidence: вывод тестов, список найденных документов или конкретные строки.
- Я могу объяснить, почему изменение безопасно.
- Я сохранил короткую заметку о результате.
```

Create `shared/references/commands-cheatsheet.md`:

```markdown
# Commands: краткая шпаргалка

- `/plan` — перейти в режим планирования или запустить задачу в plan mode.
- `/summary` — получить summary проекта или разговора.
- `/compress` — сжать историю для экономии контекста.
- `/btw` — задать боковой вопрос без остановки основного разговора.
- `/memory`, `/remember`, `/forget`, `/dream` — работа с памятью, если включена в вашей версии GigaCode.
- `@path/to/file.md` — добавить файл в контекст.
- `@path/to/directory` — добавить директорию в контекст осторожно.
- `!command` — выполнить shell-команду.
```

Create `shared/references/tool-use-patterns.md`:

```markdown
# Tool use patterns

## Хороший порядок

1. Explore: найти релевантные файлы.
2. Verify: прочитать факты и запустить проверку.
3. Edit: внести маленькое изменение.
4. Verify again: повторить проверку.

## Плохой порядок

1. Сразу переписать файл.
2. Не показать evidence.
3. Не запускать проверку.
4. Смешать несколько независимых изменений.
```

- [ ] **Step 6: Verify root scaffold**

Run:

```powershell
Get-ChildItem -Recurse .\gigacode-homework | Select-Object -First 20
```

Expected: command lists root files and `shared/` files without errors.

- [ ] **Step 7: Commit root scaffold**

```bash
git add "AI101 vol2/gigacode-homework/README.md" "AI101 vol2/gigacode-homework/README-quickstart.md" "AI101 vol2/gigacode-homework/GIGACODE.md" "AI101 vol2/gigacode-homework/.gitignore" "AI101 vol2/gigacode-homework/shared"
git commit -m "Add GigaCode homework scaffold"
```

---

### Task 2: Shared GigaCode Assets

**Files:**
- Create: `AI101 vol2/gigacode-homework/.gigacode/settings.example.json`
- Create: `AI101 vol2/gigacode-homework/.gigacode/commands/review-changes.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/commands/summarize-context.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/commands/write-handoff.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/skills/code-review/SKILL.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/skills/doc-review/SKILL.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/skills/evidence-first/SKILL.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/agents/code-reviewer.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/agents/test-investigator.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/agents/doc-analyst.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/agents/consistency-reviewer.md`
- Create: `AI101 vol2/gigacode-homework/.gigacode/hooks/protect_sources.py`
- Create: `AI101 vol2/gigacode-homework/.gigacode/hooks/README.md`
- Create: `AI101 vol2/gigacode-homework/shared/mcp/local-knowledge-server.example.json`
- Create: `AI101 vol2/gigacode-homework/shared/mcp/README.md`

- [ ] **Step 1: Create settings example**

Content for `.gigacode/settings.example.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "python .gigacode/hooks/protect_sources.py"
      }
    ]
  },
  "mcpServers": {
    "local-knowledge": {
      "command": "python",
      "args": ["shared/mcp/local_knowledge_server.py"],
      "includeTools": ["search_notes", "get_note"],
      "excludeTools": ["write_note"],
      "timeout": 600000
    }
  }
}
```

- [ ] **Step 2: Create custom commands**

Content for `.gigacode/commands/summarize-context.md`:

```markdown
---
description: Сжать добавленный контекст в проверяемое summary
---

Суммируй текущий контекст на русском.

Формат:

1. Какие файлы или источники видны в контексте.
2. Ключевые факты.
3. Неясности и противоречия.
4. Что нужно проверить перед изменениями.

Не придумывай факты, которых нет в контексте.
```

Content for `.gigacode/commands/review-changes.md`:

```markdown
---
description: Проверить изменения перед сдачей упражнения
---

Проверь текущие изменения как reviewer.

Сфокусируйся на:

- рисках поведения;
- пропущенных проверках;
- противоречиях с заданием;
- лишних изменениях.

Ответ дай на русском в формате:

1. Findings.
2. Tests or checks.
3. Next action.
```

Content for `.gigacode/commands/write-handoff.md`:

```markdown
---
description: Написать короткий handoff по упражнению
---

Составь handoff по текущему упражнению.

Включи:

- цель упражнения;
- что было изменено или найдено;
- какие файлы затронуты;
- какие проверки выполнены;
- что осталось проверить вручную.
```

- [ ] **Step 3: Create skills**

Content for `.gigacode/skills/code-review/SKILL.md`:

```markdown
---
name: code-review
description: Использовать для ревью кода, тестов и маленьких JVM-изменений в developer-track
---

# Code Review Skill

Проверяй изменение как практичный reviewer.

## Порядок

1. Найди, какие файлы изменены.
2. Проверь, есть ли evidence: тест, вывод команды или точная ссылка на код.
3. Ищи поведенческие ошибки, лишний scope и отсутствие проверки.
4. Не предлагай большой рефакторинг, если задание просит маленькое изменение.

## Формат ответа

- Findings
- Проверки
- Риск
- Минимальное следующее действие
```

Content for `.gigacode/skills/doc-review/SKILL.md`:

```markdown
---
name: doc-review
description: Использовать для анализа PRD, FAQ, release notes и stakeholder notes в analyst-track
---

# Documentation Review Skill

Проверяй документы на консистентность и применимость.

## Порядок

1. Назови документы, на которые опираешься.
2. Выпиши факты с короткими ссылками на файлы.
3. Найди противоречия, неоднозначности и недостающие acceptance criteria.
4. Предлагай правки только после evidence.

## Формат ответа

- Evidence
- Противоречия
- Недостающие решения
- Предложенная правка
```

Content for `.gigacode/skills/evidence-first/SKILL.md`:

```markdown
---
name: evidence-first
description: Использовать, когда задача требует сначала собрать факты, а потом менять код или документы
disable-model-invocation: true
---

# Evidence First Skill

Этот skill вызывается явно, когда нужно принудительно отделить исследование от изменения.

## Правило

Сначала покажи evidence, затем план изменения, затем само изменение.

## Минимальный evidence

- Для кода: команда проверки или конкретные строки исходника.
- Для документации: файл и смысловой фрагмент, на который опирается вывод.
- Для MCP: имя tool и факт, который он вернул.
```

- [ ] **Step 4: Create agents**

Content for `.gigacode/agents/code-reviewer.md`:

```markdown
---
name: code-reviewer
description: Named agent для focused code review в developer-track
model: inherit
approvalMode: plan
tools:
  - read_file
  - grep_search
  - glob
disallowedTools:
  - write_file
  - edit
---

Ты read-only reviewer. Проверяй код и тесты, но не меняй файлы.

Ответ:

1. Findings.
2. Evidence.
3. Риск.
4. Рекомендация.
```

Content for `.gigacode/agents/test-investigator.md`:

```markdown
---
name: test-investigator
description: Named agent для расследования падающих JVM-тестов
model: inherit
approvalMode: plan
tools:
  - read_file
  - grep_search
  - glob
  - run_shell_command
disallowedTools:
  - write_file
  - edit
---

Ты расследуешь падение тестов. Не меняй файлы.

Порядок:

1. Найди команду запуска тестов.
2. Прочитай падающий тест.
3. Найди код, который проверяется.
4. Объясни минимальную причину падения.
```

Content for `.gigacode/agents/doc-analyst.md`:

```markdown
---
name: doc-analyst
description: Named agent для анализа одного документа в analyst-track
model: inherit
approvalMode: plan
tools:
  - read_file
  - grep_search
  - glob
disallowedTools:
  - write_file
  - edit
---

Ты аналитик документации. Работай только с evidence из файлов.

Ответ:

1. Суть документа.
2. Факты.
3. Риски неоднозначности.
4. Вопросы к владельцу продукта.
```

Content for `.gigacode/agents/consistency-reviewer.md`:

```markdown
---
name: consistency-reviewer
description: Named agent для поиска противоречий между несколькими документами
model: inherit
approvalMode: plan
tools:
  - read_file
  - grep_search
  - glob
disallowedTools:
  - write_file
  - edit
---

Ты ищешь противоречия между документами.

Для каждого противоречия укажи:

- документ A;
- документ B;
- конфликтующее утверждение;
- почему это важно;
- какой вопрос нужно решить.
```

- [ ] **Step 5: Create hook example**

Content for `.gigacode/hooks/protect_sources.py`:

```python
#!/usr/bin/env python3
import json
import sys

PROTECTED_PARTS = [
    "analyst-track/docs/stakeholder-notes.md",
    "developer-track/docs/code-standards.md",
]


def main() -> int:
    raw = sys.stdin.read()
    try:
        payload = json.loads(raw) if raw.strip() else {}
    except json.JSONDecodeError:
        print("Не удалось прочитать JSON hook payload", file=sys.stderr)
        return 2

    path = str(payload.get("path") or payload.get("file_path") or "")
    normalized = path.replace("\\", "/")

    for protected in PROTECTED_PARTS:
        if protected in normalized:
            response = {
                "permissionDecision": "deny",
                "permissionDecisionReason": f"Файл {protected} защищен в учебном комплекте. Создайте заметку в expected/ или предложите patch в ответе.",
            }
            print(json.dumps(response, ensure_ascii=False))
            return 0

    response = {
        "permissionDecision": "ask",
        "permissionDecisionReason": "Учебный hook просит подтвердить изменение файла.",
    }
    print(json.dumps(response, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
```

Content for `.gigacode/hooks/README.md`:

```markdown
# Hook example

`protect_sources.py` показывает учебный PreToolUse hook.

Семантика:

- exit code `0` — hook успешно вернул JSON;
- exit code `2` — blocking error, stderr передается агенту;
- другой exit code — non-blocking error, обычно виден только в debug mode.

Для PreToolUse ответ должен содержать:

- `permissionDecision`: `allow`, `deny` или `ask`;
- `permissionDecisionReason`: понятное объяснение решения.

Hook защищает исходные материалы задания и просит подтверждение для остальных изменений.
```

- [ ] **Step 6: Create MCP reference**

Content for `shared/mcp/local-knowledge-server.example.json`:

```json
{
  "name": "local-knowledge",
  "purpose": "Read-only пример MCP-сервера для домашнего задания",
  "tools": [
    {
      "name": "search_notes",
      "mode": "read-only"
    },
    {
      "name": "get_note",
      "mode": "read-only"
    },
    {
      "name": "write_note",
      "mode": "excluded"
    }
  ],
  "rules": {
    "includeTools": ["search_notes", "get_note"],
    "excludeTools": ["write_note"],
    "excludeToolsPrecedence": true,
    "defaultTimeoutMs": 600000
  }
}
```

Content for `shared/mcp/README.md`:

```markdown
# MCP exercise reference

В этом комплекте MCP не требует внешних credentials.

Что нужно понять:

- MCP server добавляет внешние tools и sources.
- `includeTools` открывает только выбранные tools.
- `excludeTools` имеет приоритет над `includeTools`.
- Permissions могут блокировать `mcp__server__tool_name` или весь `mcp__server`.
- `/mcp auth` используется для OAuth, если remote MCP требует авторизацию.
- Default timeout для MCP server: `600000` ms.

В заданиях MCP используется как read-only концепция, чтобы не расширять blast radius.
```

- [ ] **Step 7: Verify assets**

Run:

```powershell
Get-ChildItem -Recurse .\gigacode-homework\.gigacode | Select-Object FullName
```

Expected: command lists commands, skills, agents, hooks, and `settings.example.json`.

- [ ] **Step 8: Commit shared GigaCode assets**

```bash
git add "AI101 vol2/gigacode-homework/.gigacode" "AI101 vol2/gigacode-homework/shared/mcp"
git commit -m "Add shared GigaCode assets"
```

---

### Task 3: Developer JVM Project

**Files:**
- Create: `AI101 vol2/gigacode-homework/developer-track/README.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/app/src/main/java/ru/ai101/gigacode/shop/CartItem.java`
- Create: `AI101 vol2/gigacode-homework/developer-track/app/src/main/java/ru/ai101/gigacode/shop/DiscountPolicy.java`
- Create: `AI101 vol2/gigacode-homework/developer-track/app/src/main/java/ru/ai101/gigacode/shop/OrderService.java`
- Create: `AI101 vol2/gigacode-homework/developer-track/app/src/test/java/ru/ai101/gigacode/shop/DiscountPolicyTest.java`
- Create: `AI101 vol2/gigacode-homework/developer-track/app/src/test/java/ru/ai101/gigacode/shop/OrderServiceTest.java`
- Create: `AI101 vol2/gigacode-homework/developer-track/docs/code-standards.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/docs/investigation-template.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/lib/README.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/scripts/run-tests.ps1`
- Create: `AI101 vol2/gigacode-homework/developer-track/scripts/run-tests.sh`
- Create or download: `AI101 vol2/gigacode-homework/developer-track/lib/junit-platform-console-standalone-1.10.2.jar`

- [ ] **Step 1: Create developer README**

Content:

```markdown
# Режим для разработчиков

Вы работаете с маленьким JVM-проектом интернет-заказа.

Цель: попробовать GigaCode на реальной задаче разработки без большого setup.

## Проверка

Windows:

```powershell
.\scripts\run-tests.ps1
```

Linux/macOS:

```bash
./scripts/run-tests.sh
```

Стартовое состояние содержит один падающий тест. Это намеренно: он нужен для упражнения по tools.

## Порядок

1. `tasks/01-commands.md`
2. `tasks/02-tools.md`
3. `tasks/03-skills.md`
4. `tasks/04-hooks.md`
5. `tasks/05-mcp.md`
6. `tasks/06-subagents.md`
```

- [ ] **Step 2: Create Java source files**

Content for `CartItem.java`:

```java
package ru.ai101.gigacode.shop;

public record CartItem(String sku, int unitPriceRub, int quantity) {
    public CartItem {
        if (sku == null || sku.isBlank()) {
            throw new IllegalArgumentException("sku must not be blank");
        }
        if (unitPriceRub < 0) {
            throw new IllegalArgumentException("unitPriceRub must be non-negative");
        }
        if (quantity <= 0) {
            throw new IllegalArgumentException("quantity must be positive");
        }
    }

    public int subtotalRub() {
        return unitPriceRub * quantity;
    }
}
```

Content for `DiscountPolicy.java`:

```java
package ru.ai101.gigacode.shop;

public final class DiscountPolicy {
    public int applyPromo(int subtotalRub, String promoCode) {
        if (subtotalRub < 0) {
            throw new IllegalArgumentException("subtotalRub must be non-negative");
        }
        if (promoCode == null || promoCode.isBlank()) {
            return subtotalRub;
        }
        if ("WELCOME10".equalsIgnoreCase(promoCode)) {
            return Math.max(0, subtotalRub - 10);
        }
        return subtotalRub;
    }
}
```

The `WELCOME10` behavior is intentionally wrong. The failing test expects a 10 percent discount, not 10 rubles.

Content for `OrderService.java`:

```java
package ru.ai101.gigacode.shop;

import java.util.List;

public final class OrderService {
    private static final int FREE_SHIPPING_THRESHOLD_RUB = 1_000;
    private static final int SHIPPING_FEE_RUB = 199;

    private final DiscountPolicy discountPolicy;

    public OrderService(DiscountPolicy discountPolicy) {
        this.discountPolicy = discountPolicy;
    }

    public int totalRub(List<CartItem> items, String promoCode) {
        int subtotal = items.stream()
                .mapToInt(CartItem::subtotalRub)
                .sum();
        int discounted = discountPolicy.applyPromo(subtotal, promoCode);
        int shipping = discounted >= FREE_SHIPPING_THRESHOLD_RUB ? 0 : SHIPPING_FEE_RUB;
        return discounted + shipping;
    }
}
```

- [ ] **Step 3: Create JUnit tests**

Content for `DiscountPolicyTest.java`:

```java
package ru.ai101.gigacode.shop;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class DiscountPolicyTest {
    private final DiscountPolicy policy = new DiscountPolicy();

    @Test
    void welcomePromoAppliesTenPercentDiscount() {
        assertEquals(900, policy.applyPromo(1000, "WELCOME10"));
    }

    @Test
    void blankPromoKeepsSubtotal() {
        assertEquals(500, policy.applyPromo(500, ""));
    }
}
```

Content for `OrderServiceTest.java`:

```java
package ru.ai101.gigacode.shop;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class OrderServiceTest {
    @Test
    void totalIncludesShippingWhenDiscountedTotalBelowThreshold() {
        OrderService service = new OrderService(new DiscountPolicy());

        int total = service.totalRub(
                List.of(new CartItem("book", 500, 1)),
                ""
        );

        assertEquals(699, total);
    }
}
```

- [ ] **Step 4: Download local JUnit console jar**

Run from `AI101 vol2/gigacode-homework/developer-track`:

```powershell
New-Item -ItemType Directory -Force -Path .\lib
Invoke-WebRequest -Uri "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.2/junit-platform-console-standalone-1.10.2.jar" -OutFile ".\lib\junit-platform-console-standalone-1.10.2.jar"
```

Expected: `lib/junit-platform-console-standalone-1.10.2.jar` exists and is larger than 1 MB.

If network is unavailable during implementation, stop and ask for approval to use network access. Do not replace JUnit with a custom test framework.

- [ ] **Step 5: Create lib README**

Content:

```markdown
# Локальные test dependencies

`junit-platform-console-standalone-1.10.2.jar` лежит в репозитории, чтобы участникам не нужен был Maven Central во время домашки.

Источник:

```text
https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.2/junit-platform-console-standalone-1.10.2.jar
```
```

- [ ] **Step 6: Create test scripts**

Content for `scripts/run-tests.ps1`:

```powershell
$ErrorActionPreference = "Stop"

$Root = Resolve-Path (Join-Path $PSScriptRoot "..")
$App = Join-Path $Root "app"
$Build = Join-Path $Root "build"
$MainClasses = Join-Path $Build "classes-main"
$TestClasses = Join-Path $Build "classes-test"
$Jar = Join-Path $Root "lib/junit-platform-console-standalone-1.10.2.jar"

if (!(Test-Path $Jar)) {
    Write-Error "Не найден JUnit jar: $Jar"
}

Remove-Item -Recurse -Force $Build -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $MainClasses | Out-Null
New-Item -ItemType Directory -Force -Path $TestClasses | Out-Null

$MainSources = Get-ChildItem -Recurse -Path (Join-Path $App "src/main/java") -Filter "*.java" | ForEach-Object { $_.FullName }
$TestSources = Get-ChildItem -Recurse -Path (Join-Path $App "src/test/java") -Filter "*.java" | ForEach-Object { $_.FullName }

javac -encoding UTF-8 -d $MainClasses $MainSources
javac -encoding UTF-8 -cp "$Jar;$MainClasses" -d $TestClasses $TestSources
java -jar $Jar execute --class-path "$MainClasses;$TestClasses" --scan-class-path
```

Content for `scripts/run-tests.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP="$ROOT/app"
BUILD="$ROOT/build"
MAIN_CLASSES="$BUILD/classes-main"
TEST_CLASSES="$BUILD/classes-test"
JAR="$ROOT/lib/junit-platform-console-standalone-1.10.2.jar"

if [[ ! -f "$JAR" ]]; then
  echo "Не найден JUnit jar: $JAR" >&2
  exit 1
fi

rm -rf "$BUILD"
mkdir -p "$MAIN_CLASSES" "$TEST_CLASSES"

mapfile -t MAIN_SOURCES < <(find "$APP/src/main/java" -name "*.java" -print)
mapfile -t TEST_SOURCES < <(find "$APP/src/test/java" -name "*.java" -print)

javac -encoding UTF-8 -d "$MAIN_CLASSES" "${MAIN_SOURCES[@]}"
javac -encoding UTF-8 -cp "$JAR:$MAIN_CLASSES" -d "$TEST_CLASSES" "${TEST_SOURCES[@]}"
java -jar "$JAR" execute --class-path "$MAIN_CLASSES:$TEST_CLASSES" --scan-class-path
```

- [ ] **Step 7: Create developer docs**

Content for `docs/code-standards.md`:

```markdown
# Code standards для developer-track

- Делайте маленькие изменения.
- Сначала воспроизведите проблему тестом.
- Не меняйте публичное поведение без evidence.
- Не меняйте protected docs: `developer-track/docs/code-standards.md`.
- В handoff указывайте команду проверки и результат.
```

Content for `docs/investigation-template.md`:

```markdown
# Шаблон расследования

## Симптом

Какая проверка падает.

## Evidence

Команда и ключевые строки вывода.

## Причина

Минимальное объяснение на основе кода.

## Исправление

Какой файл и какая логика меняются.

## Проверка

Команда, которая подтверждает результат.
```

- [ ] **Step 8: Run baseline test and verify intended failure**

Run:

```powershell
cd "AI101 vol2/gigacode-homework/developer-track"
.\scripts\run-tests.ps1
```

Expected: command exits non-zero and output includes `welcomePromoAppliesTenPercentDiscount()` plus expected `900` and actual `990`.

- [ ] **Step 9: Commit developer JVM project**

```bash
git add "AI101 vol2/gigacode-homework/developer-track/README.md" "AI101 vol2/gigacode-homework/developer-track/app" "AI101 vol2/gigacode-homework/developer-track/docs" "AI101 vol2/gigacode-homework/developer-track/lib" "AI101 vol2/gigacode-homework/developer-track/scripts"
git commit -m "Add developer JVM exercise project"
```

---

### Task 4: Developer Track Tasks And Expected Outputs

**Files:**
- Create: `AI101 vol2/gigacode-homework/developer-track/tasks/01-commands.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/tasks/02-tools.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/tasks/03-skills.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/tasks/04-hooks.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/tasks/05-mcp.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/tasks/06-subagents.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/expected/baseline-test-output.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/expected/bugfix-summary.md`
- Create: `AI101 vol2/gigacode-homework/developer-track/expected/review-summary.md`

- [ ] **Step 1: Create developer tasks**

Content for `tasks/01-commands.md`:

```markdown
# 01. Commands для разработчика

## Цель

Попробовать `@`, `!` и custom command на кодовой задаче.

## Шаги

1. Добавьте стандарт в контекст:

```text
@developer-track/docs/code-standards.md
```

2. Добавьте README режима:

```text
@developer-track/README.md
```

3. Запустите проверку через shell command:

```text
!cd developer-track && ./scripts/run-tests.sh
```

На Windows используйте:

```text
!cd developer-track; .\scripts\run-tests.ps1
```

4. Вызовите custom command:

```text
/summarize-context
```

## Ожидаемый результат

Агент должен увидеть, что есть один падающий тест, и не предлагать массовый rewrite.

## Самопроверка

- В контексте есть `code-standards.md`.
- Есть вывод тестов.
- Summary отделяет факты от предположений.
```

Content for `tasks/02-tools.md`:

```markdown
# 02. Tools для разработчика

## Цель

Попросить агента расследовать падающий тест по схеме explore -> verify -> edit.

## Prompt

```text
@developer-track/docs/investigation-template.md
Падает тест в developer-track. Сначала найди минимальную причину, затем предложи один маленький patch. Не меняй файлы, пока не покажешь evidence.
```

## Ожидаемый результат

Агент должен:

1. Найти `DiscountPolicyTest`.
2. Найти `DiscountPolicy`.
3. Объяснить, что `WELCOME10` должен быть скидкой 10%, а не 10 рублей.
4. Предложить заменить `subtotalRub - 10` на расчет 10%.

## Самопроверка

- Агент прочитал тест перед правкой.
- Изменение касается только `DiscountPolicy.java`.
- После изменения тесты проходят.
```

Content for `tasks/03-skills.md`:

```markdown
# 03. Skills для разработчика

## Цель

Использовать project skill для ревью маленького изменения.

## Prompt

```text
Используй skill code-review и проверь мое исправление DiscountPolicy.
```

## Ожидаемый результат

Ответ должен содержать:

- findings;
- evidence;
- команду проверки;
- остаточный риск.

## Самопроверка

- Skill не предлагает большой рефакторинг.
- Review ссылается на тест или код.
```

Content for `tasks/04-hooks.md`:

```markdown
# 04. Hooks для разработчика

## Цель

Посмотреть, как hook ограничивает risky edits.

## Шаги

1. Прочитайте `.gigacode/hooks/README.md`.
2. Сравните `.gigacode/settings.example.json` с текущими настройками GigaCode.
3. Попросите агента изменить `developer-track/docs/code-standards.md`.

## Ожидаемый результат

Hook должен объяснить, что protected-файл нельзя менять напрямую.

## Самопроверка

- Вы понимаете поля `permissionDecision` и `permissionDecisionReason`.
- Вы понимаете разницу exit code `0`, `2` и других кодов.
```

Content for `tasks/05-mcp.md`:

```markdown
# 05. MCP для разработчика

## Цель

Разобрать read-only MCP как внешний источник project facts.

## Шаги

1. Откройте `shared/mcp/README.md`.
2. Откройте `shared/mcp/local-knowledge-server.example.json`.
3. Попросите агента объяснить, какие tools доступны и какие заблокированы.

## Prompt

```text
@shared/mcp/README.md
@shared/mcp/local-knowledge-server.example.json
Объясни, какие MCP tools доступны агенту и почему write_note недоступен.
```

## Самопроверка

- Агент упомянул приоритет `excludeTools`.
- Агент не предлагает подключать внешний сервис.
```

Content for `tasks/06-subagents.md`:

```markdown
# 06. Subagents для разработчика

## Цель

Делегировать узкую проверку named agent.

## Prompt

```text
Запусти named agent test-investigator для расследования падающего теста. Передай ему только developer-track и попроси не менять файлы.
```

## Ожидаемый результат

Named agent должен вернуть read-only расследование.

## Самопроверка

- Named agent не меняет файлы.
- Ответ объясняет, что named agent блокирует parent conversation до завершения.
- Ответ объясняет, что named agent стартует без истории parent, поэтому ему нужен явный контекст.
```

- [ ] **Step 2: Create expected outputs**

Content for `expected/baseline-test-output.md`:

```markdown
# Baseline test output

Стартовый прогон должен падать на тесте:

```text
DiscountPolicyTest > welcomePromoAppliesTenPercentDiscount()
expected: <900> but was: <990>
```

Это намеренное состояние для упражнения `02-tools.md`.
```

Content for `expected/bugfix-summary.md`:

```markdown
# Expected bugfix summary

Минимальное исправление:

```java
if ("WELCOME10".equalsIgnoreCase(promoCode)) {
    return subtotalRub - (subtotalRub / 10);
}
```

После исправления команда проверки должна завершиться успешно:

```text
.\scripts\run-tests.ps1
```
```

Content for `expected/review-summary.md`:

```markdown
# Expected review summary

Хорошее review должно отметить:

- изменение ограничено `DiscountPolicy.java`;
- поведение подтверждено `DiscountPolicyTest`;
- shipping logic не затронута;
- ручная проверка не требуется, если все тесты проходят.
```

- [ ] **Step 3: Verify developer task paths**

Run:

```powershell
Select-String -Path ".\gigacode-homework\developer-track\tasks\*.md" -Pattern "developer-track/|shared/"
```

Expected: all referenced files exist in the mini-repository.

- [ ] **Step 4: Commit developer tasks**

```bash
git add "AI101 vol2/gigacode-homework/developer-track/tasks" "AI101 vol2/gigacode-homework/developer-track/expected"
git commit -m "Add developer homework tasks"
```

---

### Task 5: Analyst Track Documents, Tasks, And Expected Outputs

**Files:**
- Create: `AI101 vol2/gigacode-homework/analyst-track/README.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/docs/prd.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/docs/stakeholder-notes.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/docs/faq.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/docs/release-notes.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/tasks/01-commands.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/tasks/02-tools.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/tasks/03-skills.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/tasks/04-hooks.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/tasks/05-mcp.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/tasks/06-subagents.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/expected/contradiction-report.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/expected/prd-clean-section.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/expected/stakeholder-summary.md`
- Create: `AI101 vol2/gigacode-homework/analyst-track/checklists/evidence-checklist.md`

- [ ] **Step 1: Create analyst README**

Content:

```markdown
# Режим для аналитиков

Вы работаете с набором продуктовых документов.

Цель: попробовать GigaCode для анализа контекста, поиска противоречий и подготовки аккуратных правок.

Документы содержат намеренные расхождения. Не исправляйте их сразу: сначала соберите evidence.

Порядок:

1. `tasks/01-commands.md`
2. `tasks/02-tools.md`
3. `tasks/03-skills.md`
4. `tasks/04-hooks.md`
5. `tasks/05-mcp.md`
6. `tasks/06-subagents.md`
```

- [ ] **Step 2: Create source documents**

Content for `docs/prd.md`:

```markdown
# PRD: Экспорт отчетов

## Цель

Пользователь должен выгружать отчет по заказам из личного кабинета.

## Роли

- Менеджер может запускать экспорт.
- Администратор настраивает доступы.

## Формат

MVP поддерживает экспорт в CSV.

## Ограничения

- Максимальный период отчета: 90 дней.
- Файл хранится 7 дней после генерации.
- Уведомление отправляется на email после готовности файла.

## Acceptance criteria

- Пользователь видит кнопку "Экспорт".
- Система показывает статус подготовки файла.
- CSV открывается в табличном редакторе.
```

Content for `docs/stakeholder-notes.md`:

```markdown
# Stakeholder notes

Дата: 2026-05-20

- Бизнес просит XLSX в первом релизе, CSV считается запасным вариантом.
- Отчет нужен за 180 дней, иначе пользователи будут делать две выгрузки.
- Уведомление должно приходить в Telegram, email читают редко.
- Запуск экспорта должен быть доступен только администратору.
- Файл должен храниться 30 дней для повторного скачивания.
```

Content for `docs/faq.md`:

```markdown
# FAQ: Экспорт отчетов

## Кто может запускать экспорт?

Менеджер и администратор.

## Какой формат файла будет доступен?

CSV в первом релизе.

## За какой период можно выгрузить отчет?

До 90 дней.

## Как пользователь узнает, что файл готов?

В личном кабинете появится статус, отдельные уведомления не планируются.
```

Content for `docs/release-notes.md`:

```markdown
# Release notes draft

В релизе появится экспорт заказов в XLSX.

Доступ:

- администратор запускает экспорт;
- менеджер скачивает готовый файл.

Ограничения:

- период до 180 дней;
- хранение файла 7 дней;
- уведомление через email.
```

- [ ] **Step 3: Create analyst task files**

Content for `tasks/01-commands.md`:

```markdown
# 01. Commands для аналитика

## Цель

Попробовать `@`, `!` и custom command на документах.

## Шаги

```text
@analyst-track/docs/prd.md
@analyst-track/docs/faq.md
!dir analyst-track\docs
/summarize-context
```

Для Bash:

```text
!ls analyst-track/docs
```

## Ожидаемый результат

Агент должен кратко описать видимые документы и не делать правки.
```

Content for `tasks/02-tools.md`:

```markdown
# 02. Tools для аналитика

## Цель

Попросить агента найти противоречия между документами.

## Prompt

```text
@analyst-track/docs
Найди противоречия между PRD, FAQ, release notes и stakeholder notes. Сначала покажи evidence по файлам, затем предложи вопросы к владельцу продукта.
```

## Самопроверка

- Агент сравнил несколько документов.
- Ответ содержит конкретные пары конфликтующих утверждений.
- Агент не переписал PRD до согласования решений.
```

Content for `tasks/03-skills.md`:

```markdown
# 03. Skills для аналитика

## Цель

Использовать `doc-review` для анализа требований.

## Prompt

```text
Используй skill doc-review для проверки analyst-track/docs/prd.md и analyst-track/docs/stakeholder-notes.md.
```

## Ожидаемый результат

Ответ содержит evidence, противоречия, недостающие решения и предложенную правку.
```

Content for `tasks/04-hooks.md`:

```markdown
# 04. Hooks для аналитика

## Цель

Понять, как hook защищает source notes.

## Шаги

1. Прочитайте `.gigacode/hooks/README.md`.
2. Попросите агента изменить `analyst-track/docs/stakeholder-notes.md`.
3. Попросите агента вместо этого подготовить patch proposal в ответе.

## Самопроверка

- Source notes не изменены.
- Есть structured proposal для PRD или FAQ.
```

Content for `tasks/05-mcp.md`:

```markdown
# 05. MCP для аналитика

## Цель

Разобрать MCP как read-only источник знаний.

## Prompt

```text
@shared/mcp/README.md
@shared/mcp/local-knowledge-server.example.json
Объясни, как аналитик должен ограничить MCP tools для чтения требований.
```

## Самопроверка

- Ответ объясняет `includeTools`.
- Ответ объясняет приоритет `excludeTools`.
- Ответ не требует внешнего OAuth для этого упражнения.
```

Content for `tasks/06-subagents.md`:

```markdown
# 06. Subagents для аналитика

## Цель

Делегировать поиск противоречий named agent.

## Prompt

```text
Запусти named agent consistency-reviewer для analyst-track/docs. Передай ему задачу найти противоречия по формату, роли, периоду, хранению и уведомлениям.
```

## Ожидаемый результат

Agent возвращает список противоречий с evidence.

## Самопроверка

- Named agent получил явный scope.
- Ответ не предполагает, что named agent видел историю parent.
- Fork subagent упомянут как отдельный режим, если ваша версия CLI его поддерживает.
```

- [ ] **Step 4: Create expected outputs and checklist**

Content for `expected/contradiction-report.md`:

```markdown
# Expected contradiction report

Ключевые противоречия:

| Тема | Документ A | Документ B | Конфликт |
|---|---|---|---|
| Формат | `prd.md`: CSV | `stakeholder-notes.md`: XLSX | Нужно выбрать формат MVP |
| Период | `prd.md`: 90 дней | `stakeholder-notes.md`: 180 дней | Разный объем данных |
| Роль | `prd.md`: менеджер запускает | `stakeholder-notes.md`: только администратор | Разная модель доступа |
| Уведомление | `prd.md`: email | `faq.md`: уведомления не планируются | Разное ожидание пользователя |
| Хранение | `prd.md`: 7 дней | `stakeholder-notes.md`: 30 дней | Разный срок доступности файла |
```

Content for `expected/prd-clean-section.md`:

```markdown
# Expected PRD clean section

## Открытые решения

- Формат MVP: CSV или XLSX.
- Максимальный период отчета: 90 или 180 дней.
- Кто запускает экспорт: менеджер, администратор или обе роли.
- Канал уведомления: email, Telegram или только статус в кабинете.
- Срок хранения файла: 7 или 30 дней.
```

Content for `expected/stakeholder-summary.md`:

```markdown
# Expected stakeholder summary

Для запуска разработки нужно согласовать пять решений: формат файла, период отчета, роли доступа, канал уведомления и срок хранения файла. Сейчас документы противоречат друг другу, поэтому PRD нельзя считать готовым к реализации.
```

Content for `checklists/evidence-checklist.md`:

```markdown
# Evidence checklist

- Для каждого вывода указан файл.
- Для каждого противоречия указаны две стороны конфликта.
- Предложенные правки не удаляют stakeholder intent.
- Open questions отделены от подтвержденных фактов.
```

- [ ] **Step 5: Verify analyst paths**

Run:

```powershell
Select-String -Path ".\gigacode-homework\analyst-track\tasks\*.md" -Pattern "analyst-track/|shared/"
```

Expected: all referenced files exist in the mini-repository.

- [ ] **Step 6: Commit analyst track**

```bash
git add "AI101 vol2/gigacode-homework/analyst-track"
git commit -m "Add analyst documentation exercises"
```

---

### Task 6: Verification And Archive Readiness

**Files:**
- Create: `AI101 vol2/gigacode-homework/shared/checklists/final-verification.md`
- Create: `AI101 vol2/gigacode-homework/scripts/verify-kit.ps1`
- Create: `AI101 vol2/gigacode-homework/scripts/verify-kit.sh`

- [ ] **Step 1: Create final verification checklist**

Content for `shared/checklists/final-verification.md`:

```markdown
# Final verification checklist

- Все пользовательские Markdown-файлы написаны на русском.
- Participant-facing инструкции используют `.gigacode/` и `GIGACODE.md`.
- В participant-facing инструкциях нет upstream path names из Qwen Code.
- Developer baseline test падает ровно на `welcomePromoAppliesTenPercentDiscount`.
- Analyst expected report покрывает формат, период, роль, уведомление и хранение.
- Hook README объясняет `permissionDecision`, `permissionDecisionReason` и exit codes.
- MCP README объясняет `includeTools`, `excludeTools`, permissions, `/mcp auth` и timeout.
```

- [ ] **Step 2: Create verification scripts**

Content for `scripts/verify-kit.ps1`:

```powershell
$ErrorActionPreference = "Stop"

$Root = Resolve-Path (Join-Path $PSScriptRoot "..")

Write-Host "Проверка Qwen path leakage"
$Leak = Select-String -Path (Join-Path $Root "**/*.md") -Pattern "\.qwen/|QWEN.md" -ErrorAction SilentlyContinue
if ($Leak) {
    $Leak | ForEach-Object { Write-Host $_ }
    throw "Найдены Qwen-пути в participant-facing Markdown"
}

Write-Host "Проверка обязательных файлов"
$Required = @(
    "README.md",
    "README-quickstart.md",
    "GIGACODE.md",
    ".gigacode/settings.example.json",
    "developer-track/tasks/01-commands.md",
    "analyst-track/tasks/01-commands.md"
)

foreach ($Path in $Required) {
    $Full = Join-Path $Root $Path
    if (!(Test-Path $Full)) {
        throw "Не найден файл: $Path"
    }
}

Write-Host "Проверка завершена"
```

Content for `scripts/verify-kit.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Проверка Qwen path leakage"
if grep -R -n -E '\.qwen/|QWEN.md' "$ROOT" --include='*.md'; then
  echo "Найдены Qwen-пути в participant-facing Markdown" >&2
  exit 1
fi

echo "Проверка обязательных файлов"
for path in \
  "README.md" \
  "README-quickstart.md" \
  "GIGACODE.md" \
  ".gigacode/settings.example.json" \
  "developer-track/tasks/01-commands.md" \
  "analyst-track/tasks/01-commands.md"; do
  test -f "$ROOT/$path"
done

echo "Проверка завершена"
```

- [ ] **Step 3: Run markdown leakage check**

Run:

```powershell
cd "AI101 vol2/gigacode-homework"
.\scripts\verify-kit.ps1
```

Expected: `Проверка завершена`.

- [ ] **Step 4: Run developer baseline check**

Run:

```powershell
cd "AI101 vol2/gigacode-homework/developer-track"
.\scripts\run-tests.ps1
```

Expected: command exits non-zero and the only failure is `welcomePromoAppliesTenPercentDiscount`.

- [ ] **Step 5: Create zip archive**

Run from `AI101 vol2`:

```powershell
Compress-Archive -Path .\gigacode-homework -DestinationPath .\gigacode-homework.zip -Force
```

Expected: `AI101 vol2/gigacode-homework.zip` exists.

- [ ] **Step 6: Commit verification scripts**

```bash
git add "AI101 vol2/gigacode-homework/shared/checklists/final-verification.md" "AI101 vol2/gigacode-homework/scripts"
git commit -m "Add homework verification scripts"
```

---

## Self-Review

Spec coverage:

- `gigacode-homework/` downloadable folder: covered by Tasks 1 and 6.
- Two modes: developer in Tasks 3-4, analyst in Task 5.
- `.gigacode/` and `GIGACODE.md`: covered by Tasks 1-2.
- Java/Kotlin/JVM developer stack: covered by Task 3 with Java 17/JUnit and JVM wording in Russian docs.
- Russian documentation: every planned participant-facing Markdown file is Russian.
- Commands, Tools, Skills, Hooks, MCP, Subagents: covered in both track task sets.
- Accuracy details from `review.md`: covered in shared references, hook README, MCP README, and subagent task notes.
- Verification: covered by Task 6.

Completeness scan:

- No planned file content contains unfinished marker sections.
- The only intentionally failing check is the developer baseline JUnit test, documented in `expected/baseline-test-output.md`.

Type and path consistency:

- Java package is consistently `ru.ai101.gigacode.shop`.
- Test scripts compile `app/src/main/java` and `app/src/test/java`.
- Task references use existing planned paths.
- Hook protected paths match planned files.
