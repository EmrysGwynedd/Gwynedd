# Define the value to set
$wallpaperPath = "C:\Windows\Wallpaper\Cefndir.png"
$wallpaperStyle = "4"
$wallpaperDefault = ""
$regSubKey = "Software\Microsoft\Windows\CurrentVersion\Policies\System"


# Get all user SIDs under HKEY_USERS (excluding default/system accounts)
$userSIDs = Get-ChildItem Registry::HKEY_USERS | Where-Object {
    $_.Name -match "^HKEY_USERS\\S-1-5-21" -and
    $_.Name -notmatch "_Classes$"
}

foreach ($sid in $userSIDs) {
    $userKeyPath = "Registry::${sid}\$regSubKey"

    # Create the key if it doesn't exist
    if (-not (Test-Path $userKeyPath)) {
        New-Item -Path $userKeyPath -Force | Out-Null
    }

    # Set the Wallpaper string value
    Set-ItemProperty -Path $userKeyPath -Name "Wallpaper" -Value $wallpaperPath -Type String
    Set-ItemProperty -Path $userKeyPath -Name "WallpaperStyle" -Value $wallpaperStyle -Type String
    Set-ItemProperty -Path $userKeyPath -Name "(Default)" -Value $wallpaperDefault -Type String
}

Set-ItemProperty -Path $userKeyPath -Name "(Default)" -Value $wallpaperDefault -Type Binary