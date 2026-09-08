# Uninstall Outlook for Windows Remediation Script

# Define the application name
$appName = "OutlookForWindows"

# Get the list of installed Windows Store apps
$installedApps = Get-AppxPackage

# Check if the new Outlook app is installed
$newOutlookApp = $installedApps | Where-Object { $_.Name -like "*$appName*" }


try{
  if ($newOutlookApp) {
  Write-host "App Exist run uninstall"
  $newOutlookApp | Remove-AppxPackage
  }
  else
  {
  Write-host "App does NOT Exist"
  }
}
catch
{
    Write-Error $_
}