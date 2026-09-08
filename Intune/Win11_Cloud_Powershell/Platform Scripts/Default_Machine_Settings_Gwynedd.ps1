# This script copies and Sets Machine Level Files and Preferences for Gwynedd Machine Profile. 
#
# Author      : Richard Hughes
# Date        : 18/10/2024
#
# Modified    : 10/01/25
# Modified by : Richard Hughes
# Version     : 1.4

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
    @{dir = "C:\Program Files\DTINFO"},
    @{dir = "C:\Users\Default\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState"},
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

    #Default StartMenu Layout
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/General_Files/StartLayout/start2.bin"; output = "C:\Users\Default\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin"},

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
    #@{RKey = "HKLM:\DEFUSER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; RName = "Lenovo Driver Updates"; RVal = "C:\Program Files\Lenovo\SUHelper.exe -autoupdate"; RType="String"},
    @{RKey = "HKLM:\DEFUSER\Software\Policies\Microsoft\Office\16.0\Outlook\Options\General"; RName = "DisableOutlookMobileHyperlink"; RVal = "1"; RType="DWORD"}
    @{RKey = "HKLM:\DEFUSER\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"},
    @{RKey = "Registry::HKEY_USERS\.DEFAULT\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"},    

    #Set Default Policies for Machine
    # Set Default Policies for Intranet zone (Set Security to High/Customable)
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1001"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1004"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1200"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1201"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1206"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1207"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1208"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1209"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "120a"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "120b"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "120c"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1400"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1402"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1405"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1406"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1407"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1409"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1601"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1604"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1605"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1606"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1607"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1608"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1609"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "160a"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1800"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1802"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1803"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1804"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1807"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1808"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1809"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "180a"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "180b"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a00"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a02"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a03"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a04"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a05"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a06"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1c00"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1e05"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2000"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2001"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2004"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2005"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2100"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2101"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2102"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2103"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2104"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2105"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2106"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2200"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2201"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2300"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2301"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2400"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2401"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2402"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2500"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2600"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2700"; RVal = "0"; RType="DWORD"},

    # Set Default Policies for Trusted zones (Set Security to High/Customable)
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1001"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1004"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1200"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1201"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1206"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1207"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1208"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1209"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "120a"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "120b"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "120c"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1400"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1402"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1405"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1406"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1407"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1409"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1601"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1604"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1605"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1606"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1607"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1608"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1609"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "160a"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1800"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1802"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1803"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1804"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1807"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1808"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1809"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "180a"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "180b"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a00"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a02"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a03"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a04"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a05"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a06"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1c00"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1e05"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2000"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2001"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2004"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2005"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2100"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2101"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2102"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2103"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2104"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2105"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2106"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2200"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2201"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2300"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2301"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2400"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2401"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2402"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2500"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2600"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2700"; RVal = "0"; RType="DWORD"},

# Set Default Policies for Internet zones (Set Security to High/Customable)
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1001"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1004"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1200"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1201"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1206"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1207"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1208"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1209"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "120a"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "120b"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "120c"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1400"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1402"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1405"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1406"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1407"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1409"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1601"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1604"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1605"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1606"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1607"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1608"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1609"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "160a"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1800"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1802"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1803"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1804"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1807"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1808"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1809"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "180a"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "180b"; RVal = "1"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a00"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a02"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a03"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a04"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a05"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a06"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1c00"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1e05"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2000"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2001"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2004"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2005"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2100"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2101"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2102"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2103"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2104"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2105"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2106"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2200"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2201"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2300"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2301"; RVal = "0"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2400"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2401"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2402"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2500"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2600"; RVal = "3"; RType="DWORD"},
    @{RKey = "HKLM:\DEFUSER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2700"; RVal = "0"; RType="DWORD"},


    # Registry Keys to make Administrative Unlock Functional
    @{RKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{B986C180-0798-4DF5-A611-A1991AA890B9}"; RName = "(Default)"; RVal = "AdministrativeUnlock"; RType="String"},
    @{RKey = "Registry::HKEY_CLASSES_ROOT\CLSID\{B986C180-0798-4DF5-A611-A1991AA890B9}"; RName = "(Default)"; RVal = "AdministrativeUnlock"; RType="String"},
    @{RKey = "Registry::HKEY_CLASSES_ROOT\CLSID\{B986C180-0798-4DF5-A611-A1991AA890B9}\InprocServer32"; RName = "(Default)"; RVal = "AdministrativeUnlock.dll"; RType="String"},
    @{RKey = "Registry::HKEY_CLASSES_ROOT\CLSID\{B986C180-0798-4DF5-A611-A1991AA890B9}\InprocServer32"; RName = "ThreadingModel"; RVal = "Apartment"; RType="String"}
)


#############################################       End of Parameters section       ######################################################################



###############################################################################
##############                                                  ###############
##############                                                  ###############
##############   Main Script  ( do not alter below this line)   ###############
##############                                                  ###############
##############                                                  ###############
###############################################################################

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


# Set Environment Variable for Cronfeydd Data
$variableName = 'CRONFEYDDDATA'
$desiredValue = 'C:\TG\Cronfeydd Data'

$currentValue = [System.Environment]::GetEnvironmentVariable($variableName, 'Machine')

if ($currentValue -ne $desiredValue) {
    [System.Environment]::SetEnvironmentVariable($variableName, $desiredValue, 'Machine')
    Write-Host "Variable $variableName has been set to $desiredValue."
} else {
    Write-Host "Variable $variableName is already set correctly."
}


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


# Stop the transcript
Stop-Transcript -WarningAction SilentlyContinue



