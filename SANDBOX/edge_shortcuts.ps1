$PublicDesktop = "C:\Users\Public\Desktop"

# --- Locate Edge executable (x64 then x86 fallback) ---
$edgePaths = @(
    "$Env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "$Env:ProgramFiles(x86)\Microsoft\Edge\Application\msedge.exe"
)
$edge = $edgePaths | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $edge) {
    Write-Error "Microsoft Edge executable not found."
    exit 1
}

# --- Paths for shortcuts ---
$existing = Join-Path $PublicDesktop "Microsoft Edge.lnk"
$welsh    = Join-Path $PublicDesktop "Porwr Gwe (Cymraeg).lnk"
$english  = Join-Path $PublicDesktop "Web Browser (English).lnk"

# --- 1) Ensure Welsh shortcut name is correct ---
if (Test-Path $existing) {
    Rename-Item -Path $existing -NewName (Split-Path -Leaf $welsh) -Force
}

# If the Welsh shortcut exists, ensure it keeps Edge icon (optional polish)
if (Test-Path $welsh) {
    $ws  = New-Object -ComObject WScript.Shell
    $sc  = $ws.CreateShortcut($welsh)
    if (-not $sc.TargetPath) { $sc.TargetPath = $edge }
    if (-not $sc.IconLocation) { $sc.IconLocation = "$edge, 0" }
    $sc.Save()
}

# --- 2) Create/refresh English (GB) shortcut ---
$ws2 = New-Object -ComObject WScript.Shell
$sc2 = $ws2.CreateShortcut($english)
$sc2.TargetPath   = $edge
$sc2.Arguments    = "--lang=en-GB"
$sc2.IconLocation = "$edge, 0"
$sc2.Save()