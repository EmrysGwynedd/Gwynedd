# Detect_MissingFile.ps1
$filePath = "C:\Windows\System32\AdministrativeUnlock.dll"
if (Test-Path $filePath) {
    Write-Host "File exists"
    exit 0
} else {
    Write-Host "File is missing"
    exit 1
}