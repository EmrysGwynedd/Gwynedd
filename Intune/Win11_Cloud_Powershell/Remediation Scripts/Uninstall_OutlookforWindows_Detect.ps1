# Detection Script - Remove Outlook for Windows

# Define the application name
$appName = "OutlookForWindows"

# Get the list of installed Windows Store apps
$installedApps = Get-AppxPackage

# Check if the new Outlook app is installed
$newOutlookApp = $installedApps | Where-Object { $_.Name -like "*$appName*" }

if ($newOutlookApp) {
    Write-Output "The new Outlook app is installed."
    exit 1  # Indicates that remediation is needed
} else {
    Write-Output "The new Outlook app is not installed."
    exit 0  # Indicates no action needed
}