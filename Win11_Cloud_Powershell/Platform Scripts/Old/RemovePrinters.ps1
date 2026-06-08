# Get all local printers where the port is null
$printers = Get-Printer | Where-Object { $_.Type -eq 'Local' -and $_.PortName -like 'nul*' }

# Remove each printer found
foreach ($printer in $printers) {
    Write-Host $printer
    #Remove-Printer -Name $printer.Name
}