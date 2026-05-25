# GigaCode Homework Kit Design

Date: 2026-05-25

## Context

AI101 vol.2 is a 90-minute introduction to GigaCode/Qwen Code style agentic coding tools. The lecture covers six practical levers:

- Commands
- Tools
- Skills
- Hooks
- MCP
- Subagents

The homework kit must let attendees download a ready mini-repository and try the same ideas after the presentation. The target CLI is the GigaCode fork, so all project conventions use `.gigacode/` and `GIGACODE.md`, not `.qwen/` and `QWEN.md`.

## Goal

Create a downloadable mini-repository named `gigacode-homework/` with two guided tracks:

- Developer track: exercises on a small codebase.
- Analyst track: exercises on product and process documentation.

Both tracks should exercise the same GigaCode concepts from the presentation, but with tasks that fit each audience. The kit should work for attendees who already have the GigaCode CLI installed.

## Non-Goals

- Do not build an offline simulator for users without the CLI.
- Do not require external paid services for completion.
- Do not turn the homework into a full course or long project.
- Do not rely on live network access for the core exercises.
- Do not use Qwen path names in participant-facing instructions.

## Package Shape

Proposed top-level structure:

```text
gigacode-homework/
  README.md
  README-quickstart.md
  GIGACODE.md
  .gigacode/
    commands/
    skills/
    agents/
    hooks/
    settings.example.json
  developer-track/
    README.md
    app/
    tests/
    docs/
    tasks/
    expected/
    scripts/
  analyst-track/
    README.md
    docs/
    tasks/
    expected/
    checklists/
  shared/
    references/
    mcp/
    checklists/
```

The root README explains the kit, prerequisites, expected time, and how to choose a track. Each track has its own README and numbered task files.

## GigaCode Conventions

The kit should consistently use:

- `GIGACODE.md` for the base project prompt.
- `.gigacode/commands/` for reusable prompt commands.
- `.gigacode/skills/` for project skills.
- `.gigacode/agents/` for named subagent definitions.
- `.gigacode/hooks/` and a settings example for hooks.

When the underlying concept comes from Qwen Code documentation, explain it as a GigaCode-compatible convention. Participant-facing examples should remain GigaCode-first.

## Learning Path

Each track has six exercises mapped to the presentation blocks:

1. Commands
2. Tools
3. Skills
4. Hooks
5. MCP
6. Subagents

Every exercise should include:

- Objective
- Files to inspect or attach with `@`
- Suggested GigaCode prompt or command
- Expected observable result
- Self-check
- Optional stretch task

The exercises should be small enough to complete independently. A participant should be able to finish one track in about 45-75 minutes.

## Developer Track

The developer track uses a tiny code project with intentionally simple defects and documentation gaps.

Core tasks:

- Commands: use `@` to attach a code standard file, `!` to run tests/status, and a custom command to ask for a commit-style summary.
- Tools: ask the agent to investigate a failing test using an explore -> verify -> edit workflow.
- Skills: invoke or let the model discover a project skill for code review or test debugging.
- Hooks: use a lightweight guardrail that blocks unsafe edits or asks for structured justification before changing protected files.
- MCP: use a local/mock MCP configuration or documented example that exposes read-only project facts.
- Subagents: delegate a focused review or test investigation to a named agent; separately demonstrate a fork-style parallel investigation if supported by the installed CLI.

The code project should use Python standard library code with `unittest` tests and no external dependencies. This keeps the developer track runnable from a clean checkout with `python -m unittest`.

Expected participant outputs:

- One fixed bug or small refactor.
- A short investigation note.
- A review summary produced with a command or skill.
- Evidence that checks/tests were run.

## Analyst Track

The analyst track uses documentation artifacts instead of code: a short PRD, stakeholder notes, FAQ, and release notes with deliberate inconsistencies.

Core tasks:

- Commands: attach selected docs with `@`, run a simple shell listing with `!`, and use a custom command to summarize a document set.
- Tools: ask the agent to search and read documents before proposing edits.
- Skills: use a documentation review skill for consistency, ambiguity, and missing acceptance criteria.
- Hooks: use a lightweight guardrail that enforces structured output for review notes or blocks edits to source notes.
- MCP: use a local/mock MCP configuration or documented example that behaves like a read-only knowledge source.
- Subagents: delegate consistency review, glossary review, or acceptance-criteria review to a named analyst agent.

Expected participant outputs:

- A cleaned-up PRD or FAQ section.
- A contradiction report.
- A concise stakeholder summary.
- A checklist showing how the agent used evidence from the documents.

## Shared GigaCode Assets

The root `.gigacode/` assets should be shared across tracks where useful:

- Custom commands:
  - `summarize-context.md`
  - `review-changes.md`
  - `write-handoff.md`
- Skills:
  - `code-review/SKILL.md`
  - `doc-review/SKILL.md`
  - `evidence-first/SKILL.md`
- Agents:
  - `code-reviewer.md`
  - `test-investigator.md`
  - `doc-analyst.md`
  - `consistency-reviewer.md`
- Hooks:
  - a simple readme-backed example hook
  - settings snippets showing how to enable it
- MCP:
  - a local/mock configuration example
  - a task that explains what to observe without requiring external credentials

## Accuracy Requirements

The homework should incorporate the corrected details from `review.md` where relevant:

- Use "Built-in Skills" rather than "Built-in workflows" when referring to `/review`, `/loop`, and `/qc-helper`.
- Include `/plan`, memory commands, `/btw`, and `/summary` in command reference material when useful.
- Mention `read_many_files` as a batch-reading tool if it exists in the target CLI.
- For skills, describe the `name` field accurately enough for practical use and include `disable-model-invocation: true` as an opt-in skill pattern.
- For hooks, include exit-code semantics and required `permissionDecision` / `permissionDecisionReason` fields when showing PreToolUse output.
- For MCP, clarify `excludeTools` precedence over `includeTools`, tool blocking through permissions, `/mcp auth`, and default timeout.
- For subagents, distinguish named agents from fork subagents: named agents block the parent and start without parent history; forks run in background and inherit parent context when supported.

These points do not all need to become full exercises, but examples should not contradict them.

## Verification

The final kit should be checked by:

- Reading all participant-facing Markdown for Qwen path leakage.
- Running the developer track tests from a clean checkout.
- Running any local scripts used by hooks or checks.
- Verifying that task files reference existing paths.
- Verifying that expected outputs match the seeded tasks.
- Creating a zip archive or confirming the folder is ready to zip.

## Risks

- The GigaCode fork may differ from upstream Qwen command names or config schema. The kit should label uncertain integration points as examples and keep core exercises independent of external services.
- MCP can become too heavy for homework. Keep MCP read-only and local/mock by default.
- Hooks can make the first-run experience brittle. Keep hooks optional or clearly scoped to one exercise.
- Two tracks can drift apart. Use the same six-exercise structure in both tracks so the teaching spine stays aligned.

## Approval State

The user approved the guided mini-repo approach and requested two modes:

- Developer mode for code work.
- Analyst mode for documentation work.

This design is ready to become an implementation plan after user review.
