# Define the app name or package name to check
$appName = "XboxGamingOverlay"

# Get the list of installed Appx packages
$installedApps = Get-AppxPackage | Where-Object { $_.Name -like "*$appName*" }

# Check if the app is installed
if ($installedApps) {
    Write-Output "App '$appName' is installed. Running Remediation."
    Exit 1

} else {
    Write-Output "App '$appName' is not installed."
    Exit 0
}