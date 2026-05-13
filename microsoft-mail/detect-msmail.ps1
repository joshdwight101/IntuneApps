# detect.ps1
$PackageName = "microsoft.windowscommunicationsapps"

$AppExists = Get-AppxPackage -Name $PackageName

if ($AppExists) {
    Write-Output "Detected: $PackageName is installed."
    exit 0
} else {
    Write-Output "Not Detected: $PackageName is missing."
    exit 1
}
