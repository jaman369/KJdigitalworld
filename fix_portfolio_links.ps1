$dir = "d:\ZAMAN\Ai Folder\Kj Digital World"
$files = Get-ChildItem -Path $dir -Recurse -Filter "portfolio*.html"

$utf8NoBom = New-Object System.Text.UTF8Encoding $false

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $original = $content
    
    # 1. Replace the first empty link
    # Find the line that has href="#" right above "B2B SaaS SEO Strategy"
    # Actually, we can just replace all <a href="#" class="project-card"> and fix them manually if needed, 
    # but there are exactly two. We'll do a simple regex that only catches them if they are followed by the exact title.
    
    $content = [regex]::Replace($content, '(?s)<a href="#" class="project-card">(?=\s*<div class="project-visual"[^>]*>.*?</div>\s*<div class="project-body">\s*<div class="project-cat">SEO</div>\s*<h3 class="project-title">B2B SaaS SEO Strategy)', '<a href="/posts/seo-case-study" class="project-card">')
    
    $content = [regex]::Replace($content, '(?s)<a href="#" class="project-card">(?=\s*<div class="project-visual"[^>]*>.*?</div>\s*<div class="project-body">\s*<div class="project-cat">Content Marketing</div>\s*<h3 class="project-title">E-commerce Content Strategy)', '<a href="/posts/shopify-cro-case-study" class="project-card">')

    if ($content -cne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Output "Fixed dummy cards in $($file.Name)"
    }
}
