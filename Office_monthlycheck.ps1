$cdn = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration').CDNBaseUrl

if ($cdn -like '*55336b82-a18d-4dd6-b5f6-9e5095c314a6*') {
    Write-Output 'Monthly Enterprise Channel'
    exit 0
}
else {
    Write-Output 'Not Monthly Enterprise Channel'
    exit 1
}