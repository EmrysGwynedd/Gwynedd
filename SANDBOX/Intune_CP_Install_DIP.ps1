# Gosod SmartOffice
$file = "\\me-dtcentral\DCSWRepository\DIP_Install\SmartOffice\SmartOffice (64-bit).msi"
$log = "C:\TG\DIP.log"

$msiArgs = 
  '/I',
  "`"$file`"",
  "/qn",
  "/l*v `"$log`""
  
Start-Process msiexec.exe -Args $msiArgs -Wait

# Rhoi hawl 'Modify' i MAD01\Defnyddwyr Academy Revenues i C:\Program Files (x86)\RKYV\
$folderPath = "C:\Program Files (x86)\RKYV"
$user = "MAD01\DIPREVENUES"
$acl = Get-Acl $folderPath
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($accessRule)
Set-Acl $folderPath $acl

# Copio ini files SmartOffice
Copy-Item -Path "\\me-dtcentral\DCSWRepository\DIP_Install\IniFile\*" -Destination "C:\Program Files (x86)\RKYV"

# Gosod SmartConfig
Copy-Item -Path "\\me-dtcentral\DCSWRepository\DIP_Install\SmartConfig\*" -Destination "C:\Program Files (x86)\RKYV"

# Gosod SmartViewer2
$file2 = "\\me-dtcentral\DCSWRepository\DIP_Install\SmartViewer\SmartViewer2Setup.msi"

$msiArgs2 = 
  '/I',
  "`"$file2`"",      #`# !! enclosing in `"...`" is needed due to the bug mentioned above
  '/qn'

Start-Process msiexec.exe -Args $msiArgs2 -Wait

New-Item -Name "RKYV" -Path "C:\Users\Public" -ItemType Directory
New-Item -Name "CheckOut" -Path "C:\Users\Public\RKYV" -ItemType Directory
New-Item -Name "Items" -Path "C:\Users\Public\RKYV" -ItemType Directory
New-Item -Name "Local" -Path "C:\Users\Public\RKYV" -ItemType Directory
New-Item -Name "Open" -Path "C:\Users\Public\RKYV" -ItemType Directory
Copy-Item -Path "C:\Program Files (x86)\RKYV\CheckOut\*" -Destination "C:\Users\Public\RKYV\CheckOut" -Recurse -Force
Copy-Item -Path "C:\Program Files (x86)\RKYV\Items\*" -Destination "C:\Users\Public\RKYV\Items" -Recurse -Force
Copy-Item -Path "C:\Program Files (x86)\RKYV\Local\*" -Destination "C:\Users\Public\RKYV\Local" -Recurse -Force
Copy-Item -Path "C:\Program Files (x86)\RKYV\\Open\*" -Destination "C:\Users\Public\RKYV\Open" -Recurse -Force
Remove-Item -Path "C:\Users\Public\RKYV\Local\Packs\SO_Local.exe" -Recurse -Force