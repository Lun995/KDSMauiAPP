# GitHub Actions iOS IPA 建置完整步驟

## 概述
這個文件包含使用 GitHub Actions 自動建置 iOS IPA 檔案的完整步驟。所有步驟都是文字說明，您需要手動執行。

## 第一階段：推送程式碼到 GitHub

### 步驟 1：檢查 git 狀態
在終端機中執行以下指令，確認有哪些檔案需要提交：
```bash
git status
```

### 步驟 2：提交所有更改
執行以下指令，將所有修改過的檔案提交到本地倉庫：
```bash
git add .
git commit -m "Add iOS build scripts and update project configuration for GitHub Actions"
```

### 步驟 3：推送到 GitHub
執行以下指令，將程式碼推送到 GitHub 倉庫：
```bash
git push -u origin main
```

**注意**：如果這是第一次推送，系統可能會要求您輸入 GitHub 的用戶名和密碼（或 Personal Access Token）。

## 第二階段：GitHub Actions 自動建置

### 步驟 4：查看建置狀態
推送完成後，前往您的 GitHub 倉庫：
1. 打開瀏覽器，前往：https://github.com/Lun995/KDSMauiAPP
2. 點擊 "Actions" 標籤
3. 您會看到一個正在運行的建置任務

### 步驟 5：等待建置完成
建置過程通常需要 5-10 分鐘，包括：
- 設定 macOS 環境
- 安裝 .NET 8.0
- 安裝 MAUI workload
- 建置 iOS 專案
- 生成 IPA 檔案

### 步驟 6：下載 IPA 檔案
建置成功後：
1. 點擊成功的建置任務
2. 向下滾動到 "Artifacts" 部分
3. 點擊 "KDSMauiApp-iOS" 下載 IPA 檔案

## 第三階段：安裝到 iPad

### 步驟 7：準備安裝工具
您需要以下工具之一來安裝 IPA：
- **AltStore**（推薦，免費）
- **3uTools**（免費）
- **iTunes**（需要電腦）

### 步驟 8：安裝 AltStore（推薦方法）
1. 在 iPad 上打開 Safari
2. 前往：https://altstore.io
3. 下載並安裝 AltStore
4. 在設定中信任開發者憑證

### 步驟 9：安裝您的應用程式
1. 將 IPA 檔案傳輸到 iPad
2. 使用 AltStore 打開 IPA 檔案
3. 按照提示完成安裝
4. 在設定中信任開發者憑證

## 重要注意事項

### 免費開發者帳號限制
- IPA 檔案有效期為 7 天
- 7 天後需要重新建置和安裝
- 僅限於個人使用，不能分發

### 長期使用策略
- 每週重新建置一次 IPA
- 使用 GitHub Actions 自動化流程
- 保存建置好的 IPA 檔案

### 故障排除
如果建置失敗：
1. 檢查 Actions 頁面的錯誤日誌
2. 確認專案設定正確
3. 檢查是否有語法錯誤

## 優勢總結

使用 GitHub Actions 的優點：
✅ **完全免費** - 不需要付費的 Apple Developer 帳號
✅ **自動化** - 每次推送都會自動建置
✅ **雲端建置** - 不需要本地 Xcode 設定
✅ **即時可用** - 設定完成後立即開始建置
✅ **跨平台** - 可在任何作業系統上觸發建置

## 下一步

完成上述步驟後，您就可以：
1. 在 iPad 上安裝您的應用程式
2. 測試應用程式功能
3. 享受免費的 iOS 開發體驗

如果遇到任何問題，請檢查 GitHub Actions 的錯誤日誌，或者參考專案中的 README 文件。
