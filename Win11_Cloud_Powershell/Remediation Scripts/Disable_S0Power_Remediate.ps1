

$PathAC = "Registry::HKLM\System\CurrentControlSet\Control\Power"
$NameAC = "PlatformAoAcOverride"
$TypeAC = "DWORD"
$ValueAC = 0

$PathDC = "Registry::HKLM\System\CurrentControlSet\Control\Power"
$NameDC = "PlatformAoDcOverride"
$TypeDC = "DWORD"
$ValueDC = 0


try{
    if(!(Test-Path $PathAC)){New-Item -Path $PathAC -Force}
    if(!$NameAC){Set-Item -Path $PathAC -Value $ValueAC}
    else{Set-ItemProperty -Path $PathAC -Name $NameAC -Value $ValueAC -Type $TypeAC}
    Write-Output "Value set: $NameAC = $ValueAC"
}catch{
    Write-Error $_
}

try{
    if(!(Test-Path $PathDC)){New-Item -Path $PathDC -Force}
    if(!$NameDC){Set-Item -Path $PathDC -Value $ValueDC}
    else{Set-ItemProperty -Path $PathDC -Name $NameDC -Value $ValueDC -Type $TypeDC}
    Write-Output "Value set: $NameDC = $ValueDC"
}catch{
    Write-Error $_
}