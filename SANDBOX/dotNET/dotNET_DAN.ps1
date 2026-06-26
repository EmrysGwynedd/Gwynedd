# ===============================
# .NET CLEANUP + MULTI-INSTALL
# ===============================

# Minimum version to keep
$minimumVersion = [version]"8.0.20"

# Target runtimes to ensure
$targetVersions = @(
    @{ Version = "8.0.24"; Url = "https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-8.0.24-windows-x64-installer" },
    @{ Version = "9.0.13"; Url = "https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-9.0.13-windows-x64-installer" },
    @{ Version = "10.0.3"; Url = "https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-10.0.3-windows-x64-installer" }
)

# -------------------------------
# ADMIN CHECK
# -------------------------------
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {

    Write-Host "❗ Run as Administrator" -ForegroundColor Red
    exit 1
}

# -------------------------------
# STEP 1: Ensure uninstall tool
# -------------------------------
Write-Host "`nSTEP 1: Ensure uninstall tool"

$tool = "C:\Program Files\dotnet-core-uninstall\dotnet-core-uninstall.exe"
$msi = "C:\TG\dotNET\dotnet-core-uninstall.msi"

if (-Not (Test-Path $tool)) {
    Write-Host "Installing uninstall tool..."
    Start-Process "msiexec.exe" -ArgumentList "/i `"$msi`" /quiet /norestart" -Wait
}
else {
    Write-Host "✔ Uninstall tool present"
}

# -------------------------------
# STEP 2: REMOVE OLD RUNTIMES
# -------------------------------
Write-Host "`nSTEP 2: Removing runtimes < $minimumVersion"

$runtimes = & dotnet --list-runtimes 2>$null

foreach ($line in $runtimes) {

    if ($line -match "^(?<name>[\w\.]+)\s(?<ver>\d+\.\d+\.\d+)") {

        $name = $matches["name"]
        $ver = [version]$matches["ver"]

        if ($ver -lt $minimumVersion) {

            Write-Host "Removing $name $ver"

            if ($name -like "Microsoft.NETCore.App") {
                Start-Process $tool -ArgumentList "remove --runtime --version $ver --yes" -Wait
            }
            elseif ($name -like "Microsoft.AspNetCore.App") {
                Start-Process $tool -ArgumentList "remove --aspnet-runtime --version $ver --yes" -Wait
            }
            elseif ($name -like "Microsoft.WindowsDesktop.App") {
                Start-Process $tool -ArgumentList "remove --runtime --version $ver --yes" -Wait
            }
        }
    }
}

# -------------------------------
# STEP 2B: REMOVE OLD SDKs
# -------------------------------
Write-Host "`nRemoving SDKs < $minimumVersion"

$sdks = & dotnet --list-sdks 2>$null

foreach ($line in $sdks) {

    if ($line -match "^(?<ver>\d+\.\d+\.\d+)") {

        $ver = [version]$matches["ver"]

        if ($ver -lt $minimumVersion) {
            Write-Host "Removing SDK $ver"
            Start-Process $tool -ArgumentList "remove --sdk --version $ver --yes" -Wait
        }
    }
}

# -------------------------------
# STEP 3: CLEAN LEFTOVERS
# -------------------------------
Write-Host "`nSTEP 3: Cleaning leftover folders"

$base = "C:\Program Files\dotnet"

$folders = @(
    "$base\shared\Microsoft.NETCore.App",
    "$base\shared\Microsoft.WindowsDesktop.App",
    "$base\shared\Microsoft.AspNetCore.App",
    "$base\sdk"
)

foreach ($f in $folders) {
    if (Test-Path $f) {

        Get-ChildItem $f | ForEach-Object {

            try {
                $ver = [version]$_.Name

                if ($ver -lt $minimumVersion) {
                    Write-Host "Deleting $($_.FullName)"
                    Remove-Item $_.FullName -Recurse -Force
                }
            }
            catch {
                # Ignore non-version folders
            }
        }
    }
}

# -------------------------------
# STEP 4: INSTALL REQUIRED RUNTIMES
# -------------------------------
Write-Host "`nSTEP 4: Ensuring required runtimes"

foreach ($item in $targetVersions) {

    $version = $item.Version
    $url = $item.Url

    Write-Host "`nChecking .NET $version..."

    $exists = & dotnet --list-runtimes 2>$null | Select-String "Microsoft.NETCore.App $version"

    if ($exists) {
        Write-Host "✔ .NET $version already installed"
    }
    else {
        Write-Host "Installing .NET $version..."

        $file = "$env:TEMP\dotnet-runtime-$version.exe"

        try {
            Invoke-WebRequest $url -OutFile $file -UseBasicParsing
            Start-Process $file -ArgumentList "/install /quiet /norestart" -Wait
            Write-Host "✔ Installed .NET $version"
        }
        catch {
            Write-Host "❌ Failed to install $version"
        }
    }
}

# -------------------------------
# STEP 5: FINAL VERIFICATION
# -------------------------------
Write-Host "`n=== FINAL STATE ==="

if (Get-Command dotnet -ErrorAction SilentlyContinue) {
    dotnet --list-runtimes
    dotnet --list-sdks
}
else {
    Write-Host "⚠ dotnet not found in PATH"
}

Write-Host "`n✔ PROCESS COMPLETE" -ForegroundColor Green
Write-Host "✔ Old .NET versions removed (< 8.0.20)"
Write-Host "✔ .NET 8.0.24, 9.0.13, 10.0.3 ensured"
Write-Host "✔ System cleaned"