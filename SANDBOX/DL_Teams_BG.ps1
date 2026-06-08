# This script copies the Teams Background images and Thumbs from a Web location to the correct directory on the endpoint machine. 
#
# Author : Richard Hughes
# Date   : 28/7/2022
#

$outputdir = "$env:APPDATA\Microsoft\Teams\Backgrounds\Uploads"
$url       = 'https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/'
[String]$Source = "$env:APPDATA\Microsoft\Teams\Backgrounds\Uploads\*"
[String]$Destination = "$env:OneDrive\Pictures\Zoom_Backgrounds"
#[String]$Destination2 = "$env:USERPROFILE\Pictures\Zoom_Backgrounds"

# Check Directory structure exists and if not create.
# Create Teams Directory
If(!(test-path -PathType container $outputdir))
{
      New-Item -ItemType Directory -Path $Outputdir
}

# Create Zoom Backgroud Locations Directory
If(!(test-path -PathType container $Destination))
{
      New-Item -ItemType Directory -Path $Destination
}

# enable TLS 1.2 and TLS 1.1 protocols
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11

$WebResponse = Invoke-WebRequest -Uri $url
$WebResponse.Links | Select-Object -ExpandProperty href -Skip 1 | ForEach-Object {
    $FileName = $_.TrimStart('/Desgfwrdd/Teams/')
    $FilePath = Join-Path -Path $outputdir -ChildPath $FileName
    $FileUrl  = '{0}/{1}' -f $url.TrimEnd('//Desgfwrdd/Teams/'), $_
    Invoke-WebRequest -Uri $FileUrl -OutFile $FilePath
}


Copy-Item -Force -Recurse -Verbose $Source -Destination $Destination
Get-ChildItem $Destination\*thumb.png | Remove-Item
