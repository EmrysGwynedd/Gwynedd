# Function i weld data Logoff, Lock, Unlock, Power on/off, Restart, a statws VPN
# Emrys Wyn Evans Ver 1.3.1

function Get-Gwynedd {

    param(
        [string]$ComputerName = $env:COMPUTERNAME
    )

    $results = @()

    $eventList = @(
        @{ Name = 'Logon';     Log = 'Security'; Id = 4624 }
        @{ Name = 'Logoff';    Log = 'Security'; Id = 4634 }
        @{ Name = 'Lock';      Log = 'Security'; Id = 4800 }
        @{ Name = 'Unlock';    Log = 'Security'; Id = 4801 }
        @{ Name = 'Power On';  Log = 'System';   Id = 6005 }
        @{ Name = 'Power Off'; Log = 'System';   Id = 6006 }
        @{ Name = 'Restart';   Log = 'System';   Id = 1074 }
    )

    foreach ($item in $eventList) {

        $evt = Get-WinEvent -ComputerName $ComputerName -FilterHashtable @{
            LogName = $item.Log
            Id      = $item.Id
        } -MaxEvents 1 -ErrorAction SilentlyContinue

        $results += [PSCustomObject]@{
            Event = $item.Name
            Time  = if ($evt) { $evt.TimeCreated } else { 'Not Found' }
        }
    }

    # Get IP address from DNS
    try {
        $IPAddress = [System.Net.Dns]::GetHostAddresses($ComputerName) |
            Where-Object { $_.AddressFamily -eq 'InterNetwork' } |
            Select-Object -First 1 -ExpandProperty IPAddressToString
    }
    catch {
        $IPAddress = $null
    }

    $VPNStatus = if ($IPAddress -like '172.25.*') {
        "Mae'r ddyfais yma ar VPN - $IPAddress"
    }
    elseif ($IPAddress) {
        "Nid yw'r ddyfais yma ar VPN - $IPAddress"
    }
    else {
        "Methwyd canfod cyfeiriad IP"
    }

    $results += [PSCustomObject]@{
        Event = 'VPN Status'
        Time  = $VPNStatus
    }

    $results | Format-Table -AutoSize
}