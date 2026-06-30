Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Creu y ffolder i gadw'r ffeil csv
New-Item -Path "C:\TG\BIOS_SecureBoot" -ItemType Directory -Force | Out-Null

# Creu y ffeil csv a'i rhoi yn y lleoliad cywir
@"
Name,Value
CSM,Disabled
Secure Boot,Enabled
SecureBoot,Enable
"@ | Out-File "C:\TG\BIOS_SecureBoot\Settings_CSV_SecureBoot.csv" -Encoding UTF8 -Force

# Copi o Manage-LenovoBiosSettings.ps1
Copy-Item "\\me-dtcentral\DCSWRepository\Lenovo\BIOS_SecureBoot\Manage-LenovoBiosSettings.ps1" "C:\TG\BIOS_SecureBoot" -Force

# Rhedeg y script i newid settings bios yn y ffeil csv
C:\TG\BIOS\Manage-LenovoBiosSettings.ps1 -SetSettings -CsvPath C:\TG\BIOS\Settings_CSV_SecureBoot.csv -SupervisorPassword cg679114cg
C:\TG\BIOS\Manage-LenovoBiosSettings.ps1 -SetSettings -CsvPath C:\TG\BIOS\Settings_CSV_SecureBoot.csv -SupervisorPassword milamber1