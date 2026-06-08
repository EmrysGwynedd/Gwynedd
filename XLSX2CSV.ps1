# Define source and destination folders
$sourceFolder = "C:\Path\To\Source"
$destinationFolder = "C:\Path\To\Destination"

# Create destination folder if it doesn't exist
if (!(Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder
}

# Load Excel COM object
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false

# Process each .xlsx file
Get-ChildItem -Path $sourceFolder -Filter *.xlsx | ForEach-Object {
    $workbook = $excel.Workbooks.Open($_.FullName)
    $csvPath = Join-Path -Path $destinationFolder -ChildPath ($_.BaseName + ".csv")

    # Save as CSV (first worksheet only)
    $workbook.Worksheets.Item(1).SaveAs($csvPath, 6)  # 6 = xlCSV
    $workbook.Close($false)
}

# Quit Excel
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
Remove-Variable excel

Write-Host "Conversion complete. CSV files moved to $destinationFolder"
