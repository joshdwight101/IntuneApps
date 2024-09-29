# Define the base registry path
$baseRegistryPath = "HKLM:\SOFTWARE\Lithnet\IdleLogOff"

# Ensure the parent registry key exists, create it if it doesn't
if (-not (Test-Path "HKLM:\SOFTWARE\Lithnet")) {
    New-Item -Path "HKLM:\SOFTWARE" -Name "Lithnet" -Force
}

# Create the IdleLogOff key if it doesn't exist
if (-not (Test-Path $baseRegistryPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Lithnet" -Name "IdleLogOff" -Force
}

# Set the registry values
Set-ItemProperty -Path $baseRegistryPath -Name "Enabled" -Value 1 -Force
Set-ItemProperty -Path $baseRegistryPath -Name "IdleLimit" -Value 30 -Force
Set-ItemProperty -Path $baseRegistryPath -Name "IgnoreDisplayRequested" -Value 1 -Force
Set-ItemProperty -Path $baseRegistryPath -Name "WarningEnabled" -Value 1 -Force
Set-ItemProperty -Path $baseRegistryPath -Name "WarningMessage" -Value "Your session has been idle for too long, and you will be logged out in {0}" -Force
Set-ItemProperty -Path $baseRegistryPath -Name "WarningPeriod" -Value 30 -Force
Set-ItemProperty -Path $baseRegistryPath -Name "WaitForInitialInput" -Value 0 -Force
Set-ItemProperty -Path $baseRegistryPath -Name "Action" -Value 0 -Force

Write-Host "Registry settings applied successfully."
