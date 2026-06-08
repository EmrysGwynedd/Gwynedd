$folderPath = "C:\TG\Splash_Kiosk"
$filePath   = Join-Path $folderPath "splash.html"
$imagePath  = Join-Path $folderPath "lock_kiosk.png"

# Create folder if missing
if (-not (Test-Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory -Force | Out-Null
}

# HTML content
$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Gwefannau Hunain Wasanaeth</title>

<style>
    body {
        background-color: #2e7d32;
        color: white;
        font-family: Arial, sans-serif;
        text-align: center;
        padding-top: 40px;
        margin: 0;
    }

    img {
        max-width: 300px;
        margin-bottom: 25px;
    }

    a {
        display: block;
        margin: 20px auto;
        font-size: 20px;
        color: white;
        text-decoration: none;
        border: 2px solid white;
        padding: 15px;
        width: 320px;
        border-radius: 8px;
    }

    a:hover {
        background-color: white;
        color: #2e7d32;
    }

    /* Bottom date/time bar */
    #datetime {
        position: fixed;
        bottom: 0;
        width: 100%;
        padding: 12px 0;
        background: rgba(0,0,0,0.3);
        font-size: 22px;
        font-weight: bold;
    }
</style>

<script>
function updateDateTime() {
    const now = new Date();

    // Time with seconds
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');

    // Welsh names
    const days = [
        "Dydd Sul", "Dydd Llun", "Dydd Mawrth",
        "Dydd Mercher", "Dydd Iau", "Dydd Gwener", "Dydd Sadwrn"
    ];

    const months = [
        "Ionawr", "Chwefror", "Mawrth", "Ebrill", "Mai", "Mehefin",
        "Gorffennaf", "Awst", "Medi", "Hydref", "Tachwedd", "Rhagfyr"
    ];

    const dayName = days[now.getDay()];
    const day = now.getDate();
    const month = months[now.getMonth()];
    const year = now.getFullYear();

    const output = hours + ":" + minutes + ":" + seconds + " | " + dayName + " " + day + " " + month + " " + year;

    document.getElementById("datetime").textContent = output;
}

setInterval(updateDateTime, 1000);
</script>

</head>

<body onload="updateDateTime()">

<img src="https://www.gwynedd.llyw.cymru/SiteElements/Images/LogoCwcis.png" alt="Gwynedd Logo">

<h1>Gwefannau Hunain Wasanaeth</h1>

<a href="https://porthstaff.gwynedd.llyw.cymru" target="_blank">Porth Staff</a>
<a href="https://gwynedd.learningpool.com/" target="_blank">E-Ddysgu</a>
<a href="https://www.gwynedd.llyw.cymru/" target="_blank">Gwe</a>

<div id="datetime"></div>

</body>
</html>
"@

# Write HTML
Set-Content -Path $filePath -Value $htmlContent -Encoding UTF8

# Download lockscreen image if missing
if (-not (Test-Path $imagePath)) {
    try {
        Invoke-WebRequest "https://systemau.cyngor.gwynedd.llyw.cymru/Desgfwrdd/Teams/019e036d-a811-4280-96c6-c2cebc552939.png" `
            -OutFile $imagePath `
            -UseDefaultCredentials
    }
    catch {
        Write-Output "Image download failed"
    }
}

Write-Output "Remediation completed"
exit 0