#Lenovo_BiosSetting WMI class
$SettingList = Get-CimInstance -Namespace root\wmi -ClassName Lenovo_BiosSetting
$SettingList | Where-Object CurrentSetting -Like "Secureboot*" | Select-Object -ExpandProperty CurrentSetting