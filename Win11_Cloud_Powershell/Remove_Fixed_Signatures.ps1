
###  Remove fixed signatures on Nmwtra Computers


###
### Remove Scheduled Task if Exist  
###

# Define the task name
$TaskName = "Set Outlook Signature"

# Check if the task exists
$Task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue

if ($Task) {
    # Task exists, delete it
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
    Write-Output "Task '$TaskName' has been deleted."
} else {
    # Task does not exist
    Write-Output "Task '$TaskName' does not exist."
}


###
### Remove Associated Registry settings
###

If (Test-Path HKCU:\Software\Microsoft\Office\14.0\Common\MailSettings) 
 { 
 Remove-ItemProperty HKCU:\Software\Microsoft\Office\14.0\Common\MailSettings -Name 'ReplySignature' -Force
 Remove-ItemProperty HKCU:\Software\Microsoft\Office\14.0\Common\MailSettings -Name 'NewSignature' -Force
 } 
If (Test-Path HKCU:\Software\Microsoft\Office\15.0\Common\MailSettings) 
 { 
 Remove-ItemProperty HKCU:\Software\Microsoft\Office\15.0\Common\MailSettings -Name 'ReplySignature' -Force
 Remove-ItemProperty HKCU:\Software\Microsoft\Office\15.0\Common\MailSettings -Name 'NewSignature' -Force
 } 
If (Test-Path HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings) 
 { 
 Remove-ItemProperty HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings -Name 'ReplySignature' -Force
 Remove-ItemProperty HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings -Name 'NewSignature' -Force
 }

 If (Test-Path HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings) 
 { 
 Remove-ItemProperty HKCU:\Software\Microsoft\Office\16.0\Outlook\Profiles\Outlook\9375CFF0413111d3B88A00104B2A6676\00000002 -Name 'New Signature' -Force
 Remove-ItemProperty HKCU:\Software\Microsoft\Office\16.0\Outlook\Profiles\Outlook\9375CFF0413111d3B88A00104B2A6676\00000002 -Name 'Reply-Forward Signature' -Force
 }
 

 
$registryPath = "HKCU:\Software\Cyngor Gwynedd"

if (Test-Path $registryPath) {
    Remove-Item -Path $registryPath -Recurse -Force
}


### Remove created Signature Files from User Location
$folderPath = $env:Appdata + '\Microsoft\Signatures'

if (Test-Path $folderPath) {
    Get-ChildItem -Path $folderPath -Recurse -Force | Remove-Item -Recurse -Force
    Write-Host "Contents of '$folderPath' have been removed."
} else {
    Write-Host "Folder '$folderPath' does not exist."
}
Exit 0









