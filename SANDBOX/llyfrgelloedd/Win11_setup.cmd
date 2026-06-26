@echo off
setlocal

:: Creu a newid defnyddwyr priodol
net user Llyfrgell D!n0rw!g2022* /add
net localgroup Administrators Llyfrgell /add
net user Llyfrgell /active:yes
net user Llyfrgell /expires:never
net user Administrators /active:no
net user defaultUser0 /delete

:: Dileu y Regkeys i bypass'io first startup
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DefaultAccountAction" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DefaultAccountSAMName" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DefaultAccountSID" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "LaunchUserOOBE" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v SkipMachineOOBE /t REG_DWORD /d 1 /f

:: Newid enw y PC i'r un cywir
set /p NewPCName=Enw'r PC: 
WMIC computersystem where name="%COMPUTERNAME%" call rename name="%NewPCName%"

:: Newid enw PC
echo Enw PC wedi newid i %NewPCName%. Mi fydd y PC yn ail gychwyn rwan.
pause
Shutdown /r /t 0