# install.ps1
$PackageName = "microsoft.windowscommunicationsapps"
$LogPath = "$env:TEMP\MailInstall.log"

Start-Transcript -Path $LogPath

try {
    Write-Output "Searching for Appx Package: $PackageName"
    $AppxPackage = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $PackageName }

    if ($AppxPackage) {
        Write-Output "Package found in provisioned storage. Registering..."
        Add-AppxPackage -Register "C:\Program Files\WindowsApps\$($AppxPackage.InstallLocation)\AppxManifest.xml" -DisableDevelopmentMode
        Write-Output "Installation/Registration successful."
    } else {
        Write-Output "Package not found in provisioned storage. Attempting Store-based install via Winget..."
        # Optional: Use Winget to pull it back if it's missing entirely from the image
        winget install --id 9WZDNCRFHVJL --accept-package-agreements --accept-source-agreements --scope machine
    }
} catch {
    Write-Error "Failed to install $PackageName: $($_.Exception.Message)"
    exit 1
} finally {
    Stop-Transcript
}