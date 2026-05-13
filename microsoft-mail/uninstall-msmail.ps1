# uninstall.ps1
# Description: Removes Microsoft Mail for all users and prevents re-provisioning
# Context: System (Win32 App)

$PackageName = "microsoft.windowscommunicationsapps"

try {
    Write-Output "Starting removal of $PackageName"

    # 1. Remove the provisioned package (stops it from coming back for new users)
    $ProvisionedPackage = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $PackageName }
    if ($ProvisionedPackage) {
        Write-Output "Removing provisioned package..."
        Remove-AppxProvisionedPackage -Online -PackageName $ProvisionedPackage.PackageName -ErrorAction SilentlyContinue
    }

    # 2. Remove for all existing users on the machine
    # Note: Requires PowerShell 5.1+ and System context
    Write-Output "Removing package for all users..."
    Get-AppxPackage -Name $PackageName -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue

    Write-Output "Successfully removed $PackageName"
    exit 0
} catch {
    Write-Error "Failed to remove $PackageName: $($_.Exception.Message)"
    exit 1
}