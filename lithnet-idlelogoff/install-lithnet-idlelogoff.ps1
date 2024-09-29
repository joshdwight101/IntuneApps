# Lithnet IdleLogoff Installation Script
# Revised: 09/17/2024
# Author: JDwight

# Import the registry file or write the registry settings
reg.exe import "$PSScriptRoot\lithnet.reg" /reg:64

# Define the path to the MSI file, using PSScriptRoot for the current script's location
$msiPath = "$PSScriptRoot\lithnet.idlelogoff.setup.msi"

# Execute the MSI installer with silent (quiet) mode
Start-Process msiexec.exe -ArgumentList "/i", "`"$msiPath`"", "/qn", "/norestart" -Wait -NoNewWindow
