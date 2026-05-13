# install.ps1
# Description: Registers or installs Microsoft Mail (Windows Communications Apps)
# Context: System (Win32 App)

$PackageName = "microsoft.windowscommunicationsapps"
$LogPath = "$env:TEMP\MailInstall.log"

Start-Transcript -Path $LogPath

try {
    Write-Output "Searching for Appx Package: $PackageName"
    
    # Check for provisioned package (the source in WindowsApps)
    $AppxPackage = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $PackageName }

    if ($AppxPackage) {
        Write-Output "Package found in provisioned storage at: $($AppxPackage.InstallLocation)"
        
        # Register for all users/current user
        # Note: In System context, this registers the app so it's available for users to launch
        Add-AppxPackage -Register "C:\Program Files\WindowsApps\$($AppxPackage.InstallLocation)\AppxManifest.xml" -DisableDevelopmentMode
        Write-Output "Registration successful."
    } else {
        Write-Output "Package not found in provisioned storage. Attempting Store-based install via Winget..."
        
        # Use Winget (ID for Mail & Calendar is 9WZDNCRFHVJL)
        # Note: Winget requires a recent version of App Installer to work in System context
        winget install --id 9WZDNCRFHVJL --accept-package-agreements --accept-source-agreements --scope machine --silent
        
        if ($LASTEXITCODE -eq 0) {
            Write-Output "Winget installation reported success."
        } else {
            Write-Error "Winget failed with exit code $LASTEXITCODE"
            exit 1
        }
    }
} catch {
    Write-Error "Failed to install $PackageName: $($_.Exception.Message)"
    exit 1
} finally {
    Stop-Transcript
}