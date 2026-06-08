$CsvPath    = "C:\TG\PS\BIOS_CHECK\BIOS_CHECK.csv"
$OutputPath = "C:\TG\PS\BIOS_CHECK\BIOS_SecureBoot_Compliance_Report.csv"

$Devices = Import-Csv $CsvPath

$Results = foreach ($Device in $Devices) {

    $ComputerName = $Device.DeviceName.Trim()
    $MinBios      = $Device.'Minimum Secure Boot BIOS'.Trim()

    try {
        # --- DNS check
        if (-not (Resolve-DnsName $ComputerName -ErrorAction SilentlyContinue)) {
            throw "DNS resolution failed"
        }

        # --- CIM session with short timeout (works in PS 5.1)
        $SessionOpts = New-CimSessionOption -Protocol Dcom
        $CimSession  = New-CimSession `
            -ComputerName $ComputerName `
            -SessionOption $SessionOpts `
            -OperationTimeoutSec 5 `
            -ErrorAction Stop

        $Bios = Get-CimInstance `
            -ClassName Win32_BIOS `
            -CimSession $CimSession `
            -ErrorAction Stop

        Remove-CimSession $CimSession

        # --- Normalise versions
        $CurrentBios = ($Bios.SMBIOSBIOSVersion -replace '\s+', '')
        $MinBiosNorm = ($MinBios -replace '\s+', '')

        [PSCustomObject]@{
            DeviceName            = $ComputerName
            MinimumSecureBootBIOS = $MinBios
            CurrentSMBIOSVersion  = $Bios.SMBIOSBIOSVersion
            ReleaseDate           = $Bios.ReleaseDate
            Compliant             = if ($CurrentBios -ge $MinBiosNorm) { "Yes" } else { "No" }
            Status                = "OK"
        }
    }
    catch {
        $Reason =
            if ($_.Exception.Message -like "*DNS*") {
                "DNS resolution failed"
            }
            elseif ($_.Exception.Message -like "*timeout*") {
                "DCOM/WMI timeout"
            }
            else {
                $_.Exception.Message
            }

        [PSCustomObject]@{
            DeviceName            = $ComputerName
            MinimumSecureBootBIOS = $MinBios
            CurrentSMBIOSVersion  = ""
            ReleaseDate           = ""
            Compliant             = "Unknown"
            Status                = $Reason
        }
    }
}

$Results | Export-Csv $OutputPath -NoTypeInformation -Encoding UTF8
$Results | Sort-Object Status, DeviceName | Format-Table -AutoSize
