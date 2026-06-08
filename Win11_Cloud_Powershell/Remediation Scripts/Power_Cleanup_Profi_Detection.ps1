## Power Settings Clean up (Dros Dro).
## Script is written in such a way that it will return correct sequence for Intune Detection script
##
## Author  : Richard Hughes
## Date    : 22/10/2025
## Type    : Detection Script
## Version : 1.0
##

$Path = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$Name1 = "1400"
$Name2 = "1402"
$Name3 = "1803"
$Value = 0


Try {
    $Registry1 = Get-ItemProperty -Path $Path -Name $Name1 -ErrorAction Stop | Select-Object -ExpandProperty $Name1
    $Registry2 = Get-ItemProperty -Path $Path -Name $Name2 -ErrorAction Stop | Select-Object -ExpandProperty $Name2
    $Registry3 = Get-ItemProperty -Path $Path -Name $Name3 -ErrorAction Stop | Select-Object -ExpandProperty $Name3

    If (($Registry1 -eq $Value) -and ($Registry2 -eq $Value) -and ($Registry3 -eq $Value))
    {
        Write-Output "All PassThrough settings are correct"
        Exit 0
    }
    Else
    { 
    Write-Warning "Script Needs to Run to correct the settings"
    Exit 1
    }
} 
Catch {
    Write-Warning "Registry Item not found or an Error occurred when searching"
    Exit 1
}