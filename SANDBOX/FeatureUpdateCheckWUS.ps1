# Force i rhedeg Windows Update Install
UsoClient StartScan

# Dangos pa ypdets sydd ar gael ar y peiriant, ac os mae ef wedi lawrlwytho neu ddim. Cewch anwybyddu Drivers ar y rhestr
((New-Object -ComObject Microsoft.Update.Session).CreateUpdateSearcher().Search('IsInstalled=0 and IsHidden=0').Updates |
Where-Object {$_.IsDownloaded}).Count

# All hwn cychwyn force download os di ISDOWNLOAD yn False i ypdet 
UsoClient StartDownload

# Hwn sy'n force install i unrhyw ypdet/feature ypdet
UsoClient StartInstall

# % of faint or setup sydd wedi ei wneud.
(Get-ItemProperty 'HKLM:\SYSTEM\Setup\MoSetup\Volatile').SetupProgress

# Os mae o angen Reboot:
Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired'