# GitHub Actions iOS 建置設定

## 概述
這個工作流程會在 GitHub 的 macOS 環境中自動建置 iOS IPA 檔案，無需本地 Xcode。

## 設定步驟

### 1. 推送程式碼到 GitHub
```bash
git add .
git commit -m "Add GitHub Actions workflow for iOS build"
git push origin main
```

### 2. 設定 GitHub Secrets
在您的 GitHub 專案頁面中：

1. 前往 **Settings** → **Secrets and variables** → **Actions**
2. 點擊 **New repository secret**
3. 新增以下 secret：

#### 必要設定
- **Name**: `DEVELOPMENT_TEAM`
- **Value**: 您的 Apple Developer Team ID（例如：`ABC123DEF4`）

### 3. 觸發建置
建置會在以下情況自動觸發：
- 推送到 `main` 或 `develop` 分支
- 建立 Pull Request
- 手動觸發（在 Actions 頁面點擊 "Run workflow"）

## 建置結果

### 成功建置
- IPA 檔案會作為 Artifact 上傳
- 可在 Actions 頁面下載
- 檔案名稱：`KDSMauiApp-iOS`

### 建置失敗
- 檢查 Actions 頁面的錯誤日誌
- 常見問題：
  - `DEVELOPMENT_TEAM` secret 未設定
  - 專案設定問題
  - 網路連線問題

## 優點

✅ **完全免費**：GitHub Actions 提供免費的 macOS 建置分鐘數
✅ **無需本地 Xcode**：在雲端自動建置
✅ **自動化**：每次推送都會自動建置
✅ **跨平台**：可在任何作業系統上觸發建置

## 限制

⚠️ **簽名限制**：IPA 檔案無法使用正式簽名（需要本地 Xcode）
⚠️ **測試用途**：適合開發測試，不適合 App Store 發布
⚠️ **分鐘數限制**：GitHub 免費帳號每月有建置分鐘數限制

## 下載 IPA

建置完成後：
1. 前往 Actions 頁面
2. 點擊成功的建置
3. 下載 `KDSMauiApp-iOS` artifact
4. 解壓縮取得 `.ipa` 檔案

## 安裝到裝置

1. 使用 AltStore 或其他工具安裝 IPA
2. 在設定中信任開發者憑證
3. 應用程式會載入 `https://kent-test-psi.vercel.app/`
