# Path to input CSV
$csvPath = ".\PCList.csv"

# File to check
$filePath = "C:\Program Files\Accero\Client624_patch\Environments\eprod\filecl32"

# Import PC list
$pcList = Import-Csv -Path $csvPath

# Create an array to hold results
$results = @()

foreach ($pc in $pcList) {
    $computer = $pc.PCName
    Write-Host "Checking $computer ..." -ForegroundColor Cyan

    # Test if PC is online
    if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
        $online = "Online"

        # ✅ Use $filePath in the remote script block
        $fileExists = Invoke-Command -ComputerName $computer -ScriptBlock {
            param($path)
            Test-Path $path
        } -ArgumentList $filePath

        if ($fileExists) {
            $status = "File Found"
        } else {
            $status = "File NOT Found"
        }
    }
    else {
        $online = "Offline"
        $status = "Unable to check (offline)"
    }

    # Add results to array
    $results += [PSCustomObject]@{
        PCName     = $computer
        Online     = $online
        FileStatus = $status
    }
}

# ✅ Display results only
$results | Format-Table -AutoSize