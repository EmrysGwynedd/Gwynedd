# Install Cisco Secure Client only if on Corporate Network
# Start Transcript Logs
$log = "C:\TG\Logs\Cisco-Transcripts.log"

Start-Transcript -Path $log -Append

#Set Variables
# Set the latest version number
$Global:NoLan = 0
$Global:LatestVer = "5.1.19.1862"

####################################################################################


Function Test-LANConnection {
# Define your corporate network domain or subnet
$CorporateSubnet = "172.16."   # Change to match your LAN subnet

# Get current IPv4 addresses (excluding loopback)
$IPAddresses = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike "127.*" }).IPAddress

# Check if connected to corporate LAN
$OnCorporateLAN = $IPAddresses -match "^$CorporateSubnet"

# Detect VPN connection by looking for common VPN interfaces
$VPNConnected = Get-NetAdapter | Where-Object { $_.InterfaceDescription -match "VPN|Cisco|Fortinet|Pulse" -and $_.Status -eq "Up" }
If ($null -eq $VPNConnected -or $VPNConnected -eq ""){
}
Else
{
Write-Host "Warning. The following VPN connections were detected : $VPNConnected"
}

if ($OnCorporateLAN -and -not $VPNConnected) {
    Write-Host "✅ On corporate LAN and no VPN detected. Installing software..."
    Copy-InstallFiles
}
else {
    Write-Host "❌ Not on corporate LAN or VPN is active. Installation skipped."
    $Global:NoLan = 1
}
}

Function Copy-InstallFiles {
    $source = "\\gwynedd.rhwydwaith\Desgfwrdd\VPN\Cisco_51191862"
    $dest   = "C:\TG\Cisco_51191862"

    # Gwirio os mae'r ffolder yna
    if (Test-Path -Path $dest) {
        Write-Host "Folder already exists at $dest. Skipping copy."
        $Global:Filecopy = "Skipped"
        return
    }

    # Copi y ffeils drosodd
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
    Copy-Item -Path $source\* -Destination $dest -Recurse -Container -Force

    $Global:Filecopy = "Done"
}

Function Update-VPN {

## Reset Quick start registry key to prevent login screen loop.
$PathQS = "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$NameQS = "Userinit"
$ValueQS = 'C:\Windows\system32\userinit.exe'
Set-ItemProperty -Path $PathQS -Name $NameQS -Value $ValueQS

#Install
#Ver 5.1.19.1862

# Variables
$msiPath1 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-core-vpn-predeploy-k9.msi'
$msiPath3 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-iseposture-predeploy-k9.msi'
$msiPath4 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-nam-predeploy-k9.msi'

# /qn = silent, /norestart = don’t force a reboot
$arguments1 = "/i `"$msiPath1`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51191862_CORE_install.log`""

$arguments3 = "/i `"$msiPath3`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51191862_NAM_install.log`""
$arguments4 = "/i `"$msiPath4`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51191862_ISE_install.log`""
Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments1 -Wait -PassThru
Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments2 -Wait -PassThru
Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments3 -Wait -PassThru
Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments4 -Wait -PassThru
& "C:\TG\Cisco_51191862\ServiceUI.exe" -process:explorer.exe "C:\Program Files (x86)\Cisco\Cisco Secure Client\UI\csc_ui.exe" 
$Global:InstProcess = "Finished"
}


Function Test-Service {
$Global:ServiceError = 0

#Check CORE Service
$service = Get-Service -Name "csc_vpnagent"

if ($service.Status -eq "Running") {
    Write-Host "The Cisco Core Service is Running"
    $MsgText = "Mae eich VPN wedi ei uwchraddio. Your VPN has been updated."
    msg.exe * /TIME:0 $MsgText
}
else {
    Write-Host "The Cisco Core Service is NOT Running. Please check log files for errors"
    $Global:ServiceError = 1
}

#Check NAM Service
$service = Get-Service -Name "csc_nam"

if ($service.Status -eq "Running") {
    Write-Host "The Cisco NAM Service is Running"
}
else {
    Write-Host "The Cisco NAM Service is NOT Running. Please check log files for errors"
    $Global:ServiceError = 1
}

#Check ISE Service
$service = Get-Service -Name "csc_iseagent"

if ($service.Status -eq "Running") {
    Write-Host "The Cisco ISE Posture Service is Running"
}
else {
    Write-Host "The Cisco ISE Posture Service is NOT Running. Please check log files for errors"
    $Global:ServiceError = 1
}
}

## Main Script

# Check which version is installed
$CVer = (Get-Item "C:\Program Files (x86)\Cisco\Cisco Secure Client\vpnagent.exe").VersionInfo.ProductVersion
$Global:CurVer = $CVer.Replace(" ", "").Replace(",", ".")

If ($Global:CurVer -eq $Global:LatestVer){
Write-Host "The latest version is already installed.   No further action required.    Exiting install....."
}
Else
{
Write-Host "The currently installed version requires an update. Proceeding to check other prereq's before continuing. "
Test-LANConnection

If($Global:Filecopy -eq "Skipped") {
Update-VPN
}

If($Global:Filecopy -eq "Done") {
Update-VPN
}

If($Global:InstProcess -eq "Finished")
{Test-Service}

If ($Global:ServiceError -gt 0){
Write-Host "Warning....  The current Install did NOT complete successfully. Please examine the local install logs in C:\TG\Logs for more information on the failure."
}

}

If ($Global:NoLan -eq 1){
Write-Host "Not on corporate LAN or VPN is active. Installation skipped."
Exit 48
}
Else
{
}