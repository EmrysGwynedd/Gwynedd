
$Path = "Registry::HKLM\System\CurrentControlSet\Control\Power"
$Name = "PlatformAoAcOverride"
$Type = "DWORD"
$Value = 0

try{
    if(!(Test-Path $Path)){New-Item -Path $Path -Force}
    if(!$Name){Set-Item -Path $Path -Value $Value}
    else{Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type}
    Write-Output "Value set: $Name = $Value"
}catch{
    Write-Error $_
}