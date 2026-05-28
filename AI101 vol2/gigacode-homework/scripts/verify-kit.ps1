$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$required = @(
    "README.md",
    "GIGACODE.md",
    ".gigacode/settings.example.json",
    ".gigacode/hooks/protect_sources.py",
    ".gigacode/skills/qwen-code-helper/SKILL.md",
    ".gigacode/skills/qwen-code-helper/references/source-index.md",
    ".gigacode/skills/qwen-code-helper/references/commands-tools.md",
    ".gigacode/skills/qwen-code-helper/references/skills-hooks.md",
    ".gigacode/skills/qwen-code-helper/references/mcp-subagents.md",
    "shared/qwen-code-docs/README.md",
    "developer-track/tasks/01-commands.md",
    "developer-track/tasks/02-tools.md",
    "developer-track/tasks/03-skills.md",
    "developer-track/tasks/04-hooks.md",
    "developer-track/tasks/05-mcp.md",
    "developer-track/tasks/06-subagents.md",
    "analyst-track/tasks/01-commands.md",
    "analyst-track/tasks/02-tools.md",
    "analyst-track/tasks/03-skills.md",
    "analyst-track/tasks/04-hooks.md",
    "analyst-track/tasks/05-mcp.md",
    "analyst-track/tasks/06-subagents.md"
)

foreach ($path in $required) {
    if (-not (Test-Path (Join-Path $root $path))) {
        throw "Missing required file: $path"
    }
}

$settings = Get-Content (Join-Path $root ".gigacode/settings.example.json") -Raw | ConvertFrom-Json
$settings.hooks.PreToolUse | ForEach-Object {
    if ($_.matcher -cne $_.matcher.ToLowerInvariant()) {
        throw "Hook matcher must be lowercase: $($_.matcher)"
    }
}

Get-ChildItem -Path (Join-Path $root "*-track/tasks/*.md") | ForEach-Object {
    $text = Get-Content $_.FullName -Raw
    if ($text -notmatch "Самостоятельно") {
        throw "Task has no self-written exercise: $($_.FullName)"
    }
}

Get-ChildItem -Path (Join-Path $root "*-track/tasks/06-subagents.md") | ForEach-Object {
    $text = Get-Content $_.FullName -Raw
    if ($text -notmatch "Параллельное упражнение") {
        throw "Subagent task has no parallel exercise: $($_.FullName)"
    }
    if ($text -notmatch "Fork-субагенты отключены") {
        throw "Subagent task does not state fork disabled: $($_.FullName)"
    }
}

$helper = Get-Content (Join-Path $root ".gigacode/skills/qwen-code-helper/SKILL.md") -Raw
if ($helper -notmatch "qwen-code-helper") {
    throw "qwen-code-helper skill is missing expected name"
}
if ($helper -notmatch "matcher casing") {
    throw "qwen-code-helper must mention hook matcher casing"
}

Write-Host "Homework kit verification passed."
