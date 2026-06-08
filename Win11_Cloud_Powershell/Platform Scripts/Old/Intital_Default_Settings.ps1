# This script copies and Sets Machine Level Files and Preferences. 
#
# Author : Richard Hughes
# Date   : 18/10/2024
#
#

###########################################   Parameters to be altered as required   ###########################################

# These Folders will be created if they do not exist
$Folders = @(
    @{dir = "C:\TG"},
    @{dir = "C:\TG\Cronfeydd Data"},
    @{dir = "C:\TG\Fflagiau"},
    @{dir = "C:\TG\Dogfennau"},
    @{dir = "C:\ProgramData\Microsoft\Event Viewer\Views\Technoleg Gwybodaeth"},
    @{dir = "C:\Windows\System32\LogFiles\Firewall"},
    @{dir = "C:\Windows\Wallpaper"},
    @{dir = "C:\Program Files\DTINFO"},
    @{dir = "C:\ProgramData\Keysoft Solutions"}
)


# These Files will be copied and overwritten if not currently in use
$files = @(
    # Copy Cyngor Gwynedd background to local source
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/Cyngor_Gwynedd/Cefndir.png"; output = "C:\Windows\Wallpaper\Cefndir.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/Cyngor_Gwynedd/CefndirLock.png"; output = "C:\Windows\Web\Screen\CefndirLock.png"},
    
    # Copy DTINFO files to local source
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/DTINFO/DesktopInfo64.exe"; output = "C:\Program Files\DTINFO\DesktopInfo64.exe"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/DTINFO/desktopinfo.ini.txt"; output = "C:\Program Files\DTINFO\desktopinfo.ini"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/DTINFO/libeay32.dll"; output = "C:\Program Files\DTINFO\libeay32.dll"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/DTINFO/ssleay32.dll"; output = "C:\Program Files\DTINFO\ssleay32.dll"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/DTINFO/Desktop_Info.xml"; output = "C:\Program Files\DTINFO\Desktop_Info.xml"},

    #General Files
    #EventViewer Filter
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/General_Files/EventLogFilters/View_99.xml"; output = "C:\ProgramData\Microsoft\Event Viewer\Views\Technoleg Gwybodaeth\View_99.xml"},

        
    #Copy Admin Unlock File Locally
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Admin_Unlock/AdministrativeUnlock.dll"; output = "C:\Windows\System32\AdministrativeUnlock.dll"},
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
    @{RKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"; RName = "NoUseStoreOpenWith"; RVal = "1"; RType="DWORD"},
    
    #Set Default User Settings for all users
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; RName = "Wallpaper"; RVal = "C:\Windows\Wallpaper\Cefndir.png"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; RName = "WallpaperStyle"; RVal = "3"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"; RName = "TurnOffWindowsCopilot"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"; RName = "OneDrive For Business"; RVal = "C:\Program Files\Microsoft OneDrive\OneDrive.exe /background"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; RName = "OneDrive For Business"; RVal = "C:\Program Files\Microsoft OneDrive\OneDrive.exe"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; RName = "Initial User Settings"; RVal = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File 'C:\Program Files\Initialization\Initialization.ps1' "; RType="String"},
    @{RKey = "HKLM:\DEFUSER\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"},
    @{RKey = "Registry::HKEY_USERS\.DEFAULT\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"}, 
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\RunOnce"; RName = "Microsoft Teams"; RVal = "3"; RType="String"},    


    # Registry Keys to make Administrative Unlock Functional
    @{RKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{B986C180-0798-4DF5-A611-A1991AA890B9}"; RName = "(Default)"; RVal = "AdministrativeUnlock"; RType="String"},
    @{RKey = "Registry::HKEY_CLASSES_ROOT\CLSID\{B986C180-0798-4DF5-A611-A1991AA890B9}"; RName = "(Default)"; RVal = "AdministrativeUnlock"; RType="String"},
    @{RKey = "Registry::HKEY_CLASSES_ROOT\CLSID\{B986C180-0798-4DF5-A611-A1991AA890B9}\InprocServer32"; RName = "(Default)"; RVal = "AdministrativeUnlock.dll"; RType="String"},
    @{RKey = "Registry::HKEY_CLASSES_ROOT\CLSID\{B986C180-0798-4DF5-A611-A1991AA890B9}\InprocServer32"; RName = "ThreadingModel"; RVal = "Apartment"; RType="String"}
)




##############   Main Script  ( do not alter below this line) ###############


# Check Directory structure exists and if not create
foreach ($Folder in $Folders) 
{
If(!(test-path -PathType container $Folder.dir))
 {New-Item -ItemType Directory -Path $Folder.dir}
}


# Check if files exist on local host and if not copy the Files from the Web Storage to the Local Locations
foreach ($file in $files) 
{
sleep -Seconds 2
write-host ""
write-host $file.output
# Check if the destination file exists
if (Test-Path -Path $file.output) {
} else {
    $response = Invoke-WebRequest -Uri $file.url -OutFile $file.output
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
# Install Task Schedule for Desktop Info

# Check if the task exists
$TaskExists = Get-ScheduledTask -TaskName "Desktop Machine Info" -TaskPath "\" -ErrorAction SilentlyContinue

if (-not $TaskExists) {
    # Task does not exist, create it from xml file
    Register-ScheduledTask -xml (Get-Content "C:\Program Files\DTINFO\Desktop_Info.xml" | Out-String) -TaskName "Desktop Machine Info" -TaskPath "\"
} 




