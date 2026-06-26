Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Uwchraddio Win11 / Win11 Inplace Upgrade"
$form.Size = New-Object System.Drawing.Size(1010, 465)
$form.StartPosition = "CenterScreen"

# Create the label with 11 lines of text
$label = New-Object System.Windows.Forms.Label
$label.Text = @"
Mae'r ddyfais wedi uwchraddio i Windows 11.
Arol mewngofnodi, mae disgwyl oddeutu munud ac yna allgofnodi, ac ail mewngofnodi.
Mae hyn ar gyfer i bolisiau/gosodiadau newydd fewnforio yn gywir.
Arol wneud yr uchod mi fydd y ddyfais yn barod i'w Ddefnyddio.
Unrhyw broblemau cysylltwch efo'r Ddesg Gymorth ar 01286 679 114.

The device has upgraded to Windows 11.
After you have logged in, wait about a minute and then log out, then log back in.
This is for new policies/settings to import correctly.
After doing the above the device will be ready for use.
Any problems contact the Help Desk on 01286 679 114.
"@

$label.Font = New-Object System.Drawing.Font("Arial", 18, [System.Drawing.FontStyle]::Regular)
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20, 20)
$label.TextAlign = 'MiddleCenter'

# Create the OK button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "Oce / OK"
$okButton.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$okButton.Size = New-Object System.Drawing.Size(100, 40)
$okButton.Location = New-Object System.Drawing.Point(465, 350)
$okButton.Add_Click({ $form.Close() })

# Add controls to the form
$form.Controls.Add($label)
$form.Controls.Add($okButton)

# Show the form
$form.ShowDialog()
