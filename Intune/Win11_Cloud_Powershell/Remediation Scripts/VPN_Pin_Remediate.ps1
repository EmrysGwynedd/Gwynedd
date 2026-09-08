## This Script will PIN the Cisco Notification Icon and to the System Tray if it is NOT already pinned.
## Script is written in such a way that it will return correct sequence for Intune Remediation script
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
               Set-ItemProperty -Path $MPath -Name $RegName -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
         
           }
        }
    } catch {
        Write-Warning "Error"

    }
}

