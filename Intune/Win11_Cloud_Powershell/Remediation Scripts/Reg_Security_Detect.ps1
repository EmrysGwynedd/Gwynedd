## This Script will detect if the registry values are correct for Security fixes and remediations
## Script is written in such a way that it will return correct sequence for Intune Detection script
##
## Author  : Richard Hughes
## Date    : 22/04/2026
## Type    : Detection Script
## Version : 1.5
##


# Define the registry paths and expected values
$registryChecks = @(
    @{ Path = "HKLM:\Software\Microsoft\Cryptography\Wintrust\Config"; Name = "EnableCertPaddingCheck"; Expected = "1" },
    @{ Path = "HKLM:\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config"; Name = "EnableCertPaddingCheck"; Expected = "1" },
    @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"; Name = "RequireSecuritySignature"; Expected = "1" }
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

