# Script to remove Apps on Windows 11
# 
# Author : Richard Hughes
# Date : 20/4/2022
#


# Create folder for Lof Files
If(!(test-path -PathType container C:\TG\Logs))
 {New-Item -ItemType Directory -Path C:\TG\Logs}

# Start the transcript and specify the log file path
Start-Transcript -Path "C:\TG\Logs\Remove_Pre-Privisioned-Apps.log" -Force

## This 2nd section removes provisioned Apps for All users

Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*Bing*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*Zune*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*Office*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*Twitter*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*3DBuilder*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*OfficeHub*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*LenovoID*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*CandyCrush*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*WindowsMaps*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*WindowsPhone*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*Solitaire*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*GetStarted*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*GetHelp*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*xboxapp*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*Messaging*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*ConnectivityStore*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*WindowsFeedbackHub*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*Facebook*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*XboxIdentityProvider*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*XboxGameCallableUI*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*XboxGamingOverlay*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*OneConnect*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*Duolingo*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*AdobePhotoshopExpress*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*EclipseManager*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*RemoteDesktop*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*NetworkSpeedTest*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*ActiproSoftwareLLC*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*AutodeskSketchBook*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*SpotifyMusic*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*DolbyAccess*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*MarchofEmpires*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*BubbleWitch*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*DisneyMagicKingdoms*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*YourPhone*"} | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*windowscommunicationsapps*"} | Remove-AppxProvisionedPackage -Online


# Stop the transcript
Stop-Transcript -WarningAction SilentlyContinue