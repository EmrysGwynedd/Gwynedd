Write-Host "CISCO SOFTWARE BEFORE INSTALL" -ForegroundColor Cyan

Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* -ErrorAction SilentlyContinue |
    Where-Object {$_.DisplayName -like "*Cisco*"} |
    Select-Object DisplayName,DisplayVersion,Publisher |
    Sort-Object DisplayName |
    Format-Table -AutoSize |
    Out-Host

Start-Process -FilePath "msiexec.exe" -ArgumentList @(
    '/package'
    '"C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-core-vpn-predeploy-k9.msi"'
    '/norestart'
    '/passive'
    'PRE_DEPLOY_DISABLE_VPN=0'
    '/lvx*'
    '"C:\TG\Logs\anyconnect-win-5.1.19.1862-core-vpn-predeploy-k9.log"'
) -Wait

Start-Process -FilePath "msiexec.exe" -ArgumentList @(
    '/package'
    '"C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-nam-predeploy-k9.msi"'
    '/norestart'
    '/passive'
    '/lvx*'
    '"C:\TG\Logs\anyconnect-win-5.1.19.1862-nam-predeploy-k9.log"'
) -Wait

Start-Process -FilePath "msiexec.exe" -ArgumentList @(
    '/package'
    '"C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-iseposture-predeploy-k9.msi"'
    '/norestart'
    '/passive'
    '/lvx*'
    '"C:\TG\Logs\anyconnect-win-5.1.19.1862-iseposture-predeploy-k9.log"'
) -Wait

Start-Process -FilePath "msiexec.exe" -ArgumentList @(
    '/package'
    '"C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-dart-predeploy-k9.msi"'
    '/norestart'
    '/passive'
    '/lvx*'
    '"C:\TG\Logs\anyconnect-win-5.1.19.1862-dart-predeploy-k9.log"'
) -Wait

Write-Host "CISCO SOFTWARE AFTER INSTALL" -ForegroundColor Green

Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* -ErrorAction SilentlyContinue |
    Where-Object {$_.DisplayName -like "*Cisco*"} |
    Select-Object DisplayName,DisplayVersion,Publisher |
    Sort-Object DisplayName |
    Format-Table -AutoSize |
    Out-Host