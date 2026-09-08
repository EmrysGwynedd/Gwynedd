## This Script will look for the Cisco Notification Icon and check to see if it is already pinned to the system Tray.
## Script is written in such a way that it will return correct sequence for Intune Detection script
##
## Author  : Richard Hughes
## Date    : 10/12/2024
## Type    : Detection Script
## Version : 1.2
##


# Define the base registry path and the value you are looking for
$RegPath = "Registry::"
$baseRegistryPath = "Registry::HKCU\Control Panel\NotifyIconSettings"
$searchValue = "Cisco Secure Client"
$RegName = "IsPromoted"
$RegVal = 1

# Get all subkeys within the base registry path
$subKeys = Get-ChildItem -Path $baseRegistryPath

# Initialize an array to hold matching keys
$matchingKeys = @()

# Loop through each subkey to find the value
foreach ($subKey in $subKeys) {
    try {
        # Get all properties of the subkey
        $properties = Get-ItemProperty -Path $subKey.PSPath

        # Check if any property value matches the search value
        foreach ($property in $properties.PSObject.Properties) 
           {
            if ($property.Value -eq $searchValue) 
               {
               $MPath = $Regpath + $subKey
               Write-Host $MPath
               $Registry = Get-ItemProperty -Path $MPath -Name $RegName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $RegName
                  If ($Registry -eq $RegVal)
                  {
                  Write-Host "Already Pinned to System Tray" -ForegroundColor Green
                  Exit 0
                  }
                  Else
                  {
                  Write-Host "Needs to be Changed" -ForegroundColor Red
                  Exit 1
                  }        
               }
        }
    } catch {
        Write-Warning "Error"
        Exit 1
    }
}
 
