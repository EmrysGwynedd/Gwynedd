PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command Enable-PSRemoting -SkipNetworkProfileCheck -Force
echo Gosod ypdets ac Drivers
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command %~dp0Initial_update.ps1