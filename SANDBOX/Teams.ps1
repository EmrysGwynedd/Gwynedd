Get-Process -Name "ms-teams"
$apps = Get-AppxPackage -AllUsers | Select-Object Name, PackageFullName
$apps
$app = $apps | Where-Object { $_.Name -eq "MSTeams" }
$app.PackageFullName
Start-Process -FilePath "C:\Program Files\WindowsApps\$($app.PackageFullName)\ms-teams.exe"
Export-ModuleMember -Variable 'app'