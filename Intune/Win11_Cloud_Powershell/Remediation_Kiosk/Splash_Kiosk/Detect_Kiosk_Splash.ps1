$folderPath = "C:\TG\Splash_Kiosk"
$filePath   = Join-Path $folderPath "splash.html"
$imagePath  = Join-Path $folderPath "LogoCwcis.png"

if (
    (Test-Path $folderPath) -and
    (Test-Path $filePath) -and
    (Test-Path $imagePath)
) {
    Write-Output "Compliant"
    exit 0
}
else {
    Write-Output "Not Compliant"
    exit 1
}