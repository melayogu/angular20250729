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

  test('Mona Lisa page should match baseline', async ({ page }) => {
    await page.goto('/mona-lisa');

    // 等待頁面完全載入
    await page.waitForLoadState('networkidle');

    // 等待圖片載入完成
    await page.waitForSelector('.mona-lisa-img');

    // 等待圖片實際載入完成
    await page.evaluate(() => {
      const img = document.querySelector('.mona-lisa-img') as HTMLImageElement;
      if (img && !img.complete) {
        return new Promise((resolve) => {
          img.onload = resolve;
          img.onerror = resolve;
        });
      }
    });

    // 驗證返回按鈕存在
    await expect(page.locator('.back-button')).toBeVisible();

    // 截圖比較
    await expect(page).toHaveScreenshot('mona-lisa-page.png', {
      fullPage: true,
      animations: 'disabled'
    });
  });

  test('Mona Lisa navigation functionality', async ({ page }) => {
    // 測試從主頁導航到蒙娜麗莎頁面再返回
    await page.goto('/home');

    // 點擊蒙娜麗莎連結
    await page.click('a[href="/mona-lisa"]');
    await page.waitForLoadState('networkidle');

    // 驗證在蒙娜麗莎頁面
    await expect(page.locator('.mona-lisa-img')).toBeVisible();

    // 點擊返回按鈕
    await page.click('.back-button');
    await page.waitForLoadState('networkidle');

    // 驗證回到主頁
    await expect(page.locator('h1')).toContainText('English Alphabet Navigation');

    // 截圖記錄蒙娜麗莎導航流程
    await expect(page).toHaveScreenshot('mona-lisa-navigation-back.png', {
      fullPage: true,
      animations: 'disabled'
    });
  });

  // 只針對桌面Chrome進行測試，移除手機和平板版本測試
});
