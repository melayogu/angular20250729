#!/usr/bin/env pwsh

# Visual Regression Test Helper Script
# 這個腳本幫助處理本地和CI環境的測試運行

Write-Host "🎭 Visual Regression Test Helper" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green
Write-Host ""

# 檢查是否有Node.js進程正在運行
$nodeProcesses = Get-Process -Name node -ErrorAction SilentlyContinue
if ($nodeProcesses) {
    Write-Host "⚠️  檢測到正在運行的Node.js進程" -ForegroundColor Yellow
    Write-Host "   進程數量: $($nodeProcesses.Count)" -ForegroundColor Yellow
    
    $response = Read-Host "是否要停止這些進程? (y/N)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        $nodeProcesses | Stop-Process -Force
        Write-Host "✅ 已停止Node.js進程" -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
}

# 選擇測試模式
Write-Host "請選擇測試模式:" -ForegroundColor Cyan
Write-Host "1. 本地開發模式 (預設)" -ForegroundColor White
Write-Host "2. CI模式" -ForegroundColor White
Write-Host "3. 更新baseline" -ForegroundColor White
Write-Host "4. UI模式" -ForegroundColor White
Write-Host ""

$choice = Read-Host "請輸入選擇 [1-4] (預設: 1)"

switch ($choice) {
    "2" {
        Write-Host "🚀 運行CI模式測試..." -ForegroundColor Blue
        $env:CI = "true"
        npx playwright test --config=playwright.config.ci.ts
    }
    "3" {
        Write-Host "📸 更新baseline截圖..." -ForegroundColor Blue
        npx playwright test --update-snapshots
    }
    "4" {
        Write-Host "🎨 啟動UI模式..." -ForegroundColor Blue
        npx playwright test --ui
    }
    default {
        Write-Host "🏠 運行本地開發模式測試..." -ForegroundColor Blue
        npx playwright test
    }
}

Write-Host ""
Write-Host "✨ 測試完成!" -ForegroundColor Green
