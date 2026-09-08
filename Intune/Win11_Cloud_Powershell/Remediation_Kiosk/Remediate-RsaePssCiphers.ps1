<#

.SYNOPSIS
    PowerShell script to remove RSAE-PSS ciphers.

.EXAMPLE
    .\Remediate-RsaePssCiphers.ps1

.DESCRIPTION
    This PowerShell script is deployed as a remediation script using Proactive Remediations in Microsoft Endpoint Manager/Intune.

    IMPORTANT NOTE: Removing RSAE-PSS ciphers may cause compatibility issues with some applications and services. It may be necessary to target individual devices experincing these issues. Always test thoroughly before deploying this script in a production environment.

.LINK
    https://github.com/richardhicks/endpointmanager/blob/main/Remediate-RsaePssCiphers.ps1

.LINK
    https://directaccess.richardhicks.com/2023/02/13/always-on-vpn-authentication-failed-reason-code-16/

.LINK
    https://docs.microsoft.com/en-us/mem/analytics/proactive-remediations

.LINK
    https://directaccess.richardhicks.com/

.NOTES
    Version:        1.0.2
    Creation Date:  March 24, 2023
    Last Updated:   February 29, 2024
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

Try {

    If ($Functions) {

        Write-Verbose 'Removing RSAE-PSS ciphers...'
        ForEach ($Function in $Functions) {

            If ($Function -NotMatch 'RSAE') {

                [string[]]$NewFunctions += $Function

            }

        }

        Write-Verbose 'Updating registry...'
        Set-ItemProperty $RegPath -Name Functions -Value $NewFunctions -Force

    }

    Else {

        Write-Warning "Unable to read $RegPath."

    }

}

Catch {

    $ErrorMessage = $_.Exception.Message
    Write-Warning $ErrorMessage
    Exit 1

}