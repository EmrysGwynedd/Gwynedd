# Remove Microsoft Copilot
Get-AppxPackage -AllUsers Microsoft.Copilot |
ForEach-Object {
    Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
}

# Remove provisioning for future users
Get-AppxProvisionedPackage -Online |
Where-Object {$_.DisplayName -eq "Microsoft.Copilot"} |
Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue