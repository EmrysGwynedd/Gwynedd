## This Script will Remediate the Fastboot Settings
## Script is written in such a way that it will return correct exit code
##
## Author  : Richard Hughes
## Date    : 16/09/2025
## Type    : Remediate Script
## Version : 1.2
##
$Path = "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$Name = "HiberbootEnabled"
$Type = "DWORD"
$Value = 0

try{
    if(!(Test-Path $Path)){New-Item -Path $Path -Force}
    if(!$Name){Set-Item -Path $Path -Value $Value}
    else{Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type}
    Write-Output "Value set: $Name = $Value"
}catch{
    Write-Error $_
}