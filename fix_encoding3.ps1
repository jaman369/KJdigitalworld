$dir = "d:\ZAMAN\Ai Folder\Kj Digital World"
$files = Get-ChildItem -Path $dir -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch "node_modules" -and $_.FullName -notmatch "\.git" -and $_.FullName -notmatch "tmp\.html" }

$utf8NoBom = New-Object System.Text.UTF8Encoding $false

# Define replacements using char conversions to avoid ALL string literal/encoding issues!
# U+1F50D = 🔍
$searchEmoji = [char]::ConvertFromUtf32(0x1F50D)
# U+1F3AF = 🎯
$targetEmoji = [char]::ConvertFromUtf32(0x1F3AF)
# U+1F310 = 🌐
$globeEmoji = [char]::ConvertFromUtf32(0x1F310)
# U+270D U+FE0F = ✍️
$writeEmoji = [char]::ConvertFromUtf32(0x270D) + [char]::ConvertFromUtf32(0xFE0F)

# U+2014 = — (em dash)
$emDash = [char]::ConvertFromUtf32(0x2014)
# U+00B7 = · (middle dot)
$midDot = [char]::ConvertFromUtf32(0x00B7)

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $original = $content
    
    # We read as UTF-8. If the file was saved corrupted, it will contain literal strings like 'ðŸ” '
    # The literal corrupted UTF-8 bytes for 🔍 (F0 9F 94 8D) decoded as ANSI:
    # F0 = ð
    # 9F = Ÿ
    # 94 = ”
    # 8D = (invisible soft hyphen or space depending on font)
    
    # It's easier to just match the broken strings and replace them with the correct emojis!
    # Because PowerShell PS1 files might be read as ANSI, I will literally write the byte sequences and convert them to string to match!
    
    $badSearch = [System.Text.Encoding]::GetEncoding(1252).GetString([byte[]](0xF0, 0x9F, 0x94, 0x8D))
    $badTarget = [System.Text.Encoding]::GetEncoding(1252).GetString([byte[]](0xF0, 0x9F, 0x8E, 0xAF))
    $badGlobe = [System.Text.Encoding]::GetEncoding(1252).GetString([byte[]](0xF0, 0x9F, 0x8C, 0x90))
    $badWrite = [System.Text.Encoding]::GetEncoding(1252).GetString([byte[]](0xE2, 0x9C, 0x8D, 0xEF, 0xB8, 0x8F))
    
    $badEmDash = [System.Text.Encoding]::GetEncoding(1252).GetString([byte[]](0xE2, 0x80, 0x94))
    $badMidDot = [System.Text.Encoding]::GetEncoding(1252).GetString([byte[]](0xC2, 0xB7))
    
    $content = $content.Replace($badSearch, $searchEmoji)
    $content = $content.Replace($badTarget, $targetEmoji)
    $content = $content.Replace($badGlobe, $globeEmoji)
    $content = $content.Replace($badWrite, $writeEmoji)
    
    $content = $content.Replace($badEmDash, $emDash)
    $content = $content.Replace($badMidDot, $midDot)
    
    $content = $content.Replace("Portfolio \?`" Digital World A Kamrujjaman", "Portfolio — Digital World · Kamrujjaman")
    
    if ($content -cne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Output "Fixed encoding in $($file.Name)"
    }
}
