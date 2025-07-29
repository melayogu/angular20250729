$letters = @(
    @{Letter='D'; Number=4; Words=@('Dog (狗)', 'Door (門)', 'Dance (跳舞)', 'Dream (夢想)')},
    @{Letter='E'; Number=5; Words=@('Elephant (大象)', 'Egg (蛋)', 'Easy (容易的)', 'Enjoy (享受)')},
    @{Letter='F'; Number=6; Words=@('Fish (魚)', 'Fire (火)', 'Friend (朋友)', 'Fun (有趣的)')},
    @{Letter='G'; Number=7; Words=@('Green (綠色)', 'Good (好的)', 'Game (遊戲)', 'Great (很棒的)')},
    @{Letter='H'; Number=8; Words=@('House (房子)', 'Happy (快樂的)', 'Heart (心)', 'Hope (希望)')},
    @{Letter='I'; Number=9; Words=@('Ice (冰)', 'Idea (想法)', 'Important (重要的)', 'Island (島嶼)')},
    @{Letter='J'; Number=10; Words=@('Jump (跳)', 'Joy (快樂)', 'Juice (果汁)', 'Journey (旅程)')},
    @{Letter='K'; Number=11; Words=@('Key (鑰匙)', 'Kind (善良的)', 'Knowledge (知識)', 'Kitchen (廚房)')},
    @{Letter='L'; Number=12; Words=@('Love (愛)', 'Light (光)', 'Learn (學習)', 'Life (生活)')},
    @{Letter='M'; Number=13; Words=@('Moon (月亮)', 'Music (音樂)', 'Mother (母親)', 'Magic (魔法)')},
    @{Letter='N'; Number=14; Words=@('Nature (自然)', 'Nice (好的)', 'Night (夜晚)', 'New (新的)')},
    @{Letter='O'; Number=15; Words=@('Ocean (海洋)', 'Open (打開)', 'Orange (橘子)', 'Over (在...之上)')},
    @{Letter='P'; Number=16; Words=@('Peace (和平)', 'Play (玩)', 'Pretty (漂亮的)', 'Power (力量)')},
    @{Letter='Q'; Number=17; Words=@('Queen (皇后)', 'Quick (快的)', 'Quiet (安靜的)', 'Question (問題)')},
    @{Letter='R'; Number=18; Words=@('Rain (雨)', 'Red (紅色)', 'Run (跑)', 'River (河流)')},
    @{Letter='S'; Number=19; Words=@('Sun (太陽)', 'Smile (微笑)', 'Star (星星)', 'Special (特別的)')},
    @{Letter='T'; Number=20; Words=@('Tree (樹)', 'Time (時間)', 'Travel (旅行)', 'True (真的)')},
    @{Letter='U'; Number=21; Words=@('Under (在...之下)', 'Up (向上)', 'Use (使用)', 'Unity (團結)')},
    @{Letter='V'; Number=22; Words=@('Voice (聲音)', 'View (視野)', 'Victory (勝利)', 'Visit (拜訪)')},
    @{Letter='W'; Number=23; Words=@('Water (水)', 'Wind (風)', 'Wonder (奇蹟)', 'World (世界)')},
    @{Letter='X'; Number=24; Words=@('X-ray (X光)', 'Xylophone (木琴)', 'Extra (額外的)', 'Extreme (極端的)')},
    @{Letter='Y'; Number=25; Words=@('Yellow (黃色)', 'Young (年輕的)', 'Yes (是的)', 'Yesterday (昨天)')},
    @{Letter='Z'; Number=26; Words=@('Zoo (動物園)', 'Zero (零)', 'Zone (區域)', 'Zoom (放大)')}
)

foreach ($letterInfo in $letters) {
    $letter = $letterInfo.Letter
    $number = $letterInfo.Number
    $words = $letterInfo.Words
    $prevLetter = [char]([int][char]$letter - 1)
    $nextLetter = [char]([int][char]$letter + 1)

    $wordsList = ""
    foreach ($word in $words) {
        $wordsList += "        <li>$word</li>`n"
    }

    $prevNav = if ($letter -eq 'D') { "    <a routerLink=`"/letter/C`" class=`"nav-btn`">上一個字母 (C)</a>" } else { "    <a routerLink=`"/letter/$prevLetter`" class=`"nav-btn`">上一個字母 ($prevLetter)</a>" }
    $nextNav = if ($letter -eq 'Z') { "" } else { "    <a routerLink=`"/letter/$nextLetter`" class=`"nav-btn`">下一個字母 ($nextLetter)</a>" }

    $htmlContent = @"
<div class="letter-container">
  <div class="letter-header">
    <h1 class="letter-display">$letter</h1>
    <h2>字母 $letter</h2>
  </div>

  <div class="letter-content">
    <div class="info-card">
      <h3>基本資訊</h3>
      <ul>
        <li>英文字母表中的第 $number 個字母</li>
        <li>大寫：$letter</li>
        <li>小寫：$($letter.ToLower())</li>
        <li>發音：/$($letter.ToLower())iː/</li>
      </ul>
    </div>

    <div class="info-card">
      <h3>常見單字</h3>
      <ul>
$wordsList      </ul>
    </div>
  </div>

  <div class="navigation">
$prevNav
    <a routerLink="/home" class="nav-btn">回到首頁</a>
$nextNav
  </div>
</div>
"@

    $filePath = "letter-$($letter.ToLower())\letter-$($letter.ToLower()).component.html"
    $htmlContent | Out-File -FilePath $filePath -Encoding UTF8
    Write-Host "Created $filePath"
}
