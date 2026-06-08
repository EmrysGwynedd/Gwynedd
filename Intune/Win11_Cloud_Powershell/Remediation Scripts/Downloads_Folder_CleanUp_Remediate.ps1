Add-Type -AssemblyName Microsoft.VisualBasic

$Path = "$env:USERPROFILE\Downloads"
$Days = 20

Get-ChildItem -Path $Path -File -Recurse -ErrorAction SilentlyContinue |
Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$Days) } |
ForEach-Object {
    try {
        [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile(
            $_.FullName,
            'OnlyErrorDialogs',
            'SendToRecycleBin'
        )
        Write-Output "Moved to Recycle Bin: $($_.FullName)"
    }
    catch {
        Write-Output "Failed: $($_.FullName)"
    }
}
