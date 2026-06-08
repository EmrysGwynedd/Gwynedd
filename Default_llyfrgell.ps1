# =========================
# Settings
# =========================
$qViewPath = "C:\Program Files\qView\qView.exe"
$vlcPath   = "C:\Program Files\VideoLAN\VLC\vlc.exe"

# Image formats for qView
$imageExts = @(
    ".jpg", ".jpeg", ".png", ".gif", ".bmp",
    ".tiff", ".tif", ".webp", ".avif", ".heic"
)

# Video formats for VLC
$videoExts = @(
    ".mp4", ".m4v", ".mkv", ".avi", ".mov",
    ".wmv", ".flv", ".webm", ".mpeg", ".mpg"
)

# Where to store the policy XML
$xmlPath = "C:\Windows\System32\DefaultAssociations_qView_VLC.xml"

# =========================
# Preconditions
# =========================
function Require-Admin {
    $curr = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-not $curr.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        throw "Please run PowerShell as Administrator."
    }
}
function Test-PathOrThrow($p){
    if (-not (Test-Path $p)) { throw "File not found: $p" }
}
Require-Admin
Test-PathOrThrow $qViewPath
Test-PathOrThrow $vlcPath

# =========================
# Create custom ProgIDs (HKLM)
# qView.Custom.Image & VLC.Custom.Video
# =========================
$progIDs = @{
    "qView.Custom.Image" = $qViewPath
    "VLC.Custom.Video"   = $vlcPath
}

foreach ($progId in $progIDs.Keys) {
    $appPath = $progIDs[$progId]
    $base = "HKLM:\Software\Classes\$progId"
    New-Item -Path "$base\shell\open\command" -Force | Out-Null
    Set-ItemProperty -Path "$base\shell\open\command" -Name '(Default)' -Value "`"$appPath`" `"%1`""

    New-Item -Path "$base\Application" -Force | Out-Null
    Set-ItemProperty -Path "$base\Application" -Name 'ApplicationCompany' -Value "Custom Association"
    Set-ItemProperty -Path "$base\Application" -Name 'ApplicationDescription' -Value "Open files with $progId"
    Set-ItemProperty -Path "$base\Application" -Name 'ApplicationName' -Value $progId
}

# =========================
# Build XML (policy-friendly)
# =========================
function New-AssocLine {
    param([string]$Ext,[string]$ProgId)
    "  <Association Identifier=""$Ext"" ProgId=""$ProgId"" ApplicationName=""$ProgId"" />"
}

$lines = @()
$lines += '<?xml version="1.0" encoding="UTF-8"?>'
$lines += '<DefaultAssociations>'

foreach ($ext in $imageExts) { $lines += (New-AssocLine -Ext $ext -ProgId "qView.Custom.Image") }
foreach ($ext in $videoExts) { $lines += (New-AssocLine -Ext $ext -ProgId "VLC.Custom.Video") }

$lines += '</DefaultAssociations>'

# Write under System32 so it's readable by Winlogon under policy
$lines -join "`r`n" | Set-Content -Path $xmlPath -Encoding UTF8 -Force
Write-Host "Wrote XML: $xmlPath"

# =========================
# Point policy to XML (applies at next sign-in)
# =========================
$polKey = "HKLM:\Software\Policies\Microsoft\Windows\System"
New-Item -Path $polKey -Force | Out-Null
Set-ItemProperty -Path $polKey -Name "DefaultAssociationsConfiguration" -Value $xmlPath
Write-Host "Policy set: $polKey DefaultAssociationsConfiguration -> $xmlPath"

# Optional: Make sure shell knows about new ProgIDs immediately
# (won't override current UserChoice until sign-out)
