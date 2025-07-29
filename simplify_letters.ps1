$letters = @('B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')

# CSS內容 (所有字母共用)
$cssContent = @"
.letter-display-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 2rem;
}

.big-letter {
  font-size: 20rem;
  font-weight: bold;
  color: white;
  text-shadow: 4px 4px 8px rgba(0, 0, 0, 0.3);
  margin-bottom: 2rem;
  font-family: 'Arial', sans-serif;
}

.back-btn {
  padding: 1rem 2rem;
  background: rgba(255, 255, 255, 0.2);
  color: white;
  text-decoration: none;
  border-radius: 25px;
  font-weight: bold;
  font-size: 1.2rem;
  transition: all 0.3s ease;
  border: 2px solid white;
}

.back-btn:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

@media (max-width: 768px) {
  .big-letter {
    font-size: 12rem;
  }
}

@media (max-width: 480px) {
  .big-letter {
    font-size: 8rem;
  }
}
"@

foreach($letter in $letters) {
    $letterLower = $letter.ToLower()

    # HTML內容
    $htmlContent = @"
<div class="letter-display-container">
  <div class="big-letter">$letter</div>
  <a routerLink="/home" class="back-btn">回到首頁</a>
</div>
"@

    # 創建HTML文件
    $htmlPath = "letter-$letterLower\letter-$letterLower.component.html"
    $htmlContent | Out-File -FilePath $htmlPath -Encoding UTF8

    # 創建CSS文件
    $cssPath = "letter-$letterLower\letter-$letterLower.component.css"
    $cssContent | Out-File -FilePath $cssPath -Encoding UTF8

    Write-Host "Updated $letter component files"
}
