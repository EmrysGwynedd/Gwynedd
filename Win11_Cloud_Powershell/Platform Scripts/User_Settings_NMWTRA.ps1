# This script copies and Sets User Level Files and Preferences. 
#
# Author : Richard Hughes
# Date   : 18/10/2024
#
#

###########################################   Parameters to be altered as required   ###########################################

# These Folders will be created if they do not exist
$Folders = @(
    @{dir = "C:\TG\Logs"}

)


# These Files will be copied and overwritten if not currently in use
$files = @(
    # Copy Cyngor Gwynedd background to local source
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/General_Files/EventLogFilters/Log-List.txt"; output = "C:\TG\Logs\Log-List.txt"}

)


# These Registary Settings will be Applied
$Regs = @(
    #Set Default Policies for Machine
    @{RKey = "Registry::HKCU\Software\Microsoft\Office\16.0\Outlook\Options\General"; RName = "DisableOutlookMobileHyperlink"; RVal = "1"; RType="DWORD"}
)





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
Start-Transcript -Path "C:\TG\Logs\Default_User_Settings.log" -Force


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


# Set User Level Registy items

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

# Stop the transcript
Stop-Transcript -WarningAction SilentlyContinue












