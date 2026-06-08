## This Script will ldetect if the background colour on the desktop is set to the correct value.
## Script is written in such a way that it will return correct sequence for Intune Detection script
##
## Author  : Richard Hughes
## Date    : 10/12/2024
## Type    : Detection Script
## Version : 1.0
##

$Path = "Registry::HKEY_CURRENT_USER\Control Panel\Colors"
$Name = "Background"
$Value = "57 80 73"

Try {
    $Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
    If ($Registry -eq $Value){
        Write-Output "Background Colour set to Correct value"
        Exit 0
    } 
    Write-Warning "Background Colour value need to be Changed."
    Exit 1
} 
Catch {
    Write-Warning "Registry Item not found or an Error occurred when searching"
    Exit 1
}