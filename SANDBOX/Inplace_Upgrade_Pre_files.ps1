# Mae hwn ond yn cynnwys y bit ffeiliau o sgript Machine Settings


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
Start-Transcript -Path "C:\TG\Logs\Default_Machine_Settings_files.log" -Force


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

# Stop the transcript
Stop-Transcript -WarningAction SilentlyContinue