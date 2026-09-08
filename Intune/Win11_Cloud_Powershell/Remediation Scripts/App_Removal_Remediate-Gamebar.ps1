# Define the app name or package name to check
$appName = "XboxGamingOverlay"

# Get the list of installed Appx packages
$installedApps = Get-AppxPackage | Where-Object { $_.Name -like "*$appName*" }

# Check if the app is installed
if ($installedApps) {
    Write-Output "App '$appName' is installed. Removing it now..."
    
    # Remove the installed Appx package
    $installedApps | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName }
    
    Write-Output "App '$appName' has been removed."
} else {
    Write-Output "App '$appName' is not installed."
}