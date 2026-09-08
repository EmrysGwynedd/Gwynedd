# Detection Script - Machine system wide Variable
$variableName = 'CRONFEYDDDATA'
$desiredValue = 'C:\TG\Cronfeydd Data'

$currentValue = [System.Environment]::GetEnvironmentVariable($variableName, 'Machine')

if ($currentValue -ne $desiredValue) {
    Write-Host "Variable $variableName is not set correctly or does not exist."
    exit 1  # Indicates that remediation is needed
} else {
    Write-Host "Variable $variableName is set correctly."
    exit 0  # Indicates no action needed
}