## This Script will Change the value if the background colour on the desktop is not set to the correct value.
## Script is written in such a way that it will return correct sequence for Intune Remediation script
##
## Author  : Richard Hughes
## Date    : 10/12/2024
## Type    : Remediation Script
## Version : 1.0
##

$Path = "Registry::HKEY_CURRENT_USER\Control Panel\Colors"
$Name = "Background"
$Value = "57 80 73"

try{
    if(!(Test-Path $Path)){New-Item -Path $Path -Force}
    if(!$Name){Set-Item -Path $Path -Value $Value}
    else{Set-ItemProperty -Path $Path -Name $Name -Value $Value}
    Write-Output "Value set: $Name = $Value"
}catch{
    Write-Error $_
}