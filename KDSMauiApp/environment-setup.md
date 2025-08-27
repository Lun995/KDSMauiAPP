# 環境設定說明

## 必要設定

### 1. Apple Developer Team ID
在 `KDSMauiApp.csproj` 中設定您的開發團隊 ID：

```xml
<DevelopmentTeam>YOUR_TEAM_ID</DevelopmentTeam>
```

您可以在以下位置找到您的 Team ID：
- Apple Developer 帳號頁面
- Xcode → Preferences → Accounts → Team ID

### 2. 應用程式識別碼
確保 `KDSMauiApp.csproj` 中的應用程式 ID 是唯一的：

```xml
<ApplicationId>com.yourcompany.kdsmauiapp</ApplicationId>
```

### 3. 簽名設定
在 `Entitlements.plist` 中設定：

```xml
<key>com.apple.developer.team-identifier</key>
<string>$(DEVELOPMENT_TEAM)</string>
```

## 建置前檢查清單

- [ ] 安裝 .NET 8.0 SDK
- [ ] 安裝 MAUI workload (`dotnet workload install ios`)
- [ ] 設定正確的 Team ID
- [ ] 確保有有效的 Apple Developer 帳號
- [ ] 在 macOS 環境中建置（iOS IPA 必須在 macOS 上建置）

## 測試建置

```bash
# 測試建置（不產生 IPA）
dotnet build -c Debug -f net8.0-ios

# 正式建置 IPA
dotnet publish -c Release -f net8.0-ios -p:RuntimeIdentifier=ios-arm64
```
