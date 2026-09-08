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

# Retry-enabled MSI execution helper
Function Invoke-MSIInstallWithRetry {
    param (
        [Parameter(Mandatory=$true)]
        [string]$MsiPath,

        [Parameter(Mandatory=$true)]
        [string]$LogPath,

        [Parameter(Mandatory=$true)]
        [string]$ProcessLabel,

        [int]$MaxRetries = 3
    )

    if (-not (Test-Path -Path $MsiPath)) {
        Write-Host "❌ Error: MSI file not found at $MsiPath" -ForegroundColor Red
        $Global:InstProcess = "Failed_$ProcessLabel"
        return $false
    }

    $arguments = "/i `"$MsiPath`" /qn /norestart /L*v `"$LogPath`""
    $attempt = 1
    $installed = $false

    while ($attempt -le $MaxRetries -and -not $installed) {
        Write-Host "Attempt $attempt of ${$MaxRetries}: Installing $ProcessLabel..."
        $process = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments -Wait -PassThru

        # Standard MSI success exit codes: 0 = Success, 3010/1641 = Success (Reboot Required)
        if ($process.ExitCode -eq 0 -or $process.ExitCode -eq 3010 -or $process.ExitCode -eq 1641) {
            Write-Host "✅ $ProcessLabel installed successfully (Exit Code: $($process.ExitCode))." -ForegroundColor Green
            $Global:InstProcess = "Finished_$ProcessLabel"
            $installed = $true
        }
        else {
            Write-Host "⚠️ Attempt $attempt failed for $ProcessLabel with exit code $($process.ExitCode)." -ForegroundColor Yellow
            if ($attempt -lt $MaxRetries) {
                Write-Host "Retrying in 5 seconds..." -ForegroundColor Yellow
                Start-Sleep -Seconds 5
            }
            $attempt++
        }
    }

    if (-not $installed) {
        Write-Host "❌ Error: $ProcessLabel installation failed after $MaxRetries attempts. Check $LogPath for details." -ForegroundColor Red
        $Global:InstProcess = "Failed_$ProcessLabel"
    }

    return $installed
}

Function Update-VPN {
## Reset Quick start registry key to prevent login screen loop.
$PathQS = "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$NameQS = "Userinit"
$ValueQS = 'C:\Windows\system32\userinit.exe'
Set-ItemProperty -Path $PathQS -Name $NameQS -Value $ValueQS

$msiPath1 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-core-vpn-predeploy-k9.msi'
$logPath1 = 'C:\TG\Logs\Cisco_51191862_CORE_install.log'
return Invoke-MSIInstallWithRetry -MsiPath $msiPath1 -LogPath $logPath1 -ProcessLabel "VPN" -MaxRetries 3
}
Function Update-NAM {
$msiPath2 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-nam-predeploy-k9.msi'
$logPath2 = 'C:\TG\Logs\Cisco_51191862_NAM_install.log'
return Invoke-MSIInstallWithRetry -MsiPath $msiPath2 -LogPath $logPath2 -ProcessLabel "NAM" -MaxRetries 3
}
Function Update-ISE {
$msiPath3 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-iseposture-predeploy-k9.msi'
$logPath3 = 'C:\TG\Logs\Cisco_51191862_ISE_install.log'
return Invoke-MSIInstallWithRetry -MsiPath $msiPath3 -LogPath $logPath3 -ProcessLabel "ISE" -MaxRetries 3
}
Function Update-Start {
& "C:\TG\Cisco_51191862\ServiceUI.exe" -process:explorer.exe "C:\Program Files (x86)\Cisco\Cisco Secure Client\UI\csc_ui.exe" 
$Global:InstProcess = "Finished_Start"
}


Function Test-Service {
$Global:ServiceError = 0

#Check CORE Service
$service = Get-Service -Name "csc_vpnagent" -ErrorAction SilentlyContinue

if ($service -and $service.Status -eq "Running") {
    Write-Host "The Cisco Core Service is Running"
    $MsgText = "Mae eich VPN wedi ei uwchraddio. Your VPN has been updated."
    msg.exe * /TIME:0 $MsgText
}
else {
    Write-Host "The Cisco Core Service is NOT Running. Please check log files for errors"
    $Global:ServiceError = 1
}

#Check NAM Service
$service = Get-Service -Name "csc_nam" -ErrorAction SilentlyContinue

if ($service -and $service.Status -eq "Running") {
    Write-Host "The Cisco NAM Service is Running"
}
else {
    Write-Host "The Cisco NAM Service is NOT Running. Please check log files for errors"
    $Global:ServiceError = 1
}

#Check ISE Service
$service = Get-Service -Name "csc_iseagent" -ErrorAction SilentlyContinue

if ($service -and $service.Status -eq "Running") {
    Write-Host "The Cisco ISE Posture Service is Running"
}
else {
    Write-Host "The Cisco ISE Posture Service is NOT Running. Please check log files for errors"
    $Global:ServiceError = 1
}
}

## Main Script
# Check which version is installed
$CVer = (Get-Item "C:\Program Files (x86)\Cisco\Cisco Secure Client\vpnagent.exe" -ErrorAction SilentlyContinue).VersionInfo.ProductVersion
if ($CVer) {
    $Global:CurVer = $CVer.Replace(" ", "").Replace(",", ".")
} else {
    $Global:CurVer = "0.0.0.0"
}

If ($Global:CurVer -eq $Global:LatestVer){
Write-Host "The latest version is already installed.   No further action required.    Exiting install....."
}
Else
{
Write-Host "The currently installed version requires an update. Proceeding to check other prereq's before continuing. "
Test-LANConnection

If($Global:Filecopy -eq "Skipped" -or $Global:Filecopy -eq "Done") {
    # Each function will retry up to 3 times before returning $false
    $vpnSuccess = Update-VPN
    $namSuccess = Update-NAM
    $iseSuccess = Update-ISE

    # Verify that all 3 installations succeeded before launching the UI
    if ($vpnSuccess -and $namSuccess -and $iseSuccess) {
        Write-Host "✅ All 3 Cisco packages installed successfully." -ForegroundColor Green
        Update-Start
    } else {
        Write-Host "❌ One or more installations failed after retries. Aborting UI start." -ForegroundColor Red
    }
}

If($Global:InstProcess -eq "Finished_Start")
{Test-Service}

If ($Global:ServiceError -gt 0 -or $Global:InstProcess -ne "Finished_Start"){
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