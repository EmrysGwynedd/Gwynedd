# Import laptop list
$laptops = Import-Csv "C:\TG\PS\Ping_diog\Ping.csv"

# Optional: store results in memory
$PingResults = @()

foreach ($laptop in $laptops) {
    $name = $laptop.LaptopName

    $isOnline = Test-Connection -ComputerName $name -Count 1 -Quiet -ErrorAction SilentlyContinue

    if ($isOnline) {
        $ip = (Resolve-DnsName $name -ErrorAction SilentlyContinue |
              Where-Object { $_.Type -eq 'A' } |
              Select-Object -First 1 -ExpandProperty IPAddress)

        # GREEN background
        Write-Host (" {0,-20} ONLINE  {1} " -f $name, $ip) `
            -BackgroundColor Green `
            -ForegroundColor Black

        $PingResults += [PSCustomObject]@{
            LaptopName = $name
            Status     = 'Online'
            IPAddress  = $ip
            Timestamp  = Get-Date
        }
    }
    else {
        # RED background
        Write-Host (" {0,-20} OFFLINE " -f $name) `
            -BackgroundColor Red `
            -ForegroundColor White

        $PingResults += [PSCustomObject]@{
            LaptopName = $name
            Status     = 'Offline'
            IPAddress  = $null
            Timestamp  = Get-Date
        }
    }
}
