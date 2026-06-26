$SetupExe = "C:\TG\Win11_UPGRADE\Setup.exe"
$Arguments = "/auto upgrade /DynamicUpdate Disable /quiet /eula accept /noreboot"

Start-Process -FilePath $SetupExe -ArgumentList $Arguments -Wait