#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
Write-Host "Downloading AutoInstallerAl3mer Package, Please Wait..." -ForegroundColor Cyan
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
$Url = "https://file.garden/an5JdIrGtwwEoiH6/pro/AutoInstallerAl3mer.cab"
$TargetDir = "$env:USERPROFILE\Downloads\Amer"
$CabDest = "$TargetDir\AutoInstallerAl3mer.cab"
$ExeDest = "$TargetDir\AutoInstallerAl3mer.exe"

if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
Invoke-WebRequest -Uri $Url -OutFile $CabDest
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
if (Test-Path $CabDest) {
    Write-Host "Downloaded Successfully. Extracting CAB Archive..." -ForegroundColor Yellow
    
    # استخراج محتويات ملف الـ CAB إلى المجلد المستهدف
    & expand.exe "$CabDest" -F:* "$TargetDir" | Out-Null
    
    # حذف ملف الـ CAB بعد الاستخراج (اختياري)
    Remove-Item -Path $CabDest -Force -ErrorAction SilentlyContinue

    if (Test-Path $ExeDest) {
        Write-Host "Extracted Successfully." -ForegroundColor Green
        Write-Host "Running: $ExeDest" -ForegroundColor DarkYellow
        Start-Process -FilePath $ExeDest -WorkingDirectory $TargetDir -Verb RunAs
    } else {
        Write-Host "Extraction Failed! Executable not found." -ForegroundColor Red
    }
} else {
    Write-Host "Download Failed! Check connection." -ForegroundColor Red
}
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│