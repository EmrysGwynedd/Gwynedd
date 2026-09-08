# This script Sets User Default settings after initial login
# Author : Emrys

# These Folders will be created if they do not exist
$Folders = @(
    @{dir = "C:\TG\Logs"}

)

# These Files will be copied and overwritten if not currently in use
$files = @(
    # Copy Teams Background files to local source
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/99b5bfb7-e775-4af0-94a3-07f18320be89.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\99b5bfb7-e775-4af0-94a3-07f18320be89.png";},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/99b5bfb7-e775-4af0-94a3-07f18320be89_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\99b5bfb7-e775-4af0-94a3-07f18320be89_thumb.png"}
)

# These Registry Settings will be Applied
$Regs = @(
    #Sets Background Colour   
    @{RKey = "Registry::HKCU\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"}
)
                                   
#####  Start Logging Scripts to C:\TG\Logs  #####
Start-Transcript -Path "C:\TG\Logs\Default_User_Settings_First_Logon.log"

########  Check Directory structure exists and if not create  ###########
foreach ($Folder in $Folders) 
{
If(!(test-path -PathType container $Folder.dir))
 {
 New-Item -ItemType Directory -Path $Folder.dir
 }
}

#####  Check if files exist on local host and if not copy the Files from the Web Storage to the Local Locations  #####

  # Check if the Teams Background directory exists
  if (Test-Path -Path $env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds) {
  }  else   {
   New-Item -Path $env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams -Name Backgrounds -ItemType Directory
  }
  # Check if the Teams Uploads directory exists
  if (Test-Path -Path $env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads) {
  }  else   {
   New-Item -Path $env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds -Name Uploads -ItemType Directory
  }

#####  Copy files to machine in user context if they do not already exist  #####
foreach ($file in $files) 
{
sleep -Seconds 1
write-host ""
write-host $file.output
# Check if the destination file exists
if (Test-Path -Path $file.output) {
} else {
    $response = Invoke-WebRequest -Uri $file.url -OutFile $file.output
}
}

#####  Load Registry Settings  #####
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

#####  Set Flag file to indicate script has run
# Define the file path
$flagFilePath = "C:\TG\Fflagiau\User_First_Logon_Settings.flg"

# Get the current date and time
$currentDateTime = Get-Date -Format "dd-MM-yyyy HH:mm:ss"

# Optional: Output a message to confirm the file creation
Write-Output "Script file to set initial user settings was run on : $currentDateTime      for user   $env:USERNAME" | Out-File -FilePath $flagFilePath -Force

#First Time open Teams
Start-Process "msteams:"

# Stop Collecting LogFile
Stop-Transcript