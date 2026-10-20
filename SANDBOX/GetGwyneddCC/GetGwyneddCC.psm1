# Function i rhedeg wrth i Office rhedeg i weld lle mae'n cael ei lawrlwytho o, 
# a faint o ddata sydd wedi cael ei lawrlwytho o'r gwahanol ffynonellau. Connectd Cache Vs Microsoft CDN.
# Get-GwyneddCC - Watch
# Real Time ac hefyd creu csv <device_name>_CC.csv efo'r data bob 5 eiliad.
# Parhau i casglu data tan mae'r powershell shell wedi cau!

function Get-GwyneddCC {
    [CmdletBinding()]
    param(
        [int]$RefreshSeconds = 5,
        [switch]$Watch,
        [string]$LogFolder = 'C:\TG'
    )

    $scriptBlock = {

        $status = Get-DeliveryOptimizationStatus -ErrorAction SilentlyContinue

        $cacheHost = $null
        try {
            $cacheHost = (
                Get-ItemProperty `
                    'HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\DeliveryOptimization' `
                    -ErrorAction Stop
            ).DOCacheHost
        }
        catch {}

        if ($status) {
            $cacheBytes = ($status | Measure-Object BytesFromCacheServer -Sum).Sum
            $httpBytes  = ($status | Measure-Object BytesFromHttp -Sum).Sum
            $fileCount  = @($status).Count
        }
        else {
            $cacheBytes = 0
            $httpBytes  = 0
            $fileCount  = 0
        }

        [PSCustomObject]@{
            Timestamp           = Get-Date
            ComputerName        = $env:COMPUTERNAME
            CacheHost           = $cacheHost
            ActiveDownloads     = $fileCount
            CacheServerMB       = [math]::Round($cacheBytes / 1MB, 2)
            HttpMB              = [math]::Round($httpBytes / 1MB, 2)
            UsingConnectedCache = ($cacheBytes -gt 0)
            UsingMicrosoftCDN   = ($httpBytes -gt 0)
        }
    }

    if ($Watch) {

        if (-not (Test-Path $LogFolder)) {
            New-Item -Path $LogFolder -ItemType Directory -Force | Out-Null
        }

        $CsvPath = Join-Path $LogFolder "$($env:COMPUTERNAME)_CC.csv"

        while ($true) {

            $Result = & $scriptBlock

            Clear-Host

            $Result | Format-Table `
                Timestamp,
                ComputerName,
                CacheHost,
                ActiveDownloads,
                CacheServerMB,
                HttpMB,
                UsingConnectedCache,
                UsingMicrosoftCDN -AutoSize

            if (-not (Test-Path $CsvPath)) {
                $Result | Export-Csv $CsvPath -NoTypeInformation
            }
            else {
                $Result | Export-Csv $CsvPath -NoTypeInformation -Append
            }

            Write-Host ""
            Write-Host "Logging to: $CsvPath" -ForegroundColor Green

            Start-Sleep -Seconds $RefreshSeconds
        }
    }
    else {
        & $scriptBlock
    }
}