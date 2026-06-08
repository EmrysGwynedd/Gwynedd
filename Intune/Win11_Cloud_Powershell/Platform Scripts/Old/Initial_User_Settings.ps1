# This script Sets User Default settings after initial login
#
# Author : Richard Hughes
# Date   : 06/01/25
#
#

###########################################   Parameters to be altered as required   ###########################################

# These Registary Settings will be Applied
$Regs = @(
    #Set Default Policies for Machine
    # Set Default Policies for Intranet zone (Set Security to High/Customable)
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1001"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1004"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1200"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1201"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1206"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1207"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1208"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1209"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "120a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "120b"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "120c"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1400"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1402"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1405"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1406"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1407"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1409"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1601"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1604"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1605"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1606"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1607"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1608"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1609"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "160a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1800"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1802"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1803"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1804"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1807"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1808"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1809"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "180a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "180b"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a02"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a03"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a04"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a05"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a06"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1c00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1e05"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2000"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2001"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2004"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2005"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2100"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2101"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2102"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2103"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2104"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2105"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2106"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2200"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2201"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2300"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2301"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2400"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2401"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2402"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2500"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2600"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2700"; RVal = "0"; RType="DWORD"},

    # Set Default Policies for Trusted zones (Set Security to High/Customable)
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1001"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1004"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1200"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1201"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1206"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1207"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1208"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1209"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "120a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "120b"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "120c"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1400"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1402"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1405"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1406"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1407"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1409"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1601"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1604"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1605"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1606"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1607"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1608"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1609"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "160a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1800"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1802"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1803"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1804"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1807"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1808"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1809"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "180a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "180b"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a02"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a03"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a04"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a05"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1a06"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1c00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1e05"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2000"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2001"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2004"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2005"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2100"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2101"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2102"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2103"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2104"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2105"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2106"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2200"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2201"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2300"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2301"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2400"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2401"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2402"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2500"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2600"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "2700"; RVal = "0"; RType="DWORD"},

    #Sets Background Colour   
    @{RKey = "Registry::HKCU\Control Panel\Colors"; RName = "Background"; RVal = "57 80 73"; RType="String"}
)




##############   Main Script  ( do not alter below this line) ###############



# Set User Level Registy items
# Load Default User Profile Hive

foreach ($Reg in $Regs)
{
 if (Test-Path $Reg.RKey) 
 {New-ItemProperty -Path $Reg.RKey -Name $Reg.RName -Value $Reg.RVal -PropertyType $Reg.RType -Force } 
 else 
 { 
 New-Item -Path $Reg.RKey -Force
 New-ItemProperty -Path $Reg.RKey -Name $Reg.RName -Value $Reg.RVal -PropertyType $Reg.RType -Force 
 }
}







