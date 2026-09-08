$shortcut = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Zoom\Zoom Workplace.lnk"
$tempName = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Zoom\zoom_w.lnk"

Rename-Item -Path $shortcut -NewName "zoom_w.lnk"

# Refresh Start Menu
Stop-Process -Name StartMenuExperienceHost -Force -ErrorAction SilentlyContinue
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

Start-Sleep -Seconds 5

Start-Process explorer.exe

Rename-Item -Path $tempName -NewName "Zoom Workplace.lnk"