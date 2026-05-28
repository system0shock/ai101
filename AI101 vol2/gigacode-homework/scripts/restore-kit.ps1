param(
    [switch]$Yes
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$snapshot = Join-Path $root "shared/restore/snapshot"

if (-not (Test-Path $snapshot)) {
    throw "Snapshot not found at $snapshot. Restore is not possible."
}

$targets = @(
    @{ Path = ".gigacode";              Source = "$snapshot/.gigacode" },
    @{ Path = "analyst-track/docs";     Source = "$snapshot/analyst-track/docs" },
    @{ Path = "developer-track/app";    Source = "$snapshot/developer-track/app" }
)

Write-Host "This will reset to the pristine homework state:"
foreach ($t in $targets) {
    Write-Host "  - $($t.Path)"
}
Write-Host "All your local edits to these paths will be lost."

if (-not $Yes) {
    $answer = Read-Host "Continue? [y/N]"
    if ($answer -notmatch "^[yY]") {
        Write-Host "Aborted."
        exit 1
    }
}

foreach ($t in $targets) {
    $abs = Join-Path $root $t.Path
    if (Test-Path $abs) {
        Remove-Item -Recurse -Force $abs
    }
    Copy-Item -Recurse -Force $t.Source $abs
    Write-Host "Restored: $($t.Path)"
}

Write-Host "Restore complete. Run .\scripts\verify-kit.ps1 to confirm."
