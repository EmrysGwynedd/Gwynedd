# This script will rename Autopilot hybrid joined devices from prefix and random characters to prefix and serial.
# Check if device still equal to Autopilot random name, and if so rename to gwynedd standard (From LAPAZ-********  to  LAPH-*********)

    # Detect if the device name Starts with "LAPAZ-"
    if ($env:COMPUTERNAME -like "LAPAZ-*") {
        Write-Host "Device Needs to be renamed"
        exit 1
    } else {
        Write-Host "Device rename already happened"
        exit 0
    }

