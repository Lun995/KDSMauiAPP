#!/bin/bash

echo "🐳 使用 Docker 建置 iOS IPA..."

# 建置 Docker 映像
echo "建置 Docker 映像..."
docker build -f Dockerfile.ios -t kdsmaui-ios-builder .

# 運行容器
echo "運行建置容器..."
docker run -d --name kdsmaui-ios-build kdsmaui-ios-builder

# 等待建置完成
echo "等待建置完成..."
sleep 30

# 複製 IPA 檔案
echo "複製 IPA 檔案..."
docker cp kdsmaui-ios-build:/app/bin/Release/net8.0-ios/publish/ ./ios-build-output/

# 檢查結果
if [ -f "./ios-build-output/KDSMauiApp.ipa" ]; then
    echo "✅ IPA 建置成功！"
    echo "檔案位置: ./ios-build-output/KDSMauiApp.ipa"
    ls -lh "./ios-build-output/"
else
    echo "❌ IPA 建置失敗！"
    echo "檢查建置日誌..."
    docker logs kdsmaui-ios-build
fi

# 清理容器
echo "清理 Docker 容器..."
docker stop kdsmaui-ios-build
docker rm kdsmaui-ios-build

echo "完成！"
