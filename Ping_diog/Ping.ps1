# Import laptop list
$laptops = Import-Csv "C:\TG\Powershell\Gwynedd\Ping_diog\Ping.csv"

$PingResults = @()

foreach ($laptop in $laptops) {
    $name = $laptop.LaptopName

    $isOnline = Test-Connection -ComputerName $name -Count 1 -Quiet -ErrorAction SilentlyContinue

    if ($isOnline) {

        $ip = (Resolve-DnsName $name -ErrorAction SilentlyContinue |
              Where-Object { $_.Type -eq 'A' } |
              Select-Object -First 1 -ExpandProperty IPAddress)

        # Secure Boot check (runs locally on target)
        $SecureBootStatus = Invoke-Command -ComputerName $name -ScriptBlock {
            try {
                if (Confirm-SecureBootUEFI) {
                    "Enabled"
                } else {
                    "Disabled"
                }
            } catch {
                "Not Supported / Legacy BIOS"
            }
        } -ErrorAction SilentlyContinue

        # GREEN background
        Write-Host (" {0,-20} ONLINE  {1}  SecureBoot: {2} " -f $name, $ip, $SecureBootStatus) `
            -BackgroundColor Green `
            -ForegroundColor Black

        $PingResults += [PSCustomObject]@{
            LaptopName  = $name
            Status      = 'Online'
            IPAddress   = $ip
            SecureBoot  = $SecureBootStatus
            Timestamp   = Get-Date
        }
    }
    else {
        # RED background
        Write-Host (" {0,-20} OFFLINE " -f $name) `
            -BackgroundColor Red `
            -ForegroundColor White

        $PingResults += [PSCustomObject]@{
            LaptopName  = $name
            Status      = 'Offline'
            IPAddress   = $null
            SecureBoot  = 'Unknown'
            Timestamp   = Get-Date
        }
    }
}