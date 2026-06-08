???$Reg1 ="HKLM:\Software\WOW6432Node\Policies\Adobe"
$Reg2 ="HKLM:\Software\WOW6432Node\Policies\Adobe\Acrobat Reader"
$Reg3 ="HKLM:\Software\WOW6432Node\Policies\Adobe\Acrobat Reader\DC"
$Reg4 = "HKLM:\Software\WOW6432Node\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown"

$TReg1 = Test-Path -Path $Reg1
 If ($TReg1 -eq $false)
 {New-Item -Path $Reg1 -ItemType Key}

$TReg2 = Test-Path -Path $Reg2
 If ($TReg2 -eq $false)
 {New-Item -Path $Reg2 -ItemType Key}

 $TReg3 = Test-Path -Path $Reg3
 If ($TReg3 -eq $false)
 {New-Item -Path $Reg3 -ItemType Key}

  $TReg4 = Test-Path -Path $Reg4
 If ($TReg4 -eq $false)
  {
   New-Item -Path $Reg4 -ItemType Key
   New-ItemProperty -Path $Reg4 -Name "bAcroSuppressUpsell" -Value 1 -PropertyType DWord -Force
  }
 Else
  {
   New-ItemProperty -Path $Reg4 -Name "bAcroSuppressUpsell" -Value 1 -PropertyType DWord -Force
  }


