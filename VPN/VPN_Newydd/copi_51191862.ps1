#Copy New version
$source = "\\gwynedd.rhwydwaith\Desgfwrdd\VPN\Cisco_51191862"
$dest   = "C:\TG\Cisco_51191862"

# Ensure destination root exists
New-Item -ItemType Directory -Path $dest -Force | Out-Null

# Copy everything, including empty directories
Copy-Item -Path $source\* -Destination $dest -Recurse -Container -Force