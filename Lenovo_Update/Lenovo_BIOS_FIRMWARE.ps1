# Powershell sy'n uwchraddio BIOS ac Firmware unrhyw ddyfais Lenovo

# Angen System Account Cred i allu gweld SCCM-Rheolwr-01
$cred = Get-Credential
New-PSDrive -Name V -PSProvider FileSystem -Root \\sccm-rheolwr-01\d$\Lenovo_Driver_Repository -Persist -Credential $cred

# Gosod y module
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module -Name 'LSUClient'

# Hel gwybodaeth am y ddyfais
gcim Win32_ComputerSystem | fl Manufacturer, Model, SystemFamily
Get-LSUpdate -Repository \\sccm-rheolwr-01\d$\Lenovo_Driver_Repository
Get-LSUpdate | Tee-Object -Variable updates

# Gosod y BIOS a Firmware
$updates | ? Type -like "*BIOS*" | Install-LSUpdate
$updates | ? Type -like "*Firmware*" | Install-LSUpdate
