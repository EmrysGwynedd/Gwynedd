# Define the version prefix to look for
$targetVersionPrefix = "23."

# Get installed Citrix Workspace products
$citrix = Get-WmiObject -Class Win32_Product | Where-Object {
    $_.Name -like "Citrix Workspace*" -and $_.Version -like "$targetVersionPrefix*"
}

# If found, run the executable with switches
if ($citrix) {
    Write-Output "Citrix Workspace version 23 detected: $($citrix.Version)"
    
    # Define the path to your executable and the arguments
    $exePath = "\\me-dtcentral\DCSWRepository\Citrix Workspace App\Citrix Workspace App\CitrixWorkspaceApp.exe"
    $arguments = "/silent /uninstall"

    # Run the executable
    Start-Process -FilePath $exePath -ArgumentList $arguments -Wait
} else {
    Write-Output "Citrix Workspace version 23 not found."
}