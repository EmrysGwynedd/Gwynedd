# Remediate_MissingFile.ps1
$filePath = "C:\Windows\System32\AdministrativeUnlock.dll"
Invoke-WebRequest -Uri "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Admin_Unlock/AdministrativeUnlock.dll" -OutFile "C:\Windows\System32\AdministrativeUnlock.dll"
Write-Host "File has been created"