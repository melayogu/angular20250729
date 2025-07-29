# 🔧 Visual Regression Testing 故障排除指南

## 常見問題及解決方案

### 1. 端口4200已被占用錯誤
```
Error: http://localhost:4200 is already used
```

**解決方案:**
```powershell
# 停止所有Node.js進程
Get-Process -Name node -ErrorAction SilentlyContinue | Stop-Process -Force

# 或者使用我們的輔助腳本
.\run-visual-tests.ps1
```

### 2. CI配置vs本地配置混淆

**本地開發:**
```bash
npm run test:visual          # 使用本地配置
```

**CI環境測試:**
```bash
npm run test:visual:ci       # 使用CI配置
```

### 3. Baseline截圖不匹配

**更新所有baseline:**
```bash
npm run test:visual:update
```

**只更新特定測試:**
```bash
npx playwright test tests/visual/alphabet-visual.spec.ts --update-snapshots
```

### 4. 測試在CI中失敗但本地通過

**可能原因:**
- 字體渲染差異（Linux vs Windows）
- 瀏覽器版本差異
- 屏幕分辨率差異

**解決方案:**
1. 本地使用CI配置測試:
```bash
$env:CI="true"; npx playwright test --config=playwright.config.ci.ts
```

2. 檢查CI上傳的diff截圖
3. 如果差異可接受，在CI環境中更新baseline

### 5. 測試執行時間過長

**優化建議:**
- 已經移除響應式測試，專注桌面Chrome
- 使用單worker避免資源競爭
- 確保沒有其他應用占用系統資源

### 6. Angular服務器啟動失敗

**檢查步驟:**
1. 確認依賴已安裝: `npm ci`
2. 檢查Angular配置: `ng version`
3. 手動啟動測試: `ng serve`

### 7. Playwright瀏覽器安裝問題

**重新安裝瀏覽器:**
```bash
npx playwright install chromium --with-deps
```

## 🚀 快速診斷腳本

使用我們提供的診斷腳本:
```powershell
.\run-visual-tests.ps1
```

該腳本會:
- 檢查運行中的Node.js進程
- 提供測試模式選擇
- 自動處理常見問題

## 📞 進階除錯

### 查看詳細日誌:
```bash
npx playwright test --reporter=list --verbose
```

### 保存失敗截圖:
```bash
npx playwright test --reporter=html
npx playwright show-report
```

### 查看測試追蹤:
```bash
npx playwright show-trace test-results/[失敗的測試目錄]/trace.zip
```
