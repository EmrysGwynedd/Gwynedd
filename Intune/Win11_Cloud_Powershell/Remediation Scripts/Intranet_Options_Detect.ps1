## This Script will detect if the registry values are correct for Authentication PassThru on Intranet a Trusted Site Zones .
## Script is written in such a way that it will return correct sequence for Intune Detection script
##
## Author  : Richard Hughes
## Date    : 10/01/2025
## Type    : Detection Script
## Version : 1.4
##

$Path1 = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
$Path2 = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
$Path3 = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$Name = "1a00"
$Name1 = "1400"
$Name2 = "1402"

$Value = 0


Try {
    $Registry1 = Get-ItemProperty -Path $Path1 -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
    $Registry2 = Get-ItemProperty -Path $Path2 -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
    $Registry3 = Get-ItemProperty -Path $Path3 -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
    $Registry4 = Get-ItemProperty -Path $Path1 -Name $Name1 -ErrorAction Stop | Select-Object -ExpandProperty $Name1
    $Registry5 = Get-ItemProperty -Path $Path2 -Name $Name1 -ErrorAction Stop | Select-Object -ExpandProperty $Name1
    $Registry6 = Get-ItemProperty -Path $Path3 -Name $Name1 -ErrorAction Stop | Select-Object -ExpandProperty $Name1
    $Registry7 = Get-ItemProperty -Path $Path1 -Name $Name2 -ErrorAction Stop | Select-Object -ExpandProperty $Name2
    $Registry8 = Get-ItemProperty -Path $Path2 -Name $Name2 -ErrorAction Stop | Select-Object -ExpandProperty $Name2
    $Registry9 = Get-ItemProperty -Path $Path3 -Name $Name2 -ErrorAction Stop | Select-Object -ExpandProperty $Name2

    If (($Registry1 -eq $Value) -and ($Registry2 -eq $Value) -and ($Registry3 -eq $Value) -and ($Registry4 -eq $Value) -and ($Registry5 -eq $Value) -and ($Registry6 -eq $Value) -and ($Registry7 -eq $Value) -and ($Registry8 -eq $Value) -and ($Registry9 -eq $Value)){
        Write-Output "All PassThrough settings are correct"
        #Exit 0
    }
    Else
    { 
    Write-Warning "Script Needs to Run to correct the settings"
    #Exit 1
    }
} 
Catch {
    Write-Warning "Registry Item not found or an Error occurred when searching"
    #Exit 1
}