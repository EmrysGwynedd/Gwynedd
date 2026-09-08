# Optimized version of Default_Machine_Settings_Gwynedd.ps1 to work with 'Cyfrif i Bawb'
# Modified     : 10/01/25
# Modified by  : Emrys Wyn Evans
# Updated      : July 2026 (Fixed downloading logic, safe hive unloading, and syntax)

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

    # Script to set initial settings on First Login
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/General_Files/Default_User_Settings_First_Logon_Gwynedd.ps1.txt"; output = "C:\Windows\Initialization\Initialize_User.ps1"},
    
    # Copy Gwynedd Icons to local directory
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/General_Files/Eiconau/Gwynedd.ico"; output = "C:\TG\Eiconau\Gwynedd.ico"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/General_Files/Eiconau/logo_cyngor_gwynedd.ico"; output = "C:\TG\Eiconau\logo_cyngor_gwynedd.ico"},
        
    # Copy Admin Unlock File Locally
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Admin_Unlock/AdministrativeUnlock.dll.txt"; output = "C:\Windows\System32\AdministrativeUnlock.dll"}
)

# These Registry Settings will be Applied
$Regs = @(
    # Set Default Policies for Machine
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "HideTaskViewButton"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoUseStoreOpenWith"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "EnableShellShortcutIconRemotePath"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoNewAppAlert"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoAutoplayfornonVolume"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoPinningStoreToTaskbar"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds"; RName = "EnableFeeds"; RVal = "0"; RType="DWORD"},

    # Set Default Settings for Machine
    # Disable HiberBoot
    @{RKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"; RName = "HiberbootEnabled"; RVal = "0"; RType="DWORD"},
    
    # Disable Open with Store
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoUseStoreOpenWith"; RVal = "1"; RType="DWORD"},
    
    # Set Default User Settings for all users (via Mounted Hive)
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; RName = "Wallpaper"; RVal = "C:\Windows\Wallpaper\Cefndir.png"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; RName = "WallpaperStyle"; RVal = "3"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"; RName = "TurnOffWindowsCopilot"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; RName = "OneDrive For Business"; RVal = "C:\Program Files\Microsoft OneDrive\OneDrive.exe"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; RName = "Initial User Settings"; RVal = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Windows\Initialization\Initialize_User.ps1"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\Software\Policies\Microsoft\Office\16.0\Outlook\Options\General"; RName = "DisableOutlookMobileHyperlink"; RVal = "1"; RType="DWORD"}, # Fixed missing comma here
    @{RKey = "HKLM:\DEFUSER\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"},
    @{RKey = "Registry::HKEY_USERS\.DEFAULT\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"}
)

# Create folder for Log Files
If(!(Test-Path -PathType container "C:\TG\Logs")) {
    New-Item -ItemType Directory -Path "C:\TG\Logs" -Force | Out-Null
}

# Start the transcript and specify the log file path
Start-Transcript -Path "C:\TG\Logs\Default_Machine_Settings.log" -Force

# Check Directory structure exists and if not create
foreach ($Folder in $Folders) {
    If(!(Test-Path -PathType container $Folder.dir)) {
        Write-Output "Creating directory: $($Folder.dir)"
        New-Item -ItemType Directory -Path $Folder.dir -Force | Out-Null
    }
}

# Check if files exist on local host and download them if missing
foreach ($file in $files) {
    Start-Sleep -Seconds 1
    
    # Ensure destination parent directory exists before writing to it
    $parentDir = [System.IO.Path]::GetDirectoryName($file.output)
    if (!(Test-Path -Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    if (Test-Path -Path $file.output) {
        Write-Output "File already exists locally: $($file.output)"
    } else {
        Write-Output "Downloading: $($file.url) -> $($file.output)"
        try {
            # Added Invoke-WebRequest to properly download the assets
            Invoke-WebRequest -Uri $file.url -OutFile $file.output -TimeoutSec 30 -ErrorAction Stop
        } catch {
            Write-Warning "Failed to download $($file.url). Error: $_"
        }
    }
}

# Set Machine Level Registry items
# Load Default User Profile Hive
$DefaultUserHive = "C:\Users\Default\NTUSER.DAT"
$MountPoint = "HKLM\DEFUSER"

Write-Output "Mounting Default User Hive..."
reg load $MountPoint $DefaultUserHive

try {
    foreach ($Reg in $Regs) {
        $adjustedKey = $Reg.RKey
        if ($adjustedKey -match "^HKLM:\\DEFUSER") {
            $adjustedKey = $adjustedKey -replace "HKLM:\\DEFUSER", "HKLM:\DEFUSER"
        }

        if (Test-Path $adjustedKey) {
            New-ItemProperty -Path $adjustedKey -Name $Reg.RName -Value $Reg.RVal -PropertyType $Reg.RType -Force | Out-Null
        } else { 
            New-Item -Path $adjustedKey -Force | Out-Null
            New-ItemProperty -Path $adjustedKey -Name $Reg.RName -Value $Reg.RVal -PropertyType $Reg.RType -Force | Out-Null
        }
    }
}
finally {
    # This always runs even if the registry processing crashes, protecting your Default Hive
    Write-Output "Unmounting Default User Hive cleanly..."
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
    reg Unload $MountPoint
}

# Set Machine Level Task Schedule items / Remove Orchestrator Updaters
$regPathoobe = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe\OutlookUpdate"
if (Test-Path $regPathoobe) {
    Remove-Item -Path $regPathoobe -Recurse -Force
    Write-Output "OOBE OutlookUpdate registry key removed."
}

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate"
if (Test-Path $regPath) {
    Remove-Item -Path $regPath -Recurse -Force
    Write-Output "Machine OutlookUpdate registry key removed."
}

# Remove Pre-Provisioned Bloatware Apps
Write-Output "Removing unneeded provisioned AppX packages..."

$AppsToRemove = @(
    "*Bing*", "*Zune*", "*Office*", "*Twitter*", "*3DBuilder*", "*OfficeHub*", 
    "*LenovoID*", "*CandyCrush*", "*WindowsMaps*", "*WindowsPhone*", "*Solitaire*", 
    "*GetStarted*", "*GetHelp*", "*xboxapp*", "*Messaging*", "*ConnectivityStore*", 
    "*WindowsFeedbackHub*", "*Facebook*", "*XboxIdentityProvider*", "*XboxGameCallableUI*", 
    "*XboxGamingOverlay*", "*OneConnect*", "*Duolingo*", "*AdobePhotoshopExpress*", 
    "*EclipseManager*", "*NetworkSpeedTest*", "*ActiproSoftwareLLC*", "*AutodeskSketchBook*", 
    "*SpotifyMusic*", "*DolbyAccess*", "*MarchofEmpires*", "*BubbleWitch*", 
    "*DisneyMagicKingdoms*", "*YourPhone*", "*windowscommunicationsapps*"
)

foreach ($AppName in $AppsToRemove) {
    Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like $AppName} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}

# Remove New Outlook for existing users
Get-AppxPackage -AllUsers Microsoft.OutlookForWindows -ErrorAction SilentlyContinue | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue

# Remove provisioned package so it doesn't install for new users
Get-AppxProvisionedPackage -Online |
Where-Object {$_.DisplayName -eq "Microsoft.OutlookForWindows"} |
Remove-AppxProvisionedPackage -Online -AllUsers -ErrorAction SilentlyContinue

# Stop the transcript cleanly
Stop-Transcript