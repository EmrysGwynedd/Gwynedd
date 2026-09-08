# Remediation Script
$variableName = 'CRONFEYDDDATA'
$desiredValue = 'C:\TG\Cronfeydd Data'

$currentValue = [System.Environment]::GetEnvironmentVariable($variableName, 'Machine')

if ($currentValue -ne $desiredValue) {
    [System.Environment]::SetEnvironmentVariable($variableName, $desiredValue, 'Machine')
    Write-Host "Variable $variableName has been set to $desiredValue."
} else {
    Write-Host "Variable $variableName is already set correctly."
}