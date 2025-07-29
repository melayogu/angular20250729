# Visual Regression Testing with GitHub CI

這個專案已經設置了完整的視覺回歸測試和GitHub CI整合。

## 🚀 本地測試命令

```bash
# 運行視覺回歸測試
npm run test:visual

# 在UI模式下運行測試
npm run test:visual:ui

# 更新所有baseline截圖
npm run test:visual:update

# 以headed模式運行測試（可看到瀏覽器）
npm run test:visual:headed

# CI模式運行測試
npm run test:visual:ci
```

## 🔄 GitHub CI 整合

### 自動觸發
CI會在以下情況自動運行：
- Push到`main`或`master`分支
- 對`main`或`master`分支的Pull Request

### CI工作流程
1. **環境設置** - Node.js 18 + Playwright
2. **依賴安裝** - npm ci + Playwright browsers
3. **應用建置** - Angular build
4. **服務器啟動** - 開發服務器
5. **視覺測試** - 運行所有視覺回歸測試
6. **結果上傳** - 失敗時上傳測試結果和diff截圖

### CI失敗處理
當視覺測試失敗時：
- 📸 **自動上傳diff截圖**到Artifacts
- 💬 **PR自動評論**說明失敗原因
- 📊 **詳細測試報告**可在Actions中查看

## 📸 Baseline管理

### 更新Baseline
如果UI變更是預期的：
```bash
# 更新所有baseline
npm run test:visual:update

# 更新特定測試的baseline
npx playwright test --update-snapshots tests/visual/alphabet-visual.spec.ts
```

### 審查變更
1. 在GitHub Actions中查看上傳的diff截圖
2. 確認變更是否符合預期
3. 本地運行更新命令
4. 提交新的baseline截圖

## 🔧 配置文件

- **本地開發**: `playwright.config.ts`
- **CI環境**: `playwright.config.ci.ts`
- **全局設置**: `tests/global-setup.ts`
- **CI工作流**: `.github/workflows/visual-regression.yml`

## 📊 測試覆蓋範圍

目前測試包含（僅限桌面Chrome）：
- ✅ **首頁截圖** (1個測試)
- ✅ **26個字母頁面** (26個測試)  
- ✅ **導航功能** (1個測試)

**總計**: 28個視覺回歸測試（移除響應式測試以專注於桌面Chrome）

## 🎯 最佳實踐

### PR工作流程
1. 創建功能分支
2. 進行UI變更
3. 本地運行視覺測試
4. 如需要，更新baseline
5. 提交變更並推送
6. 創建PR，CI自動運行
7. 審查CI結果和diff截圖
8. 合併到主分支

### 故障排除
- **測試超時**: 檢查服務器是否正常啟動
- **截圖差異**: 確認是否為預期變更
- **CI失敗**: 查看Actions日誌和上傳的Artifacts

### 性能優化
- CI使用單一worker避免資源競爭
- 增加重試次數提高穩定性
- 僅在失敗時保留screenshots和videos
