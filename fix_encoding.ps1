$letters = @('B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')

foreach($letter in $letters) {
    $letterLower = $letter.ToLower()

    # HTML內容
    $htmlContent = @"
<div class="letter-display-container">
  <div class="big-letter">$letter</div>
  <a routerLink="/home" class="back-btn">回到首頁</a>
</div>
"@

    # 創建HTML文件，使用UTF8編碼
    $htmlPath = "letter-$letterLower\letter-$letterLower.component.html"
    $htmlContent | Out-File -FilePath $htmlPath -Encoding UTF8 -NoNewline

    Write-Host "Fixed encoding for $letter component"
}
