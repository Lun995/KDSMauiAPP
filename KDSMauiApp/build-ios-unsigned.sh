#!/bin/bash

# iOS 未簽名版本建置腳本
echo "開始建置 iOS 未簽名版本 IPA..."

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

# 建置專案（Debug 模式，未簽名）
echo "建置 iOS 專案（Debug 模式，未簽名）..."
dotnet build -c Debug -f net8.0-ios -p:MtouchUseCodeSigning=false

# 發布未簽名 IPA
echo "發布未簽名 iOS IPA..."
dotnet publish -c Debug -f net8.0-ios -p:RuntimeIdentifier=ios-arm64 -p:MtouchUseCodeSigning=false

# 檢查結果
if [ -f "bin/Debug/net8.0-ios/publish/KDSMauiApp.ipa" ]; then
    echo "✅ 未簽名 IPA 建置成功！"
    echo "檔案位置: bin/Debug/net8.0-ios/publish/KDSMauiApp.ipa"
    echo ""
    echo "📁 檢查檔案："
    ls -la "bin/Debug/net8.0-ios/publish/"
    echo ""
    echo "📊 檔案資訊："
    file "bin/Debug/net8.0-ios/publish/KDSMauiApp.ipa"
    echo ""
    echo "⚠️  注意事項："
    echo "- 這是未簽名版本，僅限於測試用途"
    echo "- 無法安裝到真機上"
    echo "- 可以在 iOS 模擬器上運行"
    echo "- 不適合分發到 App Store"
    echo ""
    echo "📱 下一步選擇："
    echo "1. 在 Xcode 中設定簽名（可以安裝到真機）"
    echo "2. 使用 GitHub Actions 雲端建置（完全免費）"
    echo "3. 繼續使用未簽名版本（僅測試用）"
else
    echo "❌ IPA 建置失敗！"
    echo ""
    echo "🔍 故障排除："
    echo "1. 確認 Xcode 已正確安裝"
    echo "2. 確認 iOS workload 已安裝"
    echo "3. 檢查專案設定"
    exit 1
fi
