
$Path = "Registry::HKCU\Software\Microsoft\Office\16.0\Outlook\Options\General"
$Name = "HideNewOutlookToggle"
$Type = "DWORD"
$Value = 1

try{
    if(!(Test-Path $Path)){New-Item -Path $Path -Force}
    if(!$Name){Set-Item -Path $Path -Value $Value}
    else{Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type}
    Write-Output "Value set: $Name = $Value"
}catch{
    Write-Error $_
}