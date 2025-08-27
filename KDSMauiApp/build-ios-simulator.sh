#!/bin/bash

# iOS 模擬器版本建置腳本
echo "開始建置 iOS 模擬器版本..."

# 檢查環境
echo "檢查 .NET 環境..."
dotnet --version

echo "檢查 MAUI workload..."
dotnet workload list | grep ios

echo "檢查 Xcode 路徑..."
xcode-select -p

# 清理舊的建置
echo "清理舊的建置..."
dotnet clean

# 還原套件
echo "還原 NuGet 套件..."
dotnet restore

# 建置專案（模擬器目標）
echo "建置 iOS 專案（模擬器目標）..."
dotnet build -c Debug -f net8.0-ios -p:MtouchSimulator=true -p:MtouchUseCodeSigning=false

# 檢查建置結果
if [ -d "bin/Debug/net8.0-ios/ios-arm64/KDSMauiApp.app" ]; then
    echo "✅ iOS 應用程式建置成功！"
    echo "應用程式位置: bin/Debug/net8.0-ios/ios-arm64/KDSMauiApp.app"
    echo ""
    echo "📁 檢查檔案："
    ls -la "bin/Debug/net8.0-ios/ios-arm64/"
    echo ""
    echo "📱 下一步："
    echo "1. 在 Xcode 中打開 .app 檔案"
    echo "2. 使用 iOS 模擬器運行"
    echo "3. 或者使用 GitHub Actions 建置 IPA"
else
    echo "❌ 應用程式建置失敗！"
    echo ""
    echo "🔍 建議解決方案："
    echo "1. 使用 GitHub Actions 雲端建置（推薦）"
    echo "2. 在 Xcode 中設定簽名"
    echo "3. 檢查專案設定"
    exit 1
fi
