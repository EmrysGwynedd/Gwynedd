function Get-Gwynedd {

    param(
        [string]$ComputerName = $env:COMPUTERNAME,

        [int]$Days = 0,

        [switch]$Csv
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

    $StartTime = if ($Days -gt 0) {
        (Get-Date).AddDays(-$Days)
    }

    foreach ($item in $eventList) {

        $Filter = @{
            LogName = $item.Log
            Id      = $item.Id
        }

        if ($StartTime) {
            $Filter.StartTime = $StartTime
        }

        $events = Get-WinEvent -ComputerName $ComputerName `
            -FilterHashtable $Filter `
            -ErrorAction SilentlyContinue

        if ($events) {
            foreach ($evt in $events) {
                $results += [PSCustomObject]@{
                    Event = $item.Name
                    Time  = $evt.TimeCreated
                }
            }
        }
        else {
            $results += [PSCustomObject]@{
                Event = $item.Name
                Time  = 'Not Found'
            }
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

    if ($Csv) {

        if (!(Test-Path "C:\TG")) {
            New-Item -Path "C:\TG" -ItemType Directory -Force | Out-Null
        }

        $CsvPath = "C:\TG\$ComputerName.csv"

        $results |
            Where-Object { $_.Event -ne 'VPN Status' } |
            Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8

        Write-Host "CSV wedi ei greu: $CsvPath" -ForegroundColor Green
    }
    else {
        $results | Format-Table -AutoSize
    }
}