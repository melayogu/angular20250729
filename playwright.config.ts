import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/visual',
  fullyParallel: true,
  forbidOnly: !!process.env['CI'],
  retries: process.env['CI'] ? 2 : 0,
  workers: process.env['CI'] ? 1 : undefined,
  reporter: process.env['CI'] ? [['html'], ['github']] : 'html',
  use: {
    baseURL: 'http://localhost:4200',
    trace: 'on-first-retry',
    // CI環境優化設定
    video: process.env['CI'] ? 'retain-on-failure' : 'off',
    screenshot: 'only-on-failure',
  },

  projects: [
    {
      name: 'chromium-desktop',
      use: {
        ...devices['Desktop Chrome'],
        // 桌面Chrome專用設定
        viewport: { width: 1280, height: 720 }
      },
    },
  ],

  webServer: {
    command: 'npm run start',
    url: 'http://localhost:4200',
    reuseExistingServer: !process.env['CI'],
  },
});
