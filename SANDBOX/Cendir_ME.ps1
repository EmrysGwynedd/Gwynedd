# Gwirio os mae cefndiroedd yna yn barod.

$CheckFile1 = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\1ff01ca3-8b8d-4018-a08a-366c09bbd158.png"
$CheckFile2 = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds\Uploads\ff9c91ca-dc95-4387-901e-ea5dd4b8f612.png"

# If BOTH files already exist, skip the entire script
if (
    (Test-Path -LiteralPath $CheckFile1 -PathType Leaf) -and
    (Test-Path -LiteralPath $CheckFile2 -PathType Leaf)
) {
    Write-Host "Cefndiroedd yna yn barod!"
    exit 0
}

Write-Host "Dim yn gweld cefndiroedd yna, yn mynd ymlaen i'w osod..."

# Lleoliadau
$TeamsBackgroundPath = "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\Backgrounds"
$TeamsUploadsPath = "$TeamsBackgroundPath\Uploads"
$SourcePath = "\\me-dtcentral\DCSWRepository\Teams_Cefndir"

# Gwirio bod y source folder ar gael
if (!(Test-Path -LiteralPath $SourcePath -PathType Container)) {
    Write-Host "ERROR: Methu cael mynediad i'r source folder:"
    Write-Host $SourcePath
    exit 1
}

# Creu Teams Uploads folder os oes angen
if (!(Test-Path -LiteralPath $TeamsUploadsPath -PathType Container)) {
    Write-Host "Creating Teams Uploads directory..."

    try {
        New-Item -Path $TeamsUploadsPath -ItemType Directory -Force -ErrorAction Stop | Out-Null
    }
    catch {
        Write-Host "ERROR: Methu creu Teams Uploads directory."
        Write-Host $_.Exception.Message
        exit 1
    }
}

Write-Host "Source:      $SourcePath"
Write-Host "Destination: $TeamsUploadsPath"
Write-Host ""

# Copio'r ffeiliau sydd ddim yna yn barod
$FailedCopies = 0
$CopiedFiles = 0
$SkippedFiles = 0

$Files = Get-ChildItem -LiteralPath $SourcePath -File

foreach ($File in $Files) {

    $Destination = Join-Path -Path $TeamsUploadsPath -ChildPath $File.Name

    Write-Host ""
    Write-Host "Checking: $Destination"

    # Os yw'r ffeil yna yn barod, skip
    if (Test-Path -LiteralPath $Destination -PathType Leaf) {
        Write-Host "Already exists - skipping."
        $SkippedFiles++
        continue
    }

    try {
        Write-Host "Copying: $($File.FullName)"

        Copy-Item `
            -LiteralPath $File.FullName `
            -Destination $Destination `
            -ErrorAction Stop

        if (Test-Path -LiteralPath $Destination -PathType Leaf) {
            Write-Host "Copy successful."
            $CopiedFiles++
        }
        else {
            Write-Host "ERROR: File was not created."
            $FailedCopies++
        }
    }
    catch {
        Write-Host "ERROR copying file:"
        Write-Host $_.Exception.Message
        $FailedCopies++
    }
}

Write-Host ""
Write-Host "----------------------------------------"
Write-Host "Copied:  $CopiedFiles"
Write-Host "Skipped: $SkippedFiles"
Write-Host "Failed:  $FailedCopies"
Write-Host "----------------------------------------"
Write-Host ""

# Final verification
if (
    (Test-Path -LiteralPath $CheckFile1 -PathType Leaf) -and
    (Test-Path -LiteralPath $CheckFile2 -PathType Leaf)
) {
    Write-Host "Cefndiroedd wedi ei osod."
    exit 0
}
else {
    Write-Host "ERROR: Ddim yn gallu dod o hyd i'r ffeiliau detection ar ol copio."
    exit 1
}