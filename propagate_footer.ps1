$dir = "d:\ZAMAN\Ai Folder\Kj Digital World"
$files = Get-ChildItem -Path $dir -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch "node_modules" -and $_.FullName -notmatch "\.git" -and $_.FullName -notmatch "tmp\.html" }

$aboutContent = [System.IO.File]::ReadAllText("$dir\about.html", [System.Text.Encoding]::UTF8)

# Extract footer
if ($aboutContent -match '(?s)(<footer>.*?</footer>)') {
    $perfectFooter = $matches[1]
    
    # Replace the footer flags block in the perfect footer
    $newFlagsHtml = '<div class="footer-flags">
  <img src="https://flagcdn.com/w20/us.png" srcset="https://flagcdn.com/w40/us.png 2x" alt="US" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/gb.png" srcset="https://flagcdn.com/w40/gb.png 2x" alt="UK" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/ca.png" srcset="https://flagcdn.com/w40/ca.png 2x" alt="CA" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/au.png" srcset="https://flagcdn.com/w40/au.png 2x" alt="AU" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/ie.png" srcset="https://flagcdn.com/w40/ie.png 2x" alt="IE" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/ae.png" srcset="https://flagcdn.com/w40/ae.png 2x" alt="AE" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/za.png" srcset="https://flagcdn.com/w40/za.png 2x" alt="ZA" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/de.png" srcset="https://flagcdn.com/w40/de.png 2x" alt="DE" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/nl.png" srcset="https://flagcdn.com/w40/nl.png 2x" alt="NL" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/nz.png" srcset="https://flagcdn.com/w40/nz.png 2x" alt="NZ" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
  <img src="https://flagcdn.com/w20/bd.png" srcset="https://flagcdn.com/w40/bd.png 2x" alt="BD" style="width:20px;height:auto;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
</div>'
    
    $perfectFooter = $perfectFooter -replace '(?s)<div class="footer-flags">.*?</div>', $newFlagsHtml
    
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    $count = 0
    foreach ($file in $files) {
        $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        
        if ($content -match '(?s)(<footer>.*?</footer>)') {
            $newContent = $content -replace '(?s)(<footer>.*?</footer>)', $perfectFooter
            if ($newContent -cne $content) {
                [System.IO.File]::WriteAllText($file.FullName, $newContent, $utf8NoBom)
                $count++
            }
        }
    }
    Write-Output "Updated footer in $count files."
} else {
    Write-Output "Could not extract footer from about.html"
}
