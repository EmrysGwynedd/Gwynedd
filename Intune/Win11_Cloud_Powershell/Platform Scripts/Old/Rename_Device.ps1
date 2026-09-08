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
        Exit 0
    }
    else
    {
    Write-Host "Device rename already happened"
    Exit 0
    }






