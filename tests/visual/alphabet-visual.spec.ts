import { test, expect } from '@playwright/test';

// 所有字母的列表
const letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

test.describe('Visual Regression Tests', () => {

  test('Homepage should match baseline', async ({ page }) => {
    await page.goto('/');

    // 等待頁面完全載入
    await page.waitForLoadState('networkidle');

    // 等待字母按鈕出現
    await page.waitForSelector('.alphabet-grid');

    // 截圖比較
    await expect(page).toHaveScreenshot('homepage.png', {
      fullPage: true,
      animations: 'disabled'
    });
  });

  // 為每個字母頁面創建測試
  for (const letter of letters) {
    test(`Letter ${letter} page should match baseline`, async ({ page }) => {
      await page.goto(`/letter/${letter}`);

      // 等待頁面完全載入
      await page.waitForLoadState('networkidle');

      // 等待大字母元素出現
      await page.waitForSelector('.big-letter');

      // 驗證字母內容正確
      const letterElement = page.locator('.big-letter');
      await expect(letterElement).toHaveText(letter);

      // 截圖比較
      await expect(page).toHaveScreenshot(`letter-${letter.toLowerCase()}.png`, {
        fullPage: true,
        animations: 'disabled'
      });
    });
  }

  test('Navigation functionality', async ({ page }) => {
    // 測試從主頁導航到字母頁面再返回
    await page.goto('/');

    // 點擊字母A
    await page.click('a[href="/letter/A"]');
    await page.waitForLoadState('networkidle');

    // 驗證在字母A頁面
    await expect(page.locator('.big-letter')).toHaveText('A');

    // 點擊返回按鈕
    await page.click('a[href="/home"]');
    await page.waitForLoadState('networkidle');

    // 驗證回到主頁
    await expect(page.locator('h1')).toContainText('English Alphabet Navigation');

    // 截圖記錄導航流程
    await expect(page).toHaveScreenshot('navigation-back-to-home.png', {
      fullPage: true,
      animations: 'disabled'
    });
  });

  test('Responsive design - Mobile viewport', async ({ page }) => {
    // 設定手機視窗大小
    await page.setViewportSize({ width: 375, height: 667 });

    await page.goto('/');
    await page.waitForLoadState('networkidle');

    // 手機版主頁截圖
    await expect(page).toHaveScreenshot('homepage-mobile.png', {
      fullPage: true,
      animations: 'disabled'
    });

    // 測試手機版字母頁面
    await page.goto('/letter/A');
    await page.waitForLoadState('networkidle');

    await expect(page).toHaveScreenshot('letter-a-mobile.png', {
      fullPage: true,
      animations: 'disabled'
    });
  });

  test('Responsive design - Tablet viewport', async ({ page }) => {
    // 設定平板視窗大小
    await page.setViewportSize({ width: 768, height: 1024 });

    await page.goto('/');
    await page.waitForLoadState('networkidle');

    // 平板版主頁截圖
    await expect(page).toHaveScreenshot('homepage-tablet.png', {
      fullPage: true,
      animations: 'disabled'
    });
  });
});
