$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot

function Get-Python3Command {
    $candidates = @(
        @("python3"),
        @("py", "-3"),
        @("python")
    )

    foreach ($candidate in $candidates) {
        $cmd = $candidate[0]
        if ($candidate.Length -eq 1) {
            $args = @()
        } else {
            $args = @($candidate[1..($candidate.Length - 1)])
        }

        $previousErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "Continue"
        $version = & $cmd @args --version 2>&1
        $exitCode = $LASTEXITCODE
        $ErrorActionPreference = $previousErrorActionPreference

        if ($exitCode -eq 0 -and $version -match "Python 3\.") {
            return $candidate
        }
    }

    throw "Python 3 is required to run smoke tests."
}

function Invoke-Python3Script($scriptPath) {
    $python = Get-Python3Command
    $cmd = $python[0]
    if ($python.Length -eq 1) {
        $args = @()
    } else {
        $args = @($python[1..($python.Length - 1)])
    }

    & $cmd @args $scriptPath
    if ($LASTEXITCODE -ne 0) {
        throw "Python smoke test failed: $scriptPath"
    }
}

$required = @(
    "README.md",
    "GIGACODE.md",
    ".gigacode/settings.json",
    ".gigacode/settings.example.json",
    ".gigacode/hooks/protect_sources.py",
    ".gigacode/hooks/smoke_test_protect_sources.py",
    ".gigacode/skills/qwen-code-helper/SKILL.md",
    ".gigacode/skills/qwen-code-helper/references/source-index.md",
    ".gigacode/skills/qwen-code-helper/references/commands-tools.md",
    ".gigacode/skills/qwen-code-helper/references/skills-hooks.md",
    ".gigacode/skills/qwen-code-helper/references/mcp-subagents.md",
    "shared/qwen-code-docs/README.md",
    "shared/mcp/local_knowledge_server.py",
    "shared/mcp/smoke_test_local_server.py",
    "shared/mcp/local-stdio-server.config.example.json",
    "developer-track/pom.xml",
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

$settingsFiles = @(".gigacode/settings.json", ".gigacode/settings.example.json")
foreach ($settingsFile in $settingsFiles) {
    $settings = Get-Content (Join-Path $root $settingsFile) -Raw | ConvertFrom-Json
    $settings.hooks.PreToolUse | ForEach-Object {
        if ($_.matcher -cne $_.matcher.ToLowerInvariant()) {
            throw "Hook matcher must be lowercase in $settingsFile`: $($_.matcher)"
        }
        $_.hooks | ForEach-Object {
            if ($_.command -notmatch "^python3 ") {
                throw "Hook command must use python3 in $settingsFile`: $($_.command)"
            }
        }
    }
}

Get-ChildItem -Path (Join-Path $root "*-track/tasks/*.md") | ForEach-Object {
    $text = Get-Content $_.FullName -Raw -Encoding UTF8
    if ($text -notmatch "(?m)^## A\.") {
        throw "Task is missing '## A.' section: $($_.FullName)"
    }
    if ($text -notmatch "(?m)^## B\.") {
        throw "Task is missing '## B.' section: $($_.FullName)"
    }
    if ($text -notmatch "qwen-code-docs") {
        throw "Task has no official Qwen Code docs link: $($_.FullName)"
    }
    if ($text -notmatch "qwen-code-helper/references") {
        throw "Task has no local qwen-code-helper reference link: $($_.FullName)"
    }
}

Get-ChildItem -Path (Join-Path $root "*-track/tasks/06-subagents.md") | ForEach-Object {
    $text = Get-Content $_.FullName -Raw
    if ($text -notmatch "subagent_type") {
        throw "Subagent task must mention subagent_type: $($_.FullName)"
    }
}

$helper = Get-Content (Join-Path $root ".gigacode/skills/qwen-code-helper/SKILL.md") -Raw
if ($helper -notmatch "qwen-code-helper") {
    throw "qwen-code-helper skill is missing expected name"
}
if ($helper -notmatch "matcher casing") {
    throw "qwen-code-helper must mention hook matcher casing"
}

Invoke-Python3Script (Join-Path $root "shared/mcp/smoke_test_local_server.py")
Invoke-Python3Script (Join-Path $root ".gigacode/hooks/smoke_test_protect_sources.py")

Write-Host "Homework kit verification passed."
