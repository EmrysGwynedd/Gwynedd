@ECHO OFF
echo Enabling WinRM
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command Enable-PSRemoting -SkipNetworkProfileCheck -Force
echo *
echo ***************************************************************
echo ** RHEDEG SGAN A GOSOD ****************************************
echo ** BIOS, FIRMWARE NAWR! ***************************************
echo ***************************************************************
echo *
echo ***************************************************************
echo ** Mewngofnodi efo cyfrif *************************************
echo ** gweinyddol efo MAD01\ ar y cychwyn! ************************
echo ***************************************************************
echo *
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command %~dp0Lenovo_BIOS_Firmware.ps1
echo ***************************************************************
echo ** MAE'R BROSES WEDI EI GWBWLHAU! *****************************
echo ***************************************************************
echo *
echo *
echo *
 SET /P yesno=A OES ANGEN AIL GYCHWYN Y DDYFAIS? [Y/N]:
    IF "%yesno%"=="y" GOTO Confirmation
    IF "%yesno%"=="Y" GOTO Confirmation
    IF "%yesno%"=="n" GOTO End
    IF "%yesno%"=="N" GOTO End
    
    :Confirmation
    echo *
    echo *
    echo *
    echo ***************************************************************
    echo ** DYFAIS YN AILGYCHWYN NAWR! *********************************
    echo ***************************************************************
    
    shutdown.exe /r 
    
    GOTO EOF
    :End
    
    echo *
    echo *
    echo *
    echo ***************************************************************
    echo ** AILGYCHWYN WEDI EI GANSLO **********************************
    echo ***************************************************************
    
    
    TIMEOUT 5 >nul
    
    :EOF
    exit
