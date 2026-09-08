Add-Type -AssemblyName PresentationFramework

[System.Windows.MessageBox]::Show(
"**NEGES GAN TIM DESG GYMORTH TG** 

Nid yw'r PIN Bitlocker y laptop yma wedi newid ers ei dderbyn gan Tim Desg Gymorth TG.
Mae angen gosod PIN newydd i gadw'r ddyfais yn ddiogel.
Angen iddo fod yn 2 lythyren ac wedyn 6 rhif. Ni all cynnwys aa123456 neu aa111111 ayyb.

Unrhyw broblemau cysylltwch â'r Tim Desg Gymorth TG ar 01286 679 114.

**MESSAGE FROM IT HELP DESK TEAM**

The Bitlocker PIN for this laptop has not changed since you received it from the IT Help Desk Team.
A new PIN needs to be set to keep the equipment secure.
It needs to be 2 letters and then 6 numbers. It cannot aa123456 or aa111111 etc.

Unrhyw broblemau cysylltwch â'r Tim Desg Gymorth TG ar 01286 679 114.",
"ANGEN NEWID PIN BITLOCKER! / NEED TO CHANGE BITLOCKER PIN!",
"OK",
"Information"
)

Start-Process "$env:SystemRoot\System32\bdechangepin.exe"