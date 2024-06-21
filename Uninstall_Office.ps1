# Define the list of Office 365 products to uninstall
$officeProducts = @(
    "Microsoft 365*"
    "Office 365*"
    "Office 16*"
    "Office 15*"
)

# Get a list of installed Office 365 products
$installedOfficeProducts = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall `
                                         -Recurse `
                                         -ErrorAction SilentlyContinue `
                                         | Get-ItemProperty `
                                         | Where-Object { $_.DisplayName -like $officeProducts }

# Loop through each installed Office 365 product and uninstall it
foreach ($product in $installedOfficeProducts) {
    $productCode = $product.PSChildName
    $productName = $product.DisplayName

    Write-Host "Uninstalling $productName..."

    # Uninstall the product silently
    $uninstallString = $product.UninstallString
    $uninstallArgs = $uninstallString -replace "/I","/X"
    Start-Process "cmd.exe" -ArgumentList "/C $uninstallArgs" -Wait

    # Remove the product registry key
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$productCode" -Recurse
}

Write-Host "Office 365 uninstallation complete."
