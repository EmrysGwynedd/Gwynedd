# Install Cisco Secure Client only if on Corporate Network
# Start Transcript Logs
$log = "C:\TG\Logs\Cisco-Transcripts.log"

Start-Transcript -Path $log -Append


#Set Variables 

# Set the latest version number
$Global:NoLan = 0
$Global:LatestVer = "5.1.13.177"

####################################################################################
####################################################################################


#Log File Details

Function Write-Log {
    param([string]$Message)

    $timestamp = (Get-Date).ToString("dd-MM-yyyy HH:mm:ss")
    Add-Content -Path "C:\TG\Logs\Cisco_Install.log" -Value "$timestamp : $Message"
}

Function LAN-Connected {
# Define your corporate network domain or subnet
$CorporateSubnet = "172.16."   # Change to match your LAN subnet

# Get current IPv4 addresses (excluding loopback)
$IPAddresses = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike "127.*" }).IPAddress

# Check if connected to corporate LAN
$OnCorporateLAN = $IPAddresses -match "^$CorporateSubnet"
Write-Log "The machine is currently connected to the corporate network with these IP addresses : $OnCorporateLAN"

# Detect VPN connection by looking for common VPN interfaces
$VPNConnected = Get-NetAdapter | Where-Object { $_.InterfaceDescription -match "VPN|Cisco|Fortinet|Pulse" -and $_.Status -eq "Up" }
If ($VPNConnected -eq "" -or $VPNConnected -eq $null){
Write-Log "No VPN Connection detected, continuing install."
}
Else
{
Write-Log "Warning. The following VPN connections were detected : $VPNConnected"
}

if ($OnCorporateLAN -and -not $VPNConnected) {
    Write-Host "✅ On corporate LAN and no VPN detected. Installing software..."
    Write-Log "On corporate LAN and no VPN detected. Installing software..."
    File-Copy
}
else {
    Write-Host "❌ Not on corporate LAN or VPN is active. Installation skipped."
    Write-Log "Warning. Not on corporate LAN or VPN is active. Installation skipped."
    $Global:NoLan = 1
}
}

Function File-Copy {
#Copy New version
$source = "\\gwynedd.rhwydwaith\Desgfwrdd\VPN\Cisco_5113177"
$dest   = "C:\TG\Cisco_5113177"

# Ensure destination root exists
New-Item -ItemType Directory -Path $dest -Force | Out-Null

# Copy everything, including empty directories
Copy-Item -Path $source\* -Destination $dest -Recurse -Container -Force

Write-Log "Install files for version 5.1.13.177 have been copied locally (New Install)."


# Needed to avoid upgrade/uninstall file missing Error
# Copy Current version install files 


#Ver 5.1.4.74
If ($Global:CurVer -eq "5.1.4.74"){
$source2 = "\\gwynedd.rhwydwaith\Desgfwrdd\VPN\Cisco_51474"
$dest2   = "C:\TG\Cisco_51474"

# Ensure destination root exists
New-Item -ItemType Directory -Path $dest2 -Force | Out-Null

# Copy everything, including empty directories
Copy-Item -Path $source2\* -Destination $dest2 -Recurse -Container -Force

Write-Log "Install files for version 5.1.4.74 have been copied locally (Current Install)."
}


#Ver 5.1.8.105
$source3 = "\\gwynedd.rhwydwaith\Desgfwrdd\VPN\Cisco_518105"
$dest3   = "C:\TG\Cisco_518105"

# Ensure destination root exists
New-Item -ItemType Directory -Path $dest3 -Force | Out-Null

# Copy everything, including empty directories
Copy-Item -Path $source3\* -Destination $dest3 -Recurse -Container -Force

Write-Log "Install files for version 5.1.8.105 have been copied locally (Current Install)."

$Global:Filecopy = "Done"
Write-Log "Pre-copy of all files locally completed. Starting Upgrade process....."
}


