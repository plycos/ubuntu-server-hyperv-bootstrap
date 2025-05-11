# Check for admin rights
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script must be run as an administrator." -ForegroundColor Red
    exit 1
}

$scriptSteps = @(
    "scripts\Enable-HyperV.ps1"
)

foreach ($step in $scriptSteps) {
    $scriptPath = Join-Path $PSScriptRoot $step
    & $scriptPath
    if ($LASTEXITCODE -ne 0) {
        Read-Host "Press Enter to exit"
        exit $LASTEXITCODE
    }
}

Write-Host "Bootstrap script completed." -ForegroundColor Green
Read-Host "Press Enter to exit"