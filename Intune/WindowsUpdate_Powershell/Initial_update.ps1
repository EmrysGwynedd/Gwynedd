# Gosod u modiwl i allu rhedeg Windows Update drwy PowerShell
Install-Module PSWindowsUpdate -Force

# Dangos bob ypdet sydd ar gael i'r ddyfais.
Get-WindowsUpdate

# Gosod bob ypdet yn cynnwys y drivers mae Windows Update yn eu cynnig, ac ailgychwyn y system os oes angen
Install-WindowsUpdate -AcceptAll -AutoReboot