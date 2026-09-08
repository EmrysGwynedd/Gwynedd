try{
    Add-Printer -ConnectionName \\Papercut-1\Konica_Gwynedd
}catch{
    Write-Error $_
}