# Script to remove Apps on Windows 10
# 
# Author : Richard Hughes
# Date : 20/4/2022
#
#

# Create folder for Lof Files
If(!(test-path -PathType container C:\TG\Logs))
 {New-Item -ItemType Directory -Path C:\TG\Logs}


# Start the transcript and specify the log file path
Start-Transcript -Path "C:\TG\Logs\Default_Machine_Settings.log" -Force


# This 1st section removes Apps for currently logged on user only.
Get-AppxPackage *Bing* | Remove-AppxPackage
Get-AppxPackage *SkypeApp* | Remove-AppxPackage
Get-AppxPackage *Zune* | Remove-AppxPackage
Get-AppxPackage *.office.* | Remove-AppxPackage
Get-AppxPackage *Twitter* | Remove-AppxPackage
Get-AppxPackage *3DBuilder* | Remove-AppxPackage
Get-AppxPackage *OfficeHub* | Remove-AppxPackage
Get-AppxPackage *LenovoID* | Remove-AppxPackage
Get-AppxPackage *CandyCrush* | Remove-AppxPackage
Get-AppxPackage *WindowsMaps* | Remove-AppxPackage
Get-AppxPackage *WindowsPhone* | Remove-AppxPackage
Get-AppxPackage *Solitaire* | Remove-AppxPackage
Get-AppxPackage *GetStarted* | Remove-AppxPackage
Get-AppxPackage *GetHelp* | Remove-AppxPackage
Get-AppxPackage *XboxApp* | Remove-AppxPackage
Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage
Get-AppxPackage *Messaging* | Remove-AppxPackage
Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage
Get-AppxPackage *Facebook* | Remove-AppxPackage
Get-AppxPackage *XboxIdentityProvider* | Remove-AppxPackage
Get-AppxPackage *OneConnect* | Remove-AppxPackage
Get-AppxPackage *Duolingo* | Remove-AppxPackage
Get-AppxPackage *AdobePhotoshopExpress* | Remove-AppxPackage
Get-AppxPackage *EclipseManager* | Remove-AppxPackage
Get-AppxPackage *RemoteDesktop* | Remove-AppxPackage
Get-AppxPackage *NetworkSpeedTest* | Remove-AppxPackage
Get-AppxPackage *ActiproSoftwareLLC* | Remove-AppxPackage
Get-AppxPackage *AutodeskSketchBook* | Remove-AppxPackage
Get-AppxPackage *SpotifyMusic* | Remove-AppxPackage
Get-AppxPackage *DolbyAccess* | Remove-AppxPackage
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage
Get-AppxPackage *DisneyMagicKingdoms* | Remove-AppxPackage
Get-AppxPackage *.YourPhone* | Remove-AppxPackage
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage


# Stop the transcript
Stop-Transcript -WarningAction SilentlyContinue