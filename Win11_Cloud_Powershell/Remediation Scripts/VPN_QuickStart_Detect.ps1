
$FilePath = "C:\Program Files (x86)\Cisco\Cisco Secure Client\UI\csc_ui.exe"

$Path = "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$Name = "Userinit"
$Value = 'C:\Windows\system32\userinit.exe,"C:\Program Files (x86)\Cisco\Cisco Secure Client\UI\csc_ui.exe" -autolaunched'


Try {
    
      If (Test-Path $FilePath)
      {
      Write-Output "VPN is Installed"
      $Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
        If ($Registry -eq $Value)
        {
        Write-Output "Registry Setting already Exists"
        Exit 0
        }
        Else
        {
        Write-Warning "Registry Needs Changing"
        Exit 1
        }
      } 
      Write-Warning "VPN NOT installed. Machine Compliant for NON VPN setup."
      Exit 0
} 

Catch {
    Write-Warning "Invalid file or registry entries. Cannot make changes."
    Exit 0
}
