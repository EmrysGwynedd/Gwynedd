# Install Cisco Secure Client only if on Corporate Network
# Start Transcript Logs
$log = "C:\TG\Logs\Cisco-Transcripts.log"

# Ensure directory exists before starting transcript
if (-not (Test-Path "C:\TG\Logs")) { New-Item -ItemType Directory -Path "C:\TG\Logs" -Force | Out-Null }
Start-Transcript -Path $log -Append

# Set Variables
$Global:NoLan = 0
$Global:LatestVer = "5.1.19.1862"
$Global:FlagFile  = "C:\ProgramData\vpn_done.flag"

####################################################################################
# Helper Functions for Interactive User UI (Session 0 -> Session 1 Bridge)
####################################################################################

Function Show-UserPopup {
    param(
        [string]$Message = "VPN UPDATE IN PROGRESS",
        [string]$Title = "Cisco Secure Client Update"
    )

    $ServiceUI = "C:\TG\Cisco_51191862\ServiceUI.exe"

    if (-not (Test-Path $ServiceUI)) {
        Write-Host "⚠️ ServiceUI.exe not found at $ServiceUI. Cannot display UI popup."
        return
    }

    # Ensure stale flag file is removed
    if (Test-Path $Global:FlagFile) { Remove-Item $Global:FlagFile -Force }

    Unblock-File -Path $ServiceUI -ErrorAction SilentlyContinue

    # Define clean WPF Popup Code
    $PopupCode = @"
Add-Type -AssemblyName PresentationFramework

[xml]`$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="$Title" Height="140" Width="420" 
        WindowStyle="None" WindowStartupLocation="CenterScreen" 
        Topmost="True" Background="#1E1E1E" ResizeMode="NoResize">
    <Border BorderBrush="#0078D4" BorderThickness="3" CornerRadius="8">
        <Grid HorizontalAlignment="Center" VerticalAlignment="Center">
            <StackPanel>
                <TextBlock Text="$Message" 
                           Foreground="White" FontSize="15" FontWeight="Bold" 
                           TextWrapping="Wrap" TextAlignment="Center" Margin="10,0,10,8"/>
                <TextBlock Text="Please do not disconnect or restart your computer..." 
                           Foreground="#A0A0A0" FontSize="11" 
                           HorizontalAlignment="Center"/>
            </StackPanel>
        </Grid>
    </Border>
</Window>
"@

`$reader = (New-Object System.Xml.XmlNodeReader `$xaml)
`$window = [Windows.Markup.XamlReader]::Load(`$reader)

`$timer = New-Object System.Windows.Threading.DispatcherTimer
`$timer.Interval = [TimeSpan]::FromMilliseconds(500)
`$timer.Add_Tick({
    if (Test-Path '$($Global:FlagFile)') {
        `$timer.Stop()
        `$window.Close()
    }
})

`$timer.Start()
`$window.ShowDialog() | Out-Null
"@

    # Convert script to Base64 to safely bridge execution via ServiceUI
    $Bytes = [System.Text.Encoding]::Unicode.GetBytes($PopupCode)
    $EncodedCommand = [Convert]::ToBase64String($Bytes)

    if (Get-Process -Name "explorer" -ErrorAction SilentlyContinue) {
        Write-Host "Displaying active update banner to logged-on user..."
        $Arguments = "-process:explorer.exe C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -EncodedCommand $EncodedCommand"
        
        # Start without -Wait so main update script continues in parallel
        Start-Process -FilePath $ServiceUI -ArgumentList $Arguments -WindowStyle Hidden
    } else {
        Write-Host "No active explorer process found. Skipping popup display."
    }
}

Function Hide-UserPopup {
    Write-Host "Closing user-facing popup notice..."
    New-Item -Path $Global:FlagFile -ItemType File -Force | Out-Null
    Start-Sleep -Seconds 1
    if (Test-Path $Global:FlagFile) { Remove-Item $Global:FlagFile -Force }
}

Function Start-AppAsUser {
    param(
        [string]$ExePath
    )

    $ServiceUI = "C:\TG\Cisco_51191862\ServiceUI.exe"

    if (-not (Test-Path $ServiceUI)) {
        Write-Host "⚠️ ServiceUI.exe not found at $ServiceUI. Cannot launch $ExePath in user session."
        return
    }

    if (-not (Test-Path $ExePath)) {
        Write-Host "⚠️ Application path not found: $ExePath"
        return
    }

    Write-Host "Launching $ExePath in active user session..."
    
    # Launch executable in user session
    Start-Process -FilePath $ServiceUI -ArgumentList "-process:explorer.exe `"$ExePath`""
}

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
    # Copy New version
    $source = "\\gwynedd.rhwydwaith\Desgfwrdd\VPN\Cisco_51191862"
    $dest   = "C:\TG\Cisco_51191862"

    # Ensure destination root exists
    New-Item -ItemType Directory -Path $dest -Force | Out-Null

    # Copy everything, including empty directories
    Copy-Item -Path $source\* -Destination $dest -Recurse -Container -Force

    $Global:Filecopy = "Done"
}

Function Update-VPN {

    ## Reset Quick start registry key to prevent login screen loop.
    $PathQS = "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
    $NameQS = "Userinit"
    $ValueQS = 'C:\Windows\system32\userinit.exe'
    Set-ItemProperty -Path $PathQS -Name $NameQS -Value $ValueQS

    # Install
    # Ver 5.1.19.1862

    # Variables
    $msiPath1 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-core-vpn-predeploy-k9.msi'
    $msiPath2 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-dart-predeploy-k9.msi'
    $msiPath3 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-iseposture-predeploy-k9.msi'
    $msiPath4 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-5.1.19.1862-nam-predeploy-k9.msi'
    $msiPath5 = 'C:\TG\Cisco_51191862\cisco-secure-client-win-2.43.2-thousandeyes-predeploy-k9.msi'
    $Token = 'S3FD77CY+VOrk+4fbbgjBbWTlssQaBe4IBdgd50I+Ry4o6cP5KFcF9m+fwOIVIm9anZUTGeNp7gbOJJwObOa4VQnSPL7rFzOxk6XY/B03ZM='

    # /qn = silent, /norestart = don’t force a reboot
    $arguments1 = "/i `"$msiPath1`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51191862_CORE_install.log`""
    $arguments2 = "/i `"$msiPath2`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51191862_DART_install.log`""
    $arguments3 = "/i `"$msiPath3`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51191862_NAM_install.log`""
    $arguments4 = "/i `"$msiPath4`" /qn /norestart /L*v `"C:\TG\Logs\Cisco_51191862_ISE_install.log`""
    $arguments5 = "/i `"$msiPath5`" /qn /norestart ACCOUNT_CONFIG=`"$Token`" /L*v `"C:\TG\Logs\Cisco_51191862_TE_install.log`""

    Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments1 -Wait -PassThru
    Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments2 -Wait -PassThru
    Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments3 -Wait -PassThru
    Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments4 -Wait -PassThru
    Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments5 -Wait -PassThru

    $Global:InstProcess = "Finished"
}

Function Test-Service {
    $Global:ServiceError = 0

    # Check CORE Service
    $service = Get-Service -Name "csc_vpnagent" -ErrorAction SilentlyContinue

    if ($service.Status -eq "Running") {
        Write-Host "The Cisco Core Service is Running"
    }
    else {
        Write-Host "The Cisco Core Service is NOT Running. Please check log files for errors"
        $Global:ServiceError = 1
    }

    # Check NAM Service
    $service = Get-Service -Name "csc_nam" -ErrorAction SilentlyContinue

    if ($service.Status -eq "Running") {
        Write-Host "The Cisco NAM Service is Running"
    }
    else {
        Write-Host "The Cisco NAM Service is NOT Running. Please check log files for errors"
        $Global:ServiceError = 1
    }

    # Check ISE Service
    $service = Get-Service -Name "csc_iseagent" -ErrorAction SilentlyContinue

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
$CVer = (Get-Item "C:\Program Files (x86)\Cisco\Cisco Secure Client\vpnagent.exe" -ErrorAction SilentlyContinue).VersionInfo.ProductVersion
if ($CVer) {
    $Global:CurVer = $CVer.Replace(" ", "").Replace(",", ".")
}

If ($Global:CurVer -eq $Global:LatestVer){
    Write-Host "The latest version is already installed. No further action required. Exiting install....."
}
Else
{
    Write-Host "The currently installed version requires an update. Proceeding to check other prereq's before continuing. "
    Test-LANConnection

    If($Global:Filecopy -eq "Done") {
        try {
            # 1. Open Popup in user's session
            Show-UserPopup -Message "VPN UPDATE IN PROGRESS" -Title "Cisco Secure Client Update"

            # 2. Run Update
            Update-VPN
        }
        finally {
            # 3. Dismiss Popup when update completes (even if installer errors)
            Hide-UserPopup
        }
    }

    If($Global:InstProcess -eq "Finished") {
        Test-Service
    }

    If ($Global:ServiceError -gt 0){
        Write-Host "Warning.... The current Install did NOT complete successfully. Please examine the local install logs in C:\TG\Logs for more information on the failure."
    }
    else {
        # LAUNCH APP: Opens Cisco UI directly in user's active session
        $CiscoUI = "C:\Program Files (x86)\Cisco\Cisco Secure Client\UI\csc_ui.exe"
        Start-AppAsUser -ExePath $CiscoUI
    }
}

If ($Global:NoLan -eq 1){
    Write-Host "Not on corporate LAN or VPN is active. Installation skipped."
    Stop-Transcript
    Exit 48
}

Stop-Transcript