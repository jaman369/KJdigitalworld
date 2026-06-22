$files = Get-ChildItem -Filter *.html

foreach ($file in $files) {
    if ($file.Name -match "^(temp|tmp|lovable_contact|blog)\.html$") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    # 1. Update text colors to black
    if ($content -match '\.stat-num span \{ color: #0071e3;') {
        $content = $content -replace '\.stat-num span \{ color: #0071e3;', '.stat-num span { color: #000;'
        $modified = $true
    }
    
    if ($content -match '\.stat-label \{ font-size: 13px; color: #666;') {
        $content = $content -replace '\.stat-label \{ font-size: 13px; color: #666;', '.stat-label { font-size: 13px; color: #000;'
        $modified = $true
    }

    # 2. Fix the literal newline string bug in index.html
    if ($content -match '`n') {
        $content = $content.Replace("``n", "`n")
        $modified = $true
    }

    if ($modified) {
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Updated $($file.Name)"
    }
}
