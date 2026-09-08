$PasswordSettings = Get-CimInstance -Namespace root\wmi -ClassName Lenovo_BiosPasswordSettings
$PasswordSettings.PasswordState