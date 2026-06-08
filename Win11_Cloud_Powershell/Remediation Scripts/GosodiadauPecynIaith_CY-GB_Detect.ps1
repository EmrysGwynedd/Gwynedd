# Define the app package name
$appPackageName = "Microsoft.LanguageExperiencePackcy-GB"

# Function to check if the app is installed for the current user
function Is-AppInstalled {
    $app = Get-AppxPackage -Name $appPackageName -ErrorAction SilentlyContinue
    return $app -ne $null
}

# Check if the app is installed
Try {    
     if (-not (Is-AppInstalled -appPackageName $appPackageName)) {
         Write-Output "$appPackageName is not installed for the current user."
         Exit 1
     } 
     else 
     {
         Write-Output "$appPackageName is installed for the current user."
         Exit 0
     }

} 

Catch {
    Exit 0
}
