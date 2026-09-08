# This script copies and Sets Machine Level Files and Preferences. 
#
# Author : Richard Hughes
# Date   : 18/10/2024
#

# Copy the Files from the Web Storage to the Local Locations

$files = @(
    #Copy Admin Unlock File Locally
    @{url = "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Admin_Unlock/AdministrativeUnlock.dll"; output = "C:\Windows\System32\AdministrativeUnlock.dll"}
)

foreach ($file in $files) {
    Invoke-WebRequest -Uri $file.url -OutFile $file.output
}


# Set Machine Level Registy items
# Install Setting for Administrative Unlock to work with Windows 11

#New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{B986C180-0798-4DF5-A611-A1991AA890B9}" -Name "(Default)" -Value "AdministrativeUnlock" -PropertyType String -Force
#New-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\CLSID\{B986C180-0798-4DF5-A611-A1991AA890B9}" -Name "(Default)" -Value "AdministrativeUnlock" -PropertyType String -Force
#New-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\CLSID\{B986C180-0798-4DF5-A611-A1991AA890B9}\InprocServer32" -Name "(Default)" -Value "AdministrativeUnlock.dll" -PropertyType String -Force
#New-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\CLSID\{B986C180-0798-4DF5-A611-A1991AA890B9}\InprocServer32" -Name "ThreadingModel" -Value "Apartment" -PropertyType String -Force

