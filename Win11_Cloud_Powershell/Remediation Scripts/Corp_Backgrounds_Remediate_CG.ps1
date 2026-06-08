
# These Files will be copied and overwritten if not currently in use
$files = @(
    # Copy Teams Background files to local source
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/1edaf5dc-41a5-4487-b69d-1acd245a4da7.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\1edaf5dc-41a5-4487-b69d-1acd245a4da7.png";},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/1edaf5dc-41a5-4487-b69d-1acd245a4da7_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\1edaf5dc-41a5-4487-b69d-1acd245a4da7_thumb.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/25386a82-23d5-4766-8ecb-a87d893d4fcc.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\25386a82-23d5-4766-8ecb-a87d893d4fcc.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/25386a82-23d5-4766-8ecb-a87d893d4fcc_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\25386a82-23d5-4766-8ecb-a87d893d4fcc_thumb.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/26c81595-cc7e-4659-81b5-d15b3e0ece71.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\26c81595-cc7e-4659-81b5-d15b3e0ece71.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/26c81595-cc7e-4659-81b5-d15b3e0ece71_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\26c81595-cc7e-4659-81b5-d15b3e0ece71_thumb.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/99b5bfb7-e775-4af0-94a3-07f18320be89.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\99b5bfb7-e775-4af0-94a3-07f18320be89.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/99b5bfb7-e775-4af0-94a3-07f18320be89_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\99b5bfb7-e775-4af0-94a3-07f18320be89_thumb.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/019e036d-a811-4280-96c6-c2cebc552939.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\019e036d-a811-4280-96c6-c2cebc552939.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/019e036d-a811-4280-96c6-c2cebc552939_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\019e036d-a811-4280-96c6-c2cebc552939_thumb.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/f7433cea-6a4e-447f-9e78-3971478e65f5.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\f7433cea-6a4e-447f-9e78-3971478e65f5.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/f7433cea-6a4e-447f-9e78-3971478e65f5_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\f7433cea-6a4e-447f-9e78-3971478e65f5_thumb.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/bafa532d-62a5-44de-a273-b64492a1e797.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\bafa532d-62a5-44de-a273-b64492a1e797.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/bafa532d-62a5-44de-a273-b64492a1e797_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\bafa532d-62a5-44de-a273-b64492a1e797_thumb.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/28bdb87c-e9fa-4f4c-9c56-4ad7f05040d2.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\28bdb87c-e9fa-4f4c-9c56-4ad7f05040d2.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/28bdb87c-e9fa-4f4c-9c56-4ad7f05040d2_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\28bdb87c-e9fa-4f4c-9c56-4ad7f05040d2_thumb.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/9f3c88c0-9be8-4c01-b75a-f02f9420fac5.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\9f3c88c0-9be8-4c01-b75a-f02f9420fac5.png"},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/9f3c88c0-9be8-4c01-b75a-f02f9420fac5_thumb.png"; output = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\9f3c88c0-9be8-4c01-b75a-f02f9420fac5_thumb.png"},
    #Zoom
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/1edaf5dc-41a5-4487-b69d-1acd245a4da7.png"; output = "$env:Onedrive\Pictures\Zoom_Backgrounds\CGC_1.png";},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/25386a82-23d5-4766-8ecb-a87d893d4fcc.png"; output = "$env:Onedrive\Pictures\Zoom_Backgrounds\CGC_2.png";},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/26c81595-cc7e-4659-81b5-d15b3e0ece71.png"; output = "$env:Onedrive\Pictures\Zoom_Backgrounds\CGC_3.png";},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/99b5bfb7-e775-4af0-94a3-07f18320be89.png"; output = "$env:Onedrive\Pictures\Zoom_Backgrounds\CGC_4.png";},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/019e036d-a811-4280-96c6-c2cebc552939.png"; output = "$env:Onedrive\Pictures\Zoom_Backgrounds\CGC_5.png";},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/f7433cea-6a4e-447f-9e78-3971478e65f5.png"; output = "$env:Onedrive\Pictures\Zoom_Backgrounds\CGC_6.png";},
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/bafa532d-62a5-44de-a273-b64492a1e797.png"; output = "$env:Onedrive\Pictures\Zoom_Backgrounds\CGC_7.png";}, 
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/CG/28bdb87c-e9fa-4f4c-9c56-4ad7f05040d2.png"; output = "$env:Onedrive\Pictures\Zoom_Backgrounds\CGC_8.png";}
)



# Check if files exist on local host and if not copy the Files from the Web Storage to the Local Locations
foreach ($file in $files) 
 {
  sleep -Seconds 2
  write-host ""
  write-host $file.output

  # Check if the Teams Background directory exists
  if (Test-Path -Path $env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds) {
  }  else   {
   New-Item -Path $env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams -Name Backgrounds -ItemType Directory
  }
  # Check if the Teams Uploads directory exists
  if (Test-Path -Path $env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads) {
  }  else   {
   New-Item -Path $env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds -Name Uploads -ItemType Directory
  }
    # Check if the Zoom directory exists
  if (Test-Path -Path $env:Onedrive\Pictures\Zoom_Backgrounds) {
  }  else   {
   New-Item -Path $env:Onedrive\Pictures -Name Zoom_Backgrounds -ItemType Directory
  }

  # Check if the destination file exists
  if (Test-Path -Path $file.output) {
  } else {
    $response = Invoke-WebRequest -Uri $file.url -OutFile $file.output
  }
 }