Function Upgrade-VPN {

################################
#####       UnInstall      #####
################################

## Reset Quick start registry key to prevent login screen loop.
$PathQS = "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$NameQS = "Userinit"
$TypeQS = "DWORD"
$ValueQS = 'C:\Windows\system32\userinit.exe'
Set-ItemProperty -Path $PathQS -Name $NameQS -Value $ValueQS
Write-Log "Quick Start Value : $NameQS = $ValueQS"



## uninstall Current Version
#Ver 5.1.4.74
If ($Global:CurVer -eq "5.1.4.74"){

# Variables
$msiPath1 = 'C:\TG\Cisco_51474\cisco-secure-client-win-dart-predeploy-k9.msi'
$msiPath2 = 'C:\TG\Cisco_51474\cisco-secure-client-win-iseposture-predeploy-k9.msi'
$msiPath3 = 'C:\TG\Cisco_51474\cisco-secure-client-win-nam-predeploy-k9.msi'
$msiPath4 = 'C:\TG\Cisco_51474\cisco-secure-client-win-core-vpn-predeploy-k9.msi'

# /qn = silent, /norestart = don’t force a reboot
$arguments1 = "/x `"$msiPath1`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51474_DART_uninstall.log`""
$arguments2 = "/x `"$msiPath2`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51474_ISE_uninstall.log`""
$arguments3 = "/x `"$msiPath3`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51474_NAM_uninstall.log`""
$arguments4 = "/x `"$msiPath4`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51474_CORE_uninstall.log`""

$process1 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments1 -Wait -PassThru
if ($process1.ExitCode -eq 0) {
    Write-Log "Uninstall succeeded (via MSI path). Log: C:\TG\Logs\Cisco_51474_DART_uninstall.log"
} else {
    Write-Log "Uninstall failed with exit code $($process1.ExitCode). See log: C:\TG\Logs\Cisco_51474_DART_uninstall.log"
}
$process2 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments2 -Wait -PassThru
if ($process2.ExitCode -eq 0) {
    Write-Log "Uninstall succeeded (via MSI path). Log: C:\TG\Logs\Cisco_51474_ISE_uninstall.log"
} else {
    Write-Log "Uninstall failed with exit code $($process2.ExitCode). See log: C:\TG\Logs\Cisco_51474_ISE_uninstall.log"
}
$process3 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments3 -Wait -PassThru
if ($process3.ExitCode -eq 0) {
    Write-Log "Uninstall succeeded (via MSI path). Log: C:\TG\Logs\Cisco_51474_NAM_uninstall.log"
} else {
    Write-Log "Uninstall failed with exit code $($process3.ExitCode). See log: C:\TG\Logs\Cisco_51474_NAM_uninstall.log"
}
$process4 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments4 -Wait -PassThru
if ($process4.ExitCode -eq 0) {
    Write-Log "Uninstall succeeded (via MSI path). Log: C:\TG\Logs\Cisco_51474_CORE_uninstall.log"
} else {
    Write-Log "Uninstall failed with exit code $($process4.ExitCode). See log: C:\TG\Logs\Cisco_51474_CORE_uninstall.log"
}
##
}


#Ver 5.1.8.105
If ($Global:CurVer -eq "5.1.8.105"){

# Variables
$msiPath2 = 'C:\TG\Cisco_518105\cisco-secure-client-win-5.1.8.105-iseposture-predeploy-k9.msi'
$msiPath3 = 'C:\TG\Cisco_518105\cisco-secure-client-win-5.1.8.105-nam-predeploy-k9.msi'
$msiPath4 = 'C:\TG\Cisco_518105\cisco-secure-client-win-5.1.8.105-core-vpn-predeploy-k9.msi'

# /qn = silent, /norestart = don’t force a reboot
$arguments2 = "/x `"$msiPath2`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_518105_ISE_uninstall.log`""
$arguments3 = "/x `"$msiPath3`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_518105_NAM_uninstall.log`""
$arguments4 = "/x `"$msiPath4`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_518105_CORE_uninstall.log`""


$process2 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments2 -Wait -PassThru
if ($process2.ExitCode -eq 0) {
    Write-Log "Uninstall succeeded (via MSI path). Log: C:\TG\Logs\Cisco_518105_ISE_uninstall.log"
} else {
    Write-Log "Uninstall failed with exit code $($process2.ExitCode). See log: C:\TG\Logs\Cisco_518105_ISE_uninstall.log"
}
$process3 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments3 -Wait -PassThru
if ($process3.ExitCode -eq 0) {
    Write-Log "Uninstall succeeded (via MSI path). Log: C:\TG\Logs\Cisco_518105_NAM_uninstall.log"
} else {
    Write-Log "Uninstall failed with exit code $($process3.ExitCode). See log: C:\TG\Logs\Cisco_518105_NAM_uninstall.log"
}
$process4 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments4 -Wait -PassThru
if ($process4.ExitCode -eq 0) {
    Write-Log "Uninstall succeeded (via MSI path). Log: C:\TG\Logs\Cisco_518105_CORE_uninstall.log"
} else {
    Write-Log "Uninstall failed with exit code $($process4.ExitCode). See log: C:\TG\Logs\Cisco_518105_CORE_uninstall.log"
}
##
}

If ($Global:CurVer -ne $Global:LatestVer)
{
# Remove old Folders with corrupt permissions
Remove-Item -Path "C:\Program Files (x86)\Cisco" -Recurse -Force
}



################################
#####        Install       #####
################################
#Ver 5.1.13.177

# Variables
$msiPath1 = 'C:\TG\Cisco_5113177\cisco-secure-client-win-5.1.13.177-core-vpn-predeploy-k9.msi'
$msiPath2 = 'C:\TG\Cisco_5113177\cisco-secure-client-win-5.1.13.177-dart-predeploy-k9.msi'
$msiPath3 = 'C:\TG\Cisco_5113177\cisco-secure-client-win-5.1.13.177-iseposture-predeploy-k9.msi'
$msiPath4 = 'C:\TG\Cisco_5113177\cisco-secure-client-win-5.1.13.177-nam-predeploy-k9.msi'



# /qn = silent, /norestart = don’t force a reboot
$arguments1 = "/i `"$msiPath1`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_5113177_CORE_install.log`""
$arguments2 = "/i `"$msiPath2`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_5113177_DART_install.log`""
$arguments3 = "/i `"$msiPath3`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_5113177_NAM_install.log`""
$arguments4 = "/i `"$msiPath4`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_5113177_ISE_install.log`""

$process1 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments1 -Wait -PassThru
if ($process1.ExitCode -eq 0) {
    Write-Log "Install succeeded (via MSI path). Log: C:\TG\Logs\Cisco_5113177_CORE_install.log"
} else {
    Write-Log "Install failed with exit code $($process1.ExitCode). See log: C:\TG\Logs\Cisco_5113177_CORE_install.log"
}
$process2 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments2 -Wait -PassThru
if ($process2.ExitCode -eq 0) {
    Write-Log "Install succeeded (via MSI path). Log: C:\TG\Logs\Cisco_5113177_DART_install.log"
} else {
    Write-Log "Install failed with exit code $($process2.ExitCode). See log: C:\TG\Logs\Cisco_5113177_DART_install.log"
}
$process3 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments3 -Wait -PassThru
if ($process3.ExitCode -eq 0) {
    Write-Log "Install succeeded (via MSI path). Log: C:\TG\Logs\Cisco_5113177_NAM_install.log"
} else {
    Write-Log "Install failed with exit code $($process3.ExitCode). See log: C:\TG\Logs\Cisco_5113177_NAM_install.log"
}
$process4 = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments4 -Wait -PassThru
if ($process4.ExitCode -eq 0) {
    Write-Log "Install succeeded (via MSI path). Log: C:\TG\Logs\Cisco_5113177_ISE_install.log"
} else {
    Write-Log "Install failed with exit code $($process4.ExitCode). See log: C:\TG\Logs\Cisco_5113177_ISE_install.log"
}

Write-Log "The installation process has finished processing the install files and will now check if the services have started"
$Global:InstProcess = "Finished"

}

Function Service-Check {
$Global:ServiceError = 0

#Check CORE Service
$service = Get-Service -Name "csc_vpnagent"

if ($service.Status -eq "Running") {
    Write-Log "The Cisco Core Service is Running"
}
else {
    Write-Log "The Cisco Core Service is NOT Running. Please check log files for errors"
    $Global:ServiceError = 1
}

#Check NAM Service
$service = Get-Service -Name "csc_nam"

if ($service.Status -eq "Running") {
    Write-Log "The Cisco NAM Service is Running"
}
else {
    Write-Log "The Cisco NAM Service is NOT Running. Please check log files for errors"
    $Global:ServiceError = 1
}

#Check ISE Service
$service = Get-Service -Name "csc_iseagent"

if ($service.Status -eq "Running") {
    Write-Log "The Cisco ISE Posture Service is Running"
}
else {
    Write-Log "The Cisco ISE Posture Service is NOT Running. Please check log files for errors"
    $Global:ServiceError = 1
}




}






#####################################################################################################################################
#####                                                                                                                           #####
#####                                           Main Script                                                                     #####
#####                                                                                                                           #####
##################################################################################################################################### 




# Check which version is installed
$CVer = (Get-Item "C:\Program Files (x86)\Cisco\Cisco Secure Client\vpnagent.exe").VersionInfo.ProductVersion
$Global:CurVer = $CVer.Replace(" ", "").Replace(",", ".")

If ($Global:CurVer -eq $Global:LatestVer){
Write-Log "The latest version is already installed.   No further action required.    Exiting install....."
}
Else
{
Write-Log "The currently installed version requires an update. Proceeding to check other prereq's before continuing. "
LAN-Connected

If($Global:Filecopy -eq "Done") {
Upgrade-VPN
}

If($Global:InstProcess -eq "Finished")
{Service-Check}

If ($Global:ServiceError -gt 0){
Write-Log "Warning....  The current Install did NOT complete successfully. Please examine the local install logs in C:\TG\Logs for more information on the failure."
}

}

#Write Logs to Central Location. 
Write-Log "Writing logs to Central Location - \\ME-DTCENTRAL\Cisco_Install_Logs"

$LogName = "$env:COMPUTERNAME.log"
$source9 = "C:\TG\Logs\Cisco_Install.log"
$Dest9 = "\\me-dtcentral\Cisco_Install_Logs$\$LogName"
Copy-Item -Path $source9 -Destination $Dest9 -Force

Stop-Transcript

If ($Global:NoLan -eq 1){
Write-Host "Not on corporate LAN or VPN is active. Installation skipped."
Exit 48
}
Else
{
}

