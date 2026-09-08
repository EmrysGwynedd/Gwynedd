$Path = "$env:USERPROFILE\Downloads"
$Days = 20

$OldFiles = Get-ChildItem -Path $Path -File -Recurse -ErrorAction SilentlyContinue |
Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$Days) }

if ($OldFiles.Count -gt 0) {
    Write-Output "Old files found in Downloads"
    exit 1
} else {
    Write-Output "No old files found"
    exit 0
}