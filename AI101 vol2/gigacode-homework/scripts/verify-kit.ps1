$ErrorActionPreference = "Stop"

$Root = Resolve-Path (Join-Path $PSScriptRoot "..")

function Assert-File {
    param([string]$Path)

    $Full = Join-Path $Root $Path
    if (!(Test-Path $Full)) {
        throw ("Missing file: {0}" -f $Path)
    }
}

function Assert-MarkdownContains {
    param(
        [string]$Path,
        [string]$Pattern,
        [string]$Message
    )

    $Full = Join-Path $Root $Path
    if (!(Select-String -Path $Full -Pattern $Pattern -Quiet)) {
        throw $Message
    }
}

Write-Host "Checking upstream path leakage"
$Leak = Get-ChildItem -Path $Root -Recurse -Filter "*.md" |
    Select-String -Pattern "\.qwen/|QWEN\.md" -ErrorAction SilentlyContinue
if ($Leak) {
    $Leak | ForEach-Object { Write-Host $_ }
    throw "Found upstream path names in Markdown"
}

Write-Host "Checking required files"
$Required = @(
    "README.md",
    "README-quickstart.md",
    "GIGACODE.md",
    ".gigacode/settings.json",
    ".gigacode/settings.example.json",
    ".gigacode/hooks/README.md",
    ".gigacode/hooks/protect_sources.py",
    "developer-track/README.md",
    "developer-track/tasks/01-commands.md",
    "developer-track/tasks/06-subagents.md",
    "developer-track/expected/baseline-test-output.md",
    "analyst-track/README.md",
    "analyst-track/tasks/01-commands.md",
    "analyst-track/tasks/06-subagents.md",
    "analyst-track/expected/contradiction-report.md",
    "shared/mcp/README.md",
    "shared/mcp/local-knowledge-server.example.json"
)

foreach ($Path in $Required) {
    Assert-File $Path
}

Write-Host "Checking JSON settings"
Get-Content (Join-Path $Root ".gigacode/settings.json") -Raw | ConvertFrom-Json | Out-Null
Get-Content (Join-Path $Root ".gigacode/settings.example.json") -Raw | ConvertFrom-Json | Out-Null

Write-Host "Checking analyst expected report"
Assert-MarkdownContains "analyst-track/expected/contradiction-report.md" "CSV" "contradiction-report does not cover the format conflict"
Assert-MarkdownContains "analyst-track/expected/contradiction-report.md" "90" "contradiction-report does not cover the period conflict"
Assert-MarkdownContains "analyst-track/expected/contradiction-report.md" "stakeholder-notes" "contradiction-report does not cover the role conflict"
Assert-MarkdownContains "analyst-track/expected/contradiction-report.md" "email" "contradiction-report does not cover the notification conflict"
Assert-MarkdownContains "analyst-track/expected/contradiction-report.md" "30" "contradiction-report does not cover the retention conflict"

Write-Host "Checking hook and MCP references"
Assert-MarkdownContains ".gigacode/hooks/README.md" "hookSpecificOutput" "Hook README does not explain hookSpecificOutput"
Assert-MarkdownContains ".gigacode/hooks/README.md" "permissionDecision" "Hook README does not explain permissionDecision"
Assert-MarkdownContains ".gigacode/hooks/README.md" "permissionDecisionReason" "Hook README does not explain permissionDecisionReason"
Assert-MarkdownContains ".gigacode/hooks/README.md" "WriteFile" "Hook README does not explain WriteFile matcher"
Assert-MarkdownContains "shared/mcp/README.md" "includeTools" "MCP README does not explain includeTools"
Assert-MarkdownContains "shared/mcp/README.md" "excludeTools" "MCP README does not explain excludeTools"
Assert-MarkdownContains "shared/mcp/README.md" "/mcp auth" "MCP README does not explain /mcp auth"
Assert-MarkdownContains "shared/mcp/README.md" "600000" "MCP README does not explain timeout"

Write-Host "Checking hook behavior"
$ProtectedPayload = '{"hook_event_name":"PreToolUse","tool_name":"WriteFile","tool_input":{"file_path":"developer-track/docs/code-standards.md"}}'
$HookOutput = $ProtectedPayload | python (Join-Path $Root ".gigacode/hooks/protect_sources.py") | ConvertFrom-Json
if ($HookOutput.hookSpecificOutput.permissionDecision -ne "deny") {
    throw "Protected WriteFile payload was not denied"
}

Write-Host "Verification complete"
