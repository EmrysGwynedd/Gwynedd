$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin"
$Key = "BlockAADWorkplaceJoin"
$KeyFormat = "DWORD"
$Value = 1

try{
    if(!(Test-Path $Path)){New-Item -Path $Path -Force}
    if(!$Key){Set-Item -Path $Path -Value $Value}
    else{Set-ItemProperty -Path $Path -Name $Key -Value $Value -Type $KeyFormat}
    Write-Output "Key set: $Key = $Value"
}catch{
    Write-Error $_
}