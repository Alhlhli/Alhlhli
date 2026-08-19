#═════════════════════════════════════════════════════════════════════════════════════════════════│
Write-Host "Downloading AutoInstallerAl3mer Package, Please Wait..." -ForegroundColor Cyan
#═════════════════════════════════════════════════════════════════════════════════════════════════│

$Url = "https://file.garden/an5JdIrGtwwEoiH6/pro/AutoInstallerAl3mer.cab"
$TargetDir = "$env:USERPROFILE\Downloads\Amer"
$CabDest = "$TargetDir\AutoInstallerAl3mer.cab"

# إنشاء المجلد في حال عدم وجوده
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

# تحميل الملف
Invoke-WebRequest -Uri $Url -OutFile $CabDest

if (Test-Path $CabDest) {
    Write-Host "Downloaded Successfully. Extracting CAB Archive..." -ForegroundColor Yellow
    
    # فك الضغط
    & expand.exe "$CabDest" -F:* "$TargetDir" | Out-Null
    
    # حذف ملف الـ CAB
    Remove-Item -Path $CabDest -Force -ErrorAction SilentlyContinue

    # البحث عن أي ملف تشغيلي EXE تم استخراجه
    $ExeFile = Get-ChildItem -Path $TargetDir -Filter "*.exe" -Recurse | Select-Object -First 1

    if ($ExeFile) {
        Write-Host "Extracted Successfully." -ForegroundColor Green
        Write-Host "Running: $($ExeFile.FullName)" -ForegroundColor DarkYellow
        Start-Process -FilePath $ExeFile.FullName -WorkingDirectory $ExeFile.DirectoryName -Verb RunAs
    } else {
        Write-Host "Extraction Failed! No executable (.exe) found in archive." -ForegroundColor Red
    }
} else {
    Write-Host "Download Failed! Check connection." -ForegroundColor Red
}
#═════════════════════════════════════════════════════════════════════════════════════════════════│
