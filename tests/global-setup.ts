// tests/global-setup.ts
import { FullConfig } from '@playwright/test';

async function globalSetup(config: FullConfig) {
  console.log('🚀 Starting global setup for CI environment...');

  // CI環境特定的設置
  if (process.env['CI']) {
    console.log('📊 CI environment detected');
    console.log(`Workers: ${config.workers}`);
    console.log(`Projects: ${config.projects?.length || 0}`);
  }

  // 等待服務器準備就緒的額外時間
  if (process.env['CI']) {
    console.log('⏳ Waiting extra time for CI server to be ready...');
    await new Promise(resolve => setTimeout(resolve, 5000));
  }

  console.log('✅ Global setup completed');
}

export default globalSetup;
