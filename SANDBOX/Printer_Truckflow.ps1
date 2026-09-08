# Define the printer name and port
$printerName = "Generic / Text Only"
$portName = "LPT1:"

# Add the printer port
Add-PrinterPort -Name $portName

# Add the printer
Add-Printer -Name $printerName -DriverName "Generic / Text Only" -PortName $portName
