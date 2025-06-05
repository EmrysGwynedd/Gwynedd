@ECHO OFF
echo Enabling WinRM
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command Enable-PSRemoting -SkipNetworkProfileCheck -Force
echo 
echo ***************************************************************
echo ** RHEDEG SGAN YN UNIG ****************************************
echo ** BIOS, FIRMWARE A *******************************************
echo ** DRIVERS NAWR!! *********************************************
echo ***************************************************************
echo
echo ***************************************************************
echo ** Mewngofnodi efo cyfrif *************************************
echo ** gweinyddol efo MAD01\ ar y cychwyn! ************************
echo ***************************************************************
echo
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command %~dp0Lenovo_CHECK.ps1
echo ***************************************************************
echo ** Pobeth Wedi Ei Gwbwlhau! ***********************************
echo ***************************************************************
echo
pause
