# Detection Script for Lithnet IdleLogoff MSI Installation and Registry Settings

# Define the MSI product code for Lithnet IdleLogoff
$msiProductCode = "{DA138438-9E86-4741-A722-0BAC2987F1DB}"

# Check if the MSI is installed by looking for the product code
$msiCheck = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE IdentifyingNumber='$msiProductCode'"

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Lithnet\IdleLogOff"

# Check if the registry path exists
$regKeyExists = Test-Path -Path $registryPath

# Check if the specific registry values are set correctly
$regValuesCorrect = $false
if ($regKeyExists) {
    $regValues = Get-ItemProperty -Path $registryPath
    if (($regValues.Enabled -eq 1) -and ($regValues.IdleLimit -eq 30) -and ($regValues.WarningEnabled -eq 1)) {
        $regValuesCorrect = $true
    }
}

# If both the MSI and the registry settings are correct, return success (exit 0)
if ($msiCheck -and $regValuesCorrect) {
    Write-Host "Application and registry settings are correct."
    exit 0
} else {
    Write-Host "Application or registry settings are missing or incorrect."
    exit 1
}

