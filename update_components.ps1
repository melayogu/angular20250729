$letters = @('b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')

foreach($letter in $letters) {
    $filePath = "letter-$letter\letter-$letter.component.ts"
    $letterUpper = $letter.ToUpper()

    $content = @"
import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-letter-$letter',
  imports: [RouterLink],
  templateUrl: './letter-$letter.component.html',
  styleUrl: './letter-$letter.component.css'
})
export class Letter${letterUpper}Component {

}
"@

    $content | Out-File -FilePath $filePath -Encoding UTF8
    Write-Host "Updated $filePath"
}
