## Script is written in such a way that it will return correct sequence for Intune Remediation script
##
## Author  : Richard Hughes
## Date    : 22/04/2026
## Type    : Remediation Script
## Version : 1.5
##


# These Registary Settings will be Applied
$Regs = @(
    #Set Default Policies for Users via Default User
    # Set Default Policies for Intranet zone (Set Security to High/Customable)
    @{RKey = "HKLM:\Software\Microsoft\Cryptography\Wintrust\Config"; RName = "EnableCertPaddingCheck"; RVal = "1"; RType="String"},
    @{RKey = "HKLM:\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config"; RName = "EnableCertPaddingCheck"; RVal = "1"; RType="String"},
    @{RKey = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"; RName = "RequireSecuritySignature"; RVal = "1"; RType="DWord"}

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
Start-Transcript -Path "C:\TG\Logs\Registry_Security_Settings.log" -Force

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