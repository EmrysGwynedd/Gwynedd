???# Disable PUA Security warning (User Level)
If((Test-Path -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows Security Health\State") -ne $true) 
 {  
 New-Item "HKCU:\SOFTWARE\Microsoft\Windows Security Health\State" -force -ea SilentlyContinue 
 }
New-ItemProperty -LiteralPath 'HKCU:\SOFTWARE\Microsoft\Windows Security Health\State' -Name 'AppAndBrowser_PuaSmartScreenOff' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
