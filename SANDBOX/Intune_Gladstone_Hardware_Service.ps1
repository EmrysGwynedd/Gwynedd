# Gosod Gladstone Hardware Service a rhoi y hawliau priodol i'r ffolder i pobl sydd angen ei ddefnyddio.
$folderPath = "C:\Program Files (x86)\MRM Software"
if (Test-Path $folderPath) {
    Write-Host "Gladstone Hardware Service ar y ddyfais"
    exit
} else {
    Write-Host "Gosod Gladstone Hardware Service nawr:"

# Rhoi hawl 'Full Control' i MAD01\Defnyddwyr Gladstone MRMplus2 PRAWF i C:\Program Files (x86)\RKYV\
New-Item -Path "C:\Program Files (x86)" -Name "MRM Software" -ItemType Directory
$user = "MAD01\Defnyddwyr Gladstone MRMplus2 PRAWF"
$acl = Get-Acl $folderPath
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "Fullcontrol", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($accessRule)
Set-Acl $folderPath $acl

# Gosod yr MSI
Copy-Item -Path "\\me-dtcentral\DCSWRepository\Gladstone_Hardware_Service\" -Destination "C:\TG\Gladstone_Hardware_Service" -Recurse
$file = "C:\TG\Gladstone_Hardware_Service\POS.ServiceInstaller.msi"
$log = "C:\TG\Gladstone_Hardware_Service\Gladstone_Hardware_Service_Install.log"

$msiArgs = 
  '/I',
  "`"$file`"",
  "/qn",
  "/l*v `"$log`""
  
Start-Process msiexec.exe -Args $msiArgs -Wait

#diwedd y script catch
}