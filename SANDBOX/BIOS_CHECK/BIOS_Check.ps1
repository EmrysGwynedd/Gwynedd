Get-CimInstance Win32_BIOS | Select-Object SMBIOSBIOSVersion, BIOSVersion, ReleaseDate | Format-Table -AutoSize | Out-Host
Read-Host "Gwiriwch y gwybodaeth uchod i weld os angen ei uwchraddio"