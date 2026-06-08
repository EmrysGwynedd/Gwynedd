## This Script will detect if the registry values are correct for Security fixes and remediations
## Script is written in such a way that it will return correct sequence for Intune Detection script
##
## Author  : Richard Hughes
## Date    : 16/09/2025
## Type    : Detection Script
## Version : 1.2
##

# Define the registry paths and expected values
$registryChecks = @(
    @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"; Name = "HiberbootEnabled"; Expected = "0" }

)

$allCorrect = $true

foreach ($check in $registryChecks) {
    try {
        $actualValue = Get-ItemPropertyValue -Path $check.Path -Name $check.Name -ErrorAction Stop
        if ($actualValue -ne $check.Expected) {
            $allCorrect = $false
        }
    } catch {
        $allCorrect = $false
    }
}

if ($allCorrect) {
    Write-Output "All Security registry settings are correct"
    exit 0
} else {
    Write-Output "Script Needs to Run to correct the settings"
    exit 1
}

