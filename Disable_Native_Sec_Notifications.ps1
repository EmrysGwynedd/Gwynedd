# Disable Native Notifications
If((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications") -ne $true) 
 {  
 New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" -force -ea SilentlyContinue 
 }
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications' -Name 'DisableNotifications' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;