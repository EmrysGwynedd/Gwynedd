# Script to install Welsh language pack with features.


# Create folder for Lof Files
If(!(test-path -PathType container C:\TG\Logs))
 {New-Item -ItemType Directory -Path C:\TG\Logs}


# Start the transcript and specify the log file path
Start-Transcript -Path "C:\TG\Logs\Set_Welsh_Language.log" -Force


#  Install and Set Welsh Language to Default 

Install-Language -Language cy-GB -CopyToSettings -Verbose -ErrorAction SilentlyContinue
Set-SystemPreferredUILanguage -Language cy -ErrorAction SilentlyContinue
Set-PreferredLanguage -Language cy -ErrorAction SilentlyContinue

# Stop the transcript
Stop-Transcript -WarningAction SilentlyContinue
Exit 0
