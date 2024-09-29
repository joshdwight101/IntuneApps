# MSI Product Code
$productCode = "{DA138438-9E86-4741-A722-0BAC2987F1DB}"

# Uninstall Lithnet IdleLogoff using the product code
Start-Process msiexec.exe -ArgumentList "/x", "$productCode", "/qn", "/norestart" -Wait -NoNewWindow
