Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "VPN Upgrade Notice"
$form.Width = 800
$form.Height = 250
$form.StartPosition = "CenterScreen"
$form.TopMost = $true

$label = New-Object System.Windows.Forms.Label
$label.AutoSize = $false
$label.Dock = "Fill"
$label.TextAlign = "MiddleCenter"
$label.Font = New-Object System.Drawing.Font("Segoe UI",18,[System.Drawing.FontStyle]::Bold)
$label.Text = "Peidiwch Cyffwrdd!`r`n`r`nMae'r VPN yn uwchraddio nawr."

$form.Controls.Add($label)

$form.Activate()
$form.ShowDialog()