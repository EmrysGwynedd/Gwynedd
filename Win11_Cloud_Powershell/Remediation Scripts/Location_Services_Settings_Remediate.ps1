## Script is written in such a way that it will return correct sequence for Intune Remediation script
##
## Author  : Richard Hughes
## Date    : 09/09/2025
## Type    : Remediation Script
## Version : 1.2
##


# These Registary Settings will be Applied
$Regs = @(
    #Set Default Policies for Users via Default User
    # Set Default Policies for Intranet zone (Set Security to High/Customable)
    @{RKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"; RName = "Value"; RVal = "Allow"; RType="String"},
    @{RKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"; RName = "ShowGlobalPrompts"; RVal = "0"; RType="DWord"}

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
Start-Transcript -Path "C:\TG\Logs\Registry_Location_Settings.log" -Force

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