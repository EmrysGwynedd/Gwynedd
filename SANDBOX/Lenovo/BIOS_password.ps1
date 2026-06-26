$PasswordSettings = Get-WmiObject -Namespace root\wmi -Class Lenovo_BiosPasswordSettings
$PasswordSettings.PasswordState
$PasswordSet = Get-WmiObject -Namespace root\wmi -Class Lenovo_SetBiosPassword
$PasswordSet.SetBiosPassword("pap,nmwtra,cg679114cg,ascii,us")