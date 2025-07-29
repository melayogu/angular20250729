$letters = @('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')

foreach($letter in $letters) {
    $letterLower = $letter.ToLower()

    # HTML內容，使用英文避免編碼問題
    $htmlContent = @"
<div class="letter-display-container">
  <div class="big-letter">$letter</div>
  <a routerLink="/home" class="back-btn">Back to Home</a>
</div>
"@

    # 重新創建HTML文件
    $htmlPath = "letter-$letterLower\letter-$letterLower.component.html"
    $htmlContent | Out-File -FilePath $htmlPath -Encoding ASCII

    Write-Host "Updated $letter component with English text"
}
