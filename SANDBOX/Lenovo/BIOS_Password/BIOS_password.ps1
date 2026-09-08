$PasswordSettings = Get-WmiObject -Namespace root\wmi -Class Lenovo_BiosPasswordSettings
$PasswordSettings.PasswordState
$PasswordSet = Get-WmiObject -Namespace root\wmi -Class Lenovo_SetBiosPassword
$PasswordSet.SetBiosPassword("pap,cg679114,cg679114,ascii,us")