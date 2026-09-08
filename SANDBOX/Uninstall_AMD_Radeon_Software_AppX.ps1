Get-AppxPackage -AllUsers | Where-Object { $_.InstallLocation -like "*AdvancedMicroDevicesInc-2.AMDRadeonSoftware*" } | Remove-AppxPackage -AllUsers

Get-AppxPackage -AllUsers | Where-Object { $_.InstallLocation -like "*AdvancedMicroDevicesInc-RSXCM*" } | Remove-AppxPackage -AllUsers