$installer = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vs_installer.exe"
$installPath = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional"

Start-Process -FilePath $installer `
  -ArgumentList @("uninstall","--installPath","`"$installPath`"","--quiet","--norestart","--wait") `
  -Wait -PassThru