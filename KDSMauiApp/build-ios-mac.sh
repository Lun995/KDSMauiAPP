#!/bin/bash

echo "開始建置 iOS IPA..."

# 檢查環境
echo "檢查 .NET 環境..."
dotnet --version

echo "檢查 MAUI workload..."
dotnet workload list | grep ios

# 清理舊的建置
echo "清理舊的建置..."
dotnet clean

# 還原套件
echo "還原 NuGet 套件..."
dotnet restore

# 建置專案
echo "建置 iOS 專案..."
dotnet build -c Release -f net8.0-ios

# 發布 IPA
echo "發布 iOS IPA..."
dotnet publish -c Release -f net8.0-ios -p:RuntimeIdentifier=ios-arm64

# 檢查結果
if [ -f "bin/Release/net8.0-ios/publish/KDSMauiApp.ipa" ]; then
    echo "✅ IPA 建置成功！"
    echo "檔案位置: bin/Release/net8.0-ios/publish/KDSMauiApp.ipa"
    echo "檔案大小: $(ls -lh bin/Release/net8.0-ios/publish/KDSMauiApp.ipa | awk '{print $5}')"
else
    echo "❌ IPA 建置失敗！"
    echo "請檢查錯誤訊息"
    exit 1
fi
