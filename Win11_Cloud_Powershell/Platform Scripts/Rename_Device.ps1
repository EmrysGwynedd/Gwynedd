# This script renames the device to LAPH-%serial% or PCH-%serial% during the autopilot phase. 
#
# Author      : Richard Hughes
# Date        : 08/11/2024
#
# Modified    : 17/01/25
# Modified by : Richard Hughes
# Version     : 1.2

#############################################################################################

# Create folder for Lof Files
If(!(test-path -PathType container C:\TG\Logs))
 {New-Item -ItemType Directory -Path C:\TG\Logs}

# Start the transcript and specify the log file path
Start-Transcript -Path "C:\TG\Logs\Device_Rename.log" -Force


# Define prefixes
$PrefixWithBattery = 'LAPH-'
$PrefixWithoutBattery = 'PCH-'


# Detect if the device name Starts with "LAPAZ-"
    if ($env:COMPUTERNAME -like "LAPAZ-*") 
    {
        Write-Host "Device Needs to be renamed"
        
        # Check if the device has a battery
        $Battery = Get-WmiObject -Query "Select * from Win32_Battery"

        if ($Battery) 
          {
          $Prefix = $PrefixWithBattery
          }
          else
          {
          $Prefix = $PrefixWithoutBattery
          }
    
        # Get the serial number
        $Serial = Get-WMIObject -Class "Win32_BIOS" | Select -Expand SerialNumber

        # Form the new computer name
        $NewComputername = $Prefix + $Serial

        # Rename the computer
        Rename-Computer -NewName $NewComputername -Force -Restart
        # Stop the transcript
        Stop-Transcript -WarningAction SilentlyContinue
        Exit 0
    }
    else
    {
    Write-Host "Device rename already happened"
    # Stop the transcript
    Stop-Transcript -WarningAction SilentlyContinue    
    Exit 0
    }






