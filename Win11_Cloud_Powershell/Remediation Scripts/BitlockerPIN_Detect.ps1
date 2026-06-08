$pin = (Get-BitLockerVolume -MountPoint $env:SystemDrive).KeyProtector  | Where { $_.KeyProtectorType -eq 'TpmPin' }

if (((Get-BitLockerVolume -MountPoint $env:SystemDrive).VolumeStatus) -ne "FullyDecrypted")
    {
    Write-Output "Encryption enabled"
    if ($pin -ne $null)
        {
            Write-Output "TPM Pin set"
            Exit 0
        }
    else
        {
            Write-Output "TPM Pin is not set"
            Exit 1
        }

    }
else
    {
        Write-Output "Encryption not yet started"
        Exit 0
    }