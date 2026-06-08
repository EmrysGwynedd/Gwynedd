## This Script will detect if the registry values are correct for Authentication PassThru on Intranet a Trusted Site Zones .
## Script is written in such a way that it will return correct sequence for Intune Remediation script
##
## Author  : Richard Hughes
## Date    : 10/01/2025
## Type    : Remediation Script
## Version : 1.4
##


# These Registary Settings will be Applied
$Regs = @(
    #Set Default Policies for Users via Default User
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
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1400"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1402"; RVal = "0"; RType="DWORD"},
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
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"; RName = "1803"; RVal = "0"; RType="DWORD"},
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
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1001"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1004"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1200"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1201"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1206"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1207"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1208"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1209"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "120a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "120b"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "120c"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1400"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1402"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1405"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1406"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1407"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1409"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1601"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1604"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1605"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1606"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1607"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1608"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1609"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "160a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1800"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1802"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1803"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1804"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1807"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1808"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1809"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "180a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "180b"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a02"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a03"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a04"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a05"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1a06"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1c00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "1e05"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2000"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2001"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2004"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2005"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2100"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2101"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2102"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2103"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2104"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2105"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2106"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2200"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2201"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2300"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2301"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2400"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2401"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2402"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2500"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2600"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"; RName = "2700"; RVal = "0"; RType="DWORD"},

    # Set Default Policies for Internet zones (Set Security to High/Customable)
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1001"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1004"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1200"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1201"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1206"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1207"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1208"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1209"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "120a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "120b"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "120c"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1400"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1402"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1405"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1406"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1407"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1409"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1601"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1604"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1605"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1606"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1607"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1608"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1609"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "160a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1800"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1802"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1803"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1804"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1807"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1808"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1809"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "180a"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "180b"; RVal = "1"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a02"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a03"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a04"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a05"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1a06"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1c00"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1e05"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2000"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2001"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2004"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2005"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2100"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2101"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2102"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2103"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2104"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2105"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2106"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2200"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2201"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2300"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2301"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2400"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2401"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2402"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2500"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2600"; RVal = "3"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "2700"; RVal = "0"; RType="DWORD"}

)

#############################################       End of Parameters section       ######################################################################



###############################################################################
##############                                                  ###############
##############                                                  ###############
##############   Main Script  ( do not alter below this line)   ###############
##############                                                  ###############
##############                                                  ###############
###############################################################################

# Start the transcript and specify the log file path
Start-Transcript -Path "C:\TG\Logs\Internet_Options_Settings.log" -Force

# Set Machine Level Registy items

# Install Setting for Administrative Unlock to work with Windows 11

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


# Stop the transcript
Stop-Transcript -WarningAction SilentlyContinue
