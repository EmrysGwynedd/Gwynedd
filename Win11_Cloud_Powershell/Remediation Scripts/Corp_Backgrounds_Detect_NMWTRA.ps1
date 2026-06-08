# Detect_MissingFile.ps1
$filePath = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\9f3c88c0-9be8-4c01-b75a-f02f9420fac5_thumb.png"
if (Test-Path $filePath) {
    Write-Host "File exists"
    exit 0
} else {
    Write-Host "File is missing"
    exit 1
}