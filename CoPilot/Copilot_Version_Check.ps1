Get-AppxPackage -AllUsers |
ForEach-Object {

    $DisplayName = $null

    try {
        $Manifest = Join-Path $_.InstallLocation "AppxManifest.xml"

        if (Test-Path $Manifest) {
            [xml]$Xml = Get-Content $Manifest
            $DisplayName = $Xml.Package.Properties.DisplayName

            if ($DisplayName -like "*Copilot*") {
                [PSCustomObject]@{
                    DisplayName = $DisplayName
                    PackageName = $_.Name
                    Version     = $_.Version
                    InstallPath = $_.InstallLocation
                }
            }
        }
    }
    catch {}
}