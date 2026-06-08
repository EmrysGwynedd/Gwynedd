# Run powercfg to get supported sleep states
$powerStates = powercfg /a

# Display the results
Write-Host "Supported Power States:"
$powerStates | ForEach-Object { Write-Host $_ }