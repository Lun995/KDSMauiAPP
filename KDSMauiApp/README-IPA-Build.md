# iOS IPA 建置說明

## 專案概述
這個 MAUI 應用程式是一個 WebView 應用程式，會載入 `https://kent-test-psi.vercel.app/` 網址。

## 建置 IPA 檔案

### 前置需求
1. **macOS 環境**：iOS IPA 建置必須在 macOS 上進行
2. **Xcode**：安裝最新版本的 Xcode
3. **.NET 8.0 SDK**：安裝 .NET 8.0 SDK
4. **MAUI Workload**：安裝 iOS workload
5. **Apple Developer Account**：有效的 Apple Developer 帳號

### 安裝必要工具

```bash
# 安裝 .NET 8.0 SDK
# 從 https://dotnet.microsoft.com/download 下載

# 安裝 MAUI workload
dotnet workload install ios

# 檢查安裝
dotnet workload list
```

### 建置步驟

#### 方法 1：使用腳本（推薦）
```bash
# 在 macOS 上執行
chmod +x build-ios.sh
./build-ios.sh

# 或在 Windows 上執行（需要 WSL 或遠端 macOS）
./build-ios-mac.sh
```

#### 方法 2：手動建置
```bash
# 1. 清理專案
dotnet clean

# 2. 還原套件
dotnet restore

# 3. 建置 iOS 專案
dotnet build -c Release -f net8.0-ios

# 4. 發布 IPA
dotnet publish -c Release -f net8.0-ios -p:RuntimeIdentifier=ios-arm64
```

### 建置輸出
成功建置後，IPA 檔案會位於：
```
bin/Release/net8.0-ios/publish/KDSMauiApp.ipa
```

### 常見問題

#### 1. 簽名問題
如果遇到簽名問題，請檢查：
- `Entitlements.plist` 中的 Team ID 是否正確
- 是否有有效的 Apple Developer 帳號
- Xcode 中的簽名設定

#### 2. 網路權限
應用程式已經設定好網路權限，包括：
- `NSAppTransportSecurity` 允許 HTTP 連線
- 網路使用說明

#### 3. 建置失敗
如果建置失敗：
1. 檢查 .NET 和 MAUI workload 版本
2. 確認 Xcode 版本
3. 檢查專案檔案中的設定

### 部署到裝置
1. 將 IPA 檔案傳輸到 iOS 裝置
2. 使用 AltStore 或其他工具安裝
3. 在設定中信任開發者憑證

### 注意事項
- 這個應用程式是一個 WebView 應用程式
- 需要網路連線才能正常運作
- 建議在真機上測試，模擬器可能有限制
