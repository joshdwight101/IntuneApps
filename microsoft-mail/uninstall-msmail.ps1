# uninstall.ps1
$PackageName = "microsoft.windowscommunicationsapps"

try {
    # Remove for current user
    Get-AppxPackage -Name $PackageName | Remove-AppxPackage -ErrorAction SilentlyContinue
    
    # Remove provisioned package (requires System/Admin context)
    $ProvisionedPackage = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $PackageName }
    if ($ProvisionedPackage) {
        Remove-AppxProvisionedPackage -Online -PackageName $ProvisionedPackage.PackageName
    }
    Write-Output "Successfully removed $PackageName"
} catch {
    Write-Error "Failed to remove $PackageName: $($_.Exception.Message)"
    exit 1
}