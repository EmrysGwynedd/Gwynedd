$ComputerName = "YGC-RENDRO"

Invoke-Command -ComputerName $ComputerName -ScriptBlock {
    Get-CimInstance Win32_BIOS |
    Select-Object PSComputerName, SMBIOSBIOSVersion, ReleaseDate
}