$PasswordSettings = Get-CimInstance -Namespace root\wmi -ClassName Lenovo_BiosPasswordSettings
$PasswordSettings.PasswordState

#Connect to the Lenovo_BiosSetting WMI class
$SettingList = Get-CimInstance -Namespace root\wmi -ClassName Lenovo_BiosSetting

#Return a specific setting and value
$SettingList | Where-Object CurrentSetting -Like "Secureboot*" | Select-Object -ExpandProperty CurrentSetting