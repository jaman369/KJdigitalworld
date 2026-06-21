$dir = "d:\ZAMAN\Ai Folder\Kj Digital World"
$files = Get-ChildItem -Path $dir -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch "node_modules" -and $_.FullName -notmatch "\.git" -and $_.FullName -notmatch "tmp\.html" }

$utf8NoBom = New-Object System.Text.UTF8Encoding $false

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $original = $content
    
    # 1. Exact string matches for corrupted navigation emojis
    $content = $content -replace '<h4>dY"\? SEO</h4>', '<h4>🔍 SEO</h4>'
    $content = $content -replace '<h4>dYZ_ PPC / Paid Ads</h4>', '<h4>🎯 PPC / Paid Ads</h4>'
    $content = $content -replace '<h4>dYO\? Web Design &amp; Dev</h4>', '<h4>🌐 Web Design &amp; Dev</h4>'
    $content = $content -replace '<h4>o\?,\? Content &amp; More</h4>', '<h4>✍️ Content &amp; More</h4>'
    
    $content = $content -replace '<h4>ðŸ”  SEO</h4>', '<h4>🔍 SEO</h4>'
    $content = $content -replace '<h4>ðŸŽ¯ PPC / Paid Ads</h4>', '<h4>🎯 PPC / Paid Ads</h4>'
    $content = $content -replace '<h4>ðŸŒ  Web Design &amp; Dev</h4>', '<h4>🌐 Web Design &amp; Dev</h4>'
    $content = $content -replace '<h4>âœ ï¸  Content &amp; More</h4>', '<h4>✍️ Content &amp; More</h4>'
    
    # Also in project cards
    $content = $content -replace '>dY"\?</div>', '>🔍</div>'
    $content = $content -replace '>o\?,\?</div>', '>✍️</div>'
    
    # 2. Corrupted meta titles
    $content = $content -replace 'Digital World A Kamrujjaman', 'Digital World | Kamrujjaman'
    $content = $content -replace 'Blog \?" Digital World', 'Blog - Digital World'
    $content = $content -replace 'Portfolio \?" Digital World', 'Portfolio - Digital World'
    
    # 3. Specific fix for href="#" in project cards
    $content = $content -replace '<a href="#" class="project-card">\s*<div class="project-visual"[^>]*>.*?</div>\s*<div class="project-body">\s*<div class="project-cat">SEO</div>', '<a href="/posts/seo-case-study" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #020610, #04091a); color: #fff;">🔍</div>
        <div class="project-body">
          <div class="project-cat">SEO</div>'
          
    $content = $content -replace '<a href="#" class="project-card">\s*<div class="project-visual"[^>]*>.*?</div>\s*<div class="project-body">\s*<div class="project-cat">Content Marketing</div>', '<a href="/posts/shopify-cro-case-study" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #1a0a00, #331800); color: #fff;">✍️</div>
        <div class="project-body">
          <div class="project-cat">Content Marketing</div>'
    
    if ($content -cne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Output "Fixed corruption in $($file.Name)"
    }
}
