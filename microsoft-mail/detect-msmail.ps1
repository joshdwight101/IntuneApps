# detect.ps1
# Description: Checks if Microsoft Mail is present on the system
# Context: System or User

$PackageName = "microsoft.windowscommunicationsapps"

# We check for the existence of the package for any user or provisioned
$AppExists = Get-AppxPackage -Name $PackageName -AllUsers

if ($AppExists) {
    # Intune interprets any STDOUT as success if exit code is 0
    Write-Output "Detected: $PackageName is installed."
    exit 0
} else {
    # Exit code 1 (or no output) tells Intune the app is missing
    exit 1
}