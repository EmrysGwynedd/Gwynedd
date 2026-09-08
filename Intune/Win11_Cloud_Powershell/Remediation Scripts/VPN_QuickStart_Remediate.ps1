
$Path = "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$Name = "Userinit"
$Type = "DWORD"
$Value = 'C:\Windows\system32\userinit.exe,"C:\Program Files (x86)\Cisco\Cisco Secure Client\UI\csc_ui.exe" -autolaunched'


try{
    if(!(Test-Path $Path)){New-Item -Path $Path -Force}
    if(!$Name){Set-Item -Path $Path -Value $Value}
    else{Set-ItemProperty -Path $Path -Name $Name -Value $Value}
    Write-Output "Value set: $Name = $Value"
}catch{
    Write-Error $_
}
