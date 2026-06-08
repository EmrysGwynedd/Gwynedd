# Script to Detect if Konica Gwynedd print queue is installed

$Path = "Registry::HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PrinterPorts"
$Name = "\\Papercut-1\Konica_Gwynedd"
$Value = 1

Try {
    If (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue) {
    Exit 0
    } 
    Exit 1
} 
Catch {
    Exit 1
}

