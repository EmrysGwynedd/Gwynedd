## Power Settings Clean up (Dros Dro).
## Script is written in such a way that it will return correct sequence for Intune Remediation script
##
## Author  : Richard Hughes
## Date    : 22/10/2025
## Type    : Remediation Script
## Version : 1.0
##


# These Registary Settings will be Applied
$Regs = @(
    

    # Set Default Policies for Trusted zones (Set Security to High/Customable)
    @{RKey = "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1400"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1402"; RVal = "0"; RType="DWORD"},
    @{RKey = "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"; RName = "1803"; RVal = "0"; RType="DWORD"}
   
)

#############################################       End of Parameters section       ######################################################################



###############################################################################
##############                                                  ###############
##############                                                  ###############
##############   Main Script  ( do not alter below this line)   ###############
##############                                                  ###############
##############                                                  ###############
###############################################################################

# Start the transcript and specify the log file path
Start-Transcript -Path "C:\TG\Logs\PowerSettings_Cleanup.log" -Force

# Set Machine Level Registy items

# Install Setting for Administrative Unlock to work with Windows 11

foreach ($Reg in $Regs)
{
 if (Test-Path $Reg.RKey) 
 {New-ItemProperty -Path $Reg.RKey -Name $Reg.RName -Value $Reg.RVal -PropertyType $Reg.RType -Force } 
 else 
 { 
 New-Item -Path $Reg.RKey -Force
 New-ItemProperty -Path $Reg.RKey -Name $Reg.RName -Value $Reg.RVal -PropertyType $Reg.RType -Force 
 }
}


# Stop the transcript
Stop-Transcript -WarningAction SilentlyContinue
