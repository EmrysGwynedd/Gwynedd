# Fersiwn wedi wedi ei tweak'io o Default_Machine_Settings_Gwynedd.ps1 i weithio efo 'Cyfrif i Bawb'
# Modified    : 10/01/25
# Modified by : Emrys Wyn Evans

###########################################   Parameters to be altered as required   ###########################################

# These Folders will be created if they do not exist
$Folders = @(
    @{dir = "C:\TG"},
    @{dir = "C:\TG\Cronfeydd Data"},
    @{dir = "C:\TG\Dogfennau"},
    @{dir = "C:\TG\Eiconau"},
    @{dir = "C:\TG\Fflagiau"},
    @{dir = "C:\TG\Logs"},
    @{dir = "C:\ProgramData\Microsoft\Event Viewer\Views\Technoleg Gwybodaeth"},
    @{dir = "C:\Windows\System32\LogFiles\Firewall"},
    @{dir = "C:\Windows\Wallpaper"},
    @{dir = "C:\Windows\Initialization"},
    @{dir = "C:\ProgramData\Keysoft Solutions"}
)

# These Files will be copied and overwritten if not currently in use
$files = @(
    # Copy Cyngor Gwynedd background to local source
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/Cyngor_Gwynedd/Cefndir.png"; output = "C:\Windows\Wallpaper\Cefndir.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/Cyngor_Gwynedd/CefndirLock.png"; output = "C:\Windows\Web\Screen\CefndirLock.png"},

    #Script to set initial settings on First Login
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/General_Files/Default_User_Settings_First_Logon_Gwynedd.ps1.txt"; output = "C:\Windows\Initialization\Initialize_User.ps1"},
   
    #Copy Gwynedd Icons to local directory
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/General_Files/Eiconau/Gwynedd.ico"; output = "C:\TG\Eiconau\Gwynedd.ico"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/General_Files/Eiconau/logo_cyngor_gwynedd.ico"; output = "C:\TG\Eiconau\logo_cyngor_gwynedd.ico"},
       
    #Copy Admin Unlock File Locally
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Admin_Unlock/AdministrativeUnlock.dll.txt"; output = "C:\Windows\System32\AdministrativeUnlock.dll"}
)

# These Registary Settings will be Applied
$Regs = @(
    #Set Default Policies for Machine
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "HideTaskViewButton"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoUseStoreOpenWith"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "EnableShellShortcutIconRemotePath"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoNewAppAlert"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoAutoplayfornonVolume"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoPinningStoreToTaskbar"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds"; RName = "EnableFeeds"; RVal = "0"; RType="DWORD"},

    #Set Default Settings for Machine
    #Disable HiberBoot
    @{RKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"; RName = "HiberbootEnabled"; RVal = "0"; RType="DWORD"},
    
    #Disable Open with Store
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoUseStoreOpenWith"; RVal = "1"; RType="DWORD"},
    
    #Set Default User Settings for all users
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; RName = "Wallpaper"; RVal = "C:\Windows\Wallpaper\Cefndir.png"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; RName = "WallpaperStyle"; RVal = "3"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"; RName = "TurnOffWindowsCopilot"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; RName = "OneDrive For Business"; RVal = "C:\Program Files\Microsoft OneDrive\OneDrive.exe"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; RName = "Initial User Settings"; RVal = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Windows\Initialization\Initialize_User.ps1"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\Software\Policies\Microsoft\Office\16.0\Outlook\Options\General"; RName = "DisableOutlookMobileHyperlink"; RVal = "1"; RType="DWORD"}
    @{RKey = "HKLM:\DEFUSER\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"},
    @{RKey = "Registry::HKEY_USERS\.DEFAULT\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"}
)



# Create folder for Lof Files
If(!(test-path -PathType container C:\TG\Logs))
 {New-Item -ItemType Directory -Path C:\TG\Logs}


# Start the transcript and specify the log file path
Start-Transcript -Path "C:\TG\Logs\Default_Machine_Settings.log" -Force


# Check Directory structure exists and if not create
foreach ($Folder in $Folders) 
{
If(!(test-path -PathType container $Folder.dir))
 {New-Item -ItemType Directory -Path $Folder.dir}
}

# Check if files exist on local host and if not copy the Files from the Web Storage to the Local Locations
foreach ($file in $files) 
{
Start-Sleep -Seconds 2
write-host ""
write-host $file.output
# Check if the destination file exists
if (Test-Path -Path $file.output) {
} else {
}
}


# Set Machine Level Registy items
# Load Default User Profile Hive

$DefaultUserHive = "C:\Users\Default\NTUSER.DAT"
$MountPoint = "HKLM\DEFUSER"
reg load $MountPoint $DefaultUserHive

# Install Setting for Administrative Unlock to work with Windows 11

foreach ($Reg in $Regs)
{
 if (Test-Path $Reg.RKey) 
 {New-ItemProperty -Path $Reg.RKey -Name $Reg.RName -Value $Reg.RVal -PropertyType $Reg.RType -Force } 
 else 
 { 
 New-Item -Path $Reg.RKey -Force
 New-ItemProperty -Path $Reg.RKey -Name $Reg.RName -Value $Reg.RVal -PropertyType $Reg.RType -Force 
 }
}

# Unload Registry Hive
reg Unload $MountPoint

# Set Machine Level Task Schedule items 

# Remove Orchestrator Updater for Outlook for Windows OOBE
$regPathoobe = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate"

# Check if the registry key exists
if (Test-Path $regPathoobe) {
    # Remove the registry key and all its subkeys and entries
    Remove-Item -Path $regPathoobe -Recurse -Force
    Write-Output "Registry key and all its subkeys and entries have been removed."
} else {
    Write-Output "Registry key does not exist."
}

# Remove Orchestrator Updater for Outlook for Windows All-Users level
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate"

# Check if the registry key exists
if (Test-Path $regPath) {
    # Remove the registry key and all its subkeys and entries
    Remove-Item -Path $regPath -Recurse -Force
    Write-Output "Registry key and all its subkeys and entries have been removed."
} else {
    Write-Output "Registry key does not exist."
}

# Remove Pre-Provisioned Apps
# Create folder for Lof Files
If(!(test-path -PathType container C:\TG\Logs))
 {New-Item -ItemType Directory -Path C:\TG\Logs}

# Start the transcript and specify the log file path
Start-Transcript -Path "C:\TG\Logs\Remove_Pre-Privisioned-Apps.log" -Force

## This section removes provisioned Apps for All users
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
Get-AppxProvisionedPackage -online | Where-Object {$_.PackageName -like "*XboxGamingOverlay*"} | Remove-AppxProvisionedPackage -Online

# Remove New Outlook for existing users
Get-AppxPackage -AllUsers Microsoft.OutlookForWindows | Remove-AppxPackage -AllUsers

# Remove provisioned package so it doesn't install for new users
Get-AppxProvisionedPackage -Online |
Where-Object {$_.DisplayName -eq "Microsoft.OutlookForWindows"} |
Remove-AppxProvisionedPackage -Online -AllUsers

#Shortcut i Teams ar y Desgfwrdd i bawb.
$PublicDesktop = "$env:PUBLIC\Desktop"
$Shell = New-Object -ComObject WScript.Shell
$TeamsExe = Get-ChildItem "C:\Program Files\WindowsApps" -Filter "ms-teams.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

if ($TeamsExe) {
    $Shortcut = $Shell.CreateShortcut("$PublicDesktop\Microsoft Teams.lnk")
    $Shortcut.TargetPath = $TeamsExe.FullName
    $Shortcut.IconLocation = "$($TeamsExe.FullName),0"
    $Shortcut.Save()
}

# Stop the transcript
Stop-Transcript -WarningAction SilentlyContinue