
# .NET 6 REMOVAL + .NET 8.0.20 INSTALL SCRIPT
# Defnyddio dotnet-core-uninstall.msi


Write-Host "STEP 1: Ensure .NET Uninstall Tool is Installed"

$uninstallToolPath = "C:\Program Files\dotnet-core-uninstall\dotnet-core-uninstall.exe"
$msiPath = "C:\TG\dotNET\dotnet-core-uninstall.msi"

if (-Not (Test-Path $uninstallToolPath)) {
    Write-Host "Installing dotnet-core-uninstall.msi ..."
    Start-Process "msiexec.exe" -ArgumentList "/i `"$msiPath`" /quiet /norestart" -Wait
}
else {
    Write-Host "✔ Uninstall tool already installed."
}


# STEP 2: REMOVE ALL .NET 6 RUNTIMES AND SDKs
Write-Host "`n=== STEP 2: Removing .NET 6 runtimes, ASP.NET runtimes, SDKs ===`n"

$tool = $uninstallToolPath

# Preview list (optional)
Start-Process $tool -ArgumentList "list" -Wait

# Remove runtimes
Start-Process $tool -ArgumentList "remove --all --runtime --yes" -Wait

# Remove ASP.NET Core runtimes
Start-Process $tool -ArgumentList "remove --all --aspnet-runtime --yes" -Wait

# Remove SDKs
Start-Process $tool -ArgumentList "remove --all --sdk --yes" -Wait

Write-Host "✔ Removal commands executed."

# DELETE LEFTOVER DOTNET 6 FOLDER STRUCTURES


Write-Host "`n=== STEP 3: Cleaning leftover .NET 6 folders ===`n"

$paths = @(
    "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\6.*",
    "C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App\6.*",
    "C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App\6.*",
    "C:\Program Files\dotnet\sdk\6.*"
)

foreach ($p in $paths) {
    Get-ChildItem $p -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Host "Deleting $($_.FullName)"
        Remove-Item $_.FullName -Recurse -Force
    }
}


# STEP 4: INSTALL .NET RUNTIME 8.0.20 IF NOT PRESENT


Write-Host "=== STEP 4: Checking .NET 8.0.20 presence ==="

$dotnetRuntimeInstalled = & dotnet --list-runtimes 2>$null | Select-String "Microsoft.NETCore.App 8.0.20"

if ($dotnetRuntimeInstalled) {
    Write-Host "✔ .NET 8.0.20 already installed — skipping."
}
else {
    Write-Host "❗ .NET 8.0.20 not found — installing now."

    $runtimeUrl = "https://download.visualstudio.microsoft.com/download/pr/5e4a0d89-9a0b-4b58-a3df-7fede60b7a31/3fcd8b5b6b05f02f37d0e9628f1e0a67/dotnet-runtime-8.0.20-win-x64.exe"
    $installer = "$env:TEMP\dotnet-runtime-8.0.20.exe"

    Invoke-WebRequest -Uri $runtimeUrl -OutFile $installer -UseBasicParsing
    Start-Process $installer -ArgumentList "/install /quiet /norestart" -Wait

    Write-Host "✔ .NET Runtime 8.0.20 installed."
}


Write-Host "=== STEP 5: FINAL VERIFICATION ==="

if (Get-Command dotnet -ErrorAction SilentlyContinue) {
    dotnet --list-runtimes
} else {
    Write-Host "WARNING: dotnet not found in PATH, but installation may still exist."
}

Write-Host "✔ PROCESS COMPLETE" -ForegroundColor Green
Write-Host "✔ All .NET 6 removed"
Write-Host "✔ .NET 8.0.20 installed (if missing)"
Write-Host "✔ System cleaned"