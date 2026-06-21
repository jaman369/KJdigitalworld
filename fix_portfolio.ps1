$files = @(
  "portfolio.html",
  "portfolio-seo.html",
  "portfolio-ppc.html",
  "portfolio-cro.html",
  "portfolio-social.html",
  "portfolio-web.html",
  "portfolio-content.html"
)

$utf8NoBom = New-Object System.Text.UTF8Encoding $false

foreach ($f in $files) {
    if (Test-Path $f) {
        $content = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
        
        $content = $content -replace '<a href="#" class="project-card">\s*<div class="project-visual"[^>]*>.*?</div>\s*<div class="project-body">\s*<div class="project-cat">SEO</div>\s*<h3 class="project-title">B2B SaaS SEO Strategy</h3>', '<a href="/posts/seo-case-study" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #020610, #04091a); color: #fff;">🔍</div>
        <div class="project-body">
          <div class="project-cat">SEO</div>
          <h3 class="project-title">B2B SaaS SEO Strategy</h3>'
          
        $content = $content -replace '<a href="#" class="project-card">\s*<div class="project-visual"[^>]*>.*?</div>\s*<div class="project-body">\s*<div class="project-cat">Content Marketing</div>\s*<h3 class="project-title">E-commerce Content Strategy</h3>', '<a href="/posts/shopify-cro-case-study" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #1a0a00, #331800); color: #fff;">✍️</div>
        <div class="project-body">
          <div class="project-cat">Content Marketing</div>
          <h3 class="project-title">E-commerce Content Strategy</h3>'
          
        [System.IO.File]::WriteAllText($f, $content, $utf8NoBom)
        Write-Output "Fixed $f"
    }
}
