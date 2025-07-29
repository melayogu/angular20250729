import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/visual',
  fullyParallel: false, // CI環境避免並行執行
  forbidOnly: true,
  retries: 3, // CI環境增加重試次數
  workers: 1, // CI環境使用單一worker
  reporter: [
    ['html', { outputFolder: 'playwright-report' }],
    ['github'],
    ['junit', { outputFile: 'test-results/junit.xml' }]
  ],
  use: {
    baseURL: 'http://localhost:4200',
    trace: 'retain-on-failure',
    video: 'retain-on-failure',
    screenshot: 'only-on-failure',
    // CI環境額外設定
    actionTimeout: 10000,
    navigationTimeout: 30000,
  },

  projects: [
    {
      name: 'chromium-desktop',
      use: {
        ...devices['Desktop Chrome'],
        // 桌面Chrome專用設定
        viewport: { width: 1280, height: 720 },
        // CI環境特定設定
        launchOptions: {
          args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage']
        }
      },
    },
  ],

  webServer: {
    command: 'npm run start',
    url: 'http://localhost:4200',
    reuseExistingServer: false, // CI環境讓Playwright管理服務器
    timeout: 120 * 1000, // 2分鐘超時
  },

  // CI環境專用配置
  globalSetup: require.resolve('./tests/global-setup.ts'),
});
