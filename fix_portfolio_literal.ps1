$dir = "d:\ZAMAN\Ai Folder\Kj Digital World"
$files = Get-ChildItem -Path $dir -Recurse -Filter "portfolio*.html"

$utf8NoBom = New-Object System.Text.UTF8Encoding $false

# Define the literal string we want to replace
$badBlock = @"
      <!-- PLACEHOLDER PROJECTS: YOU CAN EDIT THESE LOCALLY -->
      <a href="#" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #020610, #04091a); color: #fff;">ðŸ” </div>
        <div class="project-body">
          <div class="project-cat">SEO</div>
          <h3 class="project-title">B2B SaaS SEO Strategy</h3>
          <p class="project-desc">150% organic traffic growth in 6 months for a leading HR software provider.</p>
        </div>
      </a>
      
      <a href="#" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #1a0a00, #331800); color: #fff;">âœ ï¸ </div>
        <div class="project-body">
          <div class="project-cat">Content Marketing</div>
          <h3 class="project-title">E-commerce Content Strategy</h3>
          <p class="project-desc">Complete blog and content restructure driving 40% more inbound leads.</p>
        </div>
      </a>
"@

# Define the good block
$goodBlock = @"
      <!-- PLACEHOLDER PROJECTS: YOU CAN EDIT THESE LOCALLY -->
      <a href="/posts/seo-case-study" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #020610, #04091a); color: #fff;">🔍</div>
        <div class="project-body">
          <div class="project-cat">SEO</div>
          <h3 class="project-title">B2B SaaS SEO Strategy</h3>
          <p class="project-desc">150% organic traffic growth in 6 months for a leading HR software provider.</p>
        </div>
      </a>
      
      <a href="/posts/shopify-cro-case-study" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #1a0a00, #331800); color: #fff;">✍️</div>
        <div class="project-body">
          <div class="project-cat">Content Marketing</div>
          <h3 class="project-title">E-commerce Content Strategy</h3>
          <p class="project-desc">Complete blog and content restructure driving 40% more inbound leads.</p>
        </div>
      </a>
"@

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    if ($content.Contains($badBlock)) {
        $content = $content.Replace($badBlock, $goodBlock)
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Output "Fixed dummy cards in $($file.Name)"
    }
}
