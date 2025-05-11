# Enable-HyperV.ps1

$taskName = "Resume-HyperV-Bootstrap"
$scriptPath = (Resolve-Path "$PSScriptRoot/../bootstrap.ps1").Path

$feature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V

if ($feature.State -eq 'Enabled') {
    Write-Host "Hyper-V is enabled."
    exit 0
}

$confirmation = Read-Host "Hyper-V is not enabled. Do you want to enable Hyper-V? (Y/N)"
if ($confirmation -ne 'Y' -and $confirmation -ne 'y') {
    Write-Host "Hyper-V must be enabled to run this script." -ForegroundColor Red
    exit 1
}

# Create scheduled task to resume bootstrap after reboot
schtasks /Create /TN $taskName /TR "powershell -ExecutionPolicy Bypass -File `"$scriptPath`"" /SC ONLOGON /RL HIGHEST

# Enable Hyper-V (DISM will prompt for reboot)
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V