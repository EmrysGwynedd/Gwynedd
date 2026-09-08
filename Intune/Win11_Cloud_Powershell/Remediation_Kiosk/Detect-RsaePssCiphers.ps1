<#

.SYNOPSIS
    PowerShell script to detect RSAE-PSS ciphers.

.EXAMPLE
    .\Detect-RsaePssCiphers.ps1

.DESCRIPTION
    This PowerShell script is deployed as a detection script using Proactive Remediations in Microsoft Endpoint Manager/Intune.

.LINK
    https://github.com/richardhicks/endpointmanager/blob/main/Detect-RsaePssCiphers.ps1

.LINK
    https://directaccess.richardhicks.com/2023/02/13/always-on-vpn-authentication-failed-reason-code-16/

.LINK
    https://docs.microsoft.com/en-us/mem/analytics/proactive-remediations

.LINK
    https://directaccess.richardhicks.com/

.NOTES
    Version:        1.0.1
    Creation Date:  March 24, 2023
    Last Updated:   February 7, 2024
    Author:         Richard Hicks
    Organization:   Richard M. Hicks Consulting, Inc.
    Contact:        rich@richardhicks.com
    Website:        https://directaccess.richardhicks.com/

#>

[CmdletBinding()]

Param (

)

$RegPath = 'HKLM:SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010003\'
[string[]]$Functions = Get-ItemPropertyValue $RegPath -Name Functions -ErrorAction SilentlyContinue

If (-not ($Functions)) {

    Write-Warning 'Unable to read $RegPath.'
    Exit 1

}

Try {

    If ($Functions -Match 'RSAE') {

        Write-Verbose 'RSAE-PSS ciphers detected. Remediation required.'
        Exit 1

    }

    Else {

        Write-Verbose 'RSAE-PSS ciphers not detected. No remediation required.'
        Exit 0

    }

}

Catch {

    $ErrorMessage = $_.Exception.Message
    Write-Warning $ErrorMessage
    Exit 1

}