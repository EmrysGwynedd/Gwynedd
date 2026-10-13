@(
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\1edaf5dc-41a5-4487-b69d-1acd245a4da7.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\1edaf5dc-41a5-4487-b69d-1acd245a4da7_thumb.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\25386a82-23d5-4766-8ecb-a87d893d4fcc.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\25386a82-23d5-4766-8ecb-a87d893d4fcc_thumb.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\26c81595-cc7e-4659-81b5-d15b3e0ece71.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\26c81595-cc7e-4659-81b5-d15b3e0ece71_thumb.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\99b5bfb7-e775-4af0-94a3-07f18320be89.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\99b5bfb7-e775-4af0-94a3-07f18320be89_thumb.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\019e036d-a811-4280-96c6-c2cebc552939.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\019e036d-a811-4280-96c6-c2cebc552939_thumb.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\f7433cea-6a4e-447f-9e78-3971478e65f5.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\f7433cea-6a4e-447f-9e78-3971478e65f5_thumb.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\bafa532d-62a5-44de-a273-b64492a1e797.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\bafa532d-62a5-44de-a273-b64492a1e797_thumb.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\28bdb87c-e9fa-4f4c-9c56-4ad7f05040d2.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\28bdb87c-e9fa-4f4c-9c56-4ad7f05040d2_thumb.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\9f3c88c0-9be8-4c01-b75a-f02f9420fac5.png",
"$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\9f3c88c0-9be8-4c01-b75a-f02f9420fac5_thumb.png"
) | ForEach-Object {
    Remove-Item -LiteralPath $_ -Force -ErrorAction SilentlyContinue
}