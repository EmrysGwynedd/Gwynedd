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
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Desktop_Backgrounds/Cyngor_Gwynedd/Cefndir.png"; output = "C:\TG\Logs\Cefndir.png"}

)


# These Registary Settings will be Applied
$Regs = @(
    #Set Default Policies for Machine
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"}
)




##############   Main Script  ( do not alter below this line) ###############


# Check Directory structure exists and if not create
foreach ($Folder in $Folders) 
{
If(!(test-path -PathType container $Folder.dir))
 {
 #New-Item -ItemType Directory -Path $Folder.dir
 }
}


# Check if files exist on local host and if not copy the Files from the Web Storage to the Local Locations
foreach ($file in $files) 
{
#sleep -Seconds 2
#write-host ""
#write-host $file.output
# Check if the destination file exists
if (Test-Path -Path $file.output) {
} else {
 #   $response = Invoke-WebRequest -Uri $file.url -OutFile $file.output
}
}



# Set Machine Level Registy items
# Load Default User Profile Hive




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







