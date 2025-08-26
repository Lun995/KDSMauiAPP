# iOS 建置腳本 (Windows PowerShell)
Write-Host "開始建置 iOS IPA..." -ForegroundColor Green

# 檢查環境
Write-Host "檢查 .NET 環境..." -ForegroundColor Yellow
dotnet --version

Write-Host "檢查 MAUI workload..." -ForegroundColor Yellow
dotnet workload list | Select-String "ios"

# 清理舊的建置
Write-Host "清理舊的建置..." -ForegroundColor Yellow
dotnet clean

# 還原套件
Write-Host "還原 NuGet 套件..." -ForegroundColor Yellow
dotnet restore

# 建置專案
Write-Host "建置 iOS 專案..." -ForegroundColor Yellow
dotnet build -c Release -f net8.0-ios

# 發布 IPA
Write-Host "發布 iOS IPA..." -ForegroundColor Yellow
dotnet publish -c Release -f net8.0-ios -p:RuntimeIdentifier=ios-arm64

# 檢查結果
$ipaPath = "bin\Release\net8.0-ios\publish\KDSMauiApp.ipa"
if (Test-Path $ipaPath) {
    Write-Host "✅ IPA 建置成功！" -ForegroundColor Green
    Write-Host "檔案位置: $ipaPath" -ForegroundColor Green
    
    $fileInfo = Get-Item $ipaPath
    $fileSize = [math]::Round($fileInfo.Length / 1MB, 2)
    Write-Host "檔案大小: $fileSize MB" -ForegroundColor Green
} else {
    Write-Host "❌ IPA 建置失敗！" -ForegroundColor Red
    Write-Host "請檢查錯誤訊息" -ForegroundColor Red
    exit 1
}
