function Get-GwyneddWorkstation {
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

    $evt = Get-WinEvent -FilterHashtable @{
        LogName = $item.Log
        Id      = $item.Id
    } -MaxEvents 1 -ErrorAction SilentlyContinue

    $results += [PSCustomObject]@{
        Event = $item.Name
        Time  = if ($evt) { $evt.TimeCreated } else { 'Not Found' }
    }
}

$results | Format-Table -AutoSize

$vpnAddress = Get-NetIPAddress -AddressFamily IPv4 |
    Where-Object { $_.IPAddress -like '172.25.*' } |
    Select-Object -First 1

if ($vpnAddress) {
    Write-Host 'Ar cysylltiad VPN ' $vpnAddress.IPAddress -ForegroundColor Green
    Write-Host $vpnAddress.IPAddress -ForegroundColor Green
    Write-Host ''
}
else {
    $ipAddress = Get-NetIPAddress -AddressFamily IPv4 |
        Where-Object { $_.IPAddress -notlike '169.254.*' } |
        Select-Object -First 1 -ExpandProperty IPAddress

    Write-Host 'Nid ar VPN ' $ipAddress -ForegroundColor Green
    Write-Host ''
}
}