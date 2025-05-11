# bootstrap.ps1

function Remove-ResumeTask {
    $taskName = "Resume-HyperV-Bootstrap"
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        schtasks /Delete /TN $taskName /F | Out-Null
    }
}

# Check for admin rights
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script must be run as an administrator." -ForegroundColor Red
    exit 1
}

$scriptSteps = @(
    "scripts\Enable-HyperV.ps1"
)

$exitCode = 0
try {
    foreach ($step in $scriptSteps) {
        $scriptPath = Join-Path $PSScriptRoot $step
        & $scriptPath
        if ($LASTEXITCODE -ne 0) {
            $exitCode = $LASTEXITCODE
            break
        }
    }
} finally {
    Remove-ResumeTask
}

if ($exitCode -eq 0) {
    Write-Host "Bootstrap script completed." -ForegroundColor Green
} else {
    Write-Host "A step failed. Exiting." -ForegroundColor Red
}
Read-Host "Press Enter to exit"
exit $exitCode