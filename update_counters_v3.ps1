$files = Get-ChildItem -Filter *.html

$newHtml = @"
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-num"><span class="cnt" data-target="150">0</span><span>+</span></div>
        <div class="stat-label">Projects Completed</div>
      </div>
      <div class="stat-card">
        <div class="stat-num"><span class="cnt" data-target="120">0</span><span>+</span></div>
        <div class="stat-label">Happy Clients</div>
      </div>
      <div class="stat-card">
        <div class="stat-num"><span class="cnt" data-target="5">0</span></div>
        <div class="stat-label">Years Experience</div>
      </div>
      <div class="stat-card">
        <div class="stat-num"><span class="cnt" data-target="11">0</span></div>
        <div class="stat-label">Countries Served</div>
      </div>
    </div>
"@

$cssSnippet = @"
<style>
.stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 24px; margin: 20px 0; }
.stat-card { background: #fff; padding: 40px 20px; border-radius: 16px; border: 1px solid #eee; box-shadow: 0 4px 20px rgba(0,0,0,0.02); text-align: center; }
.stat-num { font-family: var(--font-d, 'DM Serif Display', serif); font-size: 48px; color: #111; margin-bottom: 8px; line-height: 1; }
.stat-num span { color: #0071e3; font-size: 32px; vertical-align: super; }
.stat-label { font-size: 13px; color: #666; font-weight: 500; text-transform: uppercase; letter-spacing: 0.05em; }
@media (max-width: 900px) { .stats-grid { grid-template-columns: repeat(2, 1fr); gap: 16px; } }
@media (max-width: 600px) { .stats-grid { grid-template-columns: 1fr; } }
</style>
"@

$jsSnippet = @"
<script>
(function() {
  const counters = document.querySelectorAll('.cnt');
  const speed = 200;
  const animate = () => {
    counters.forEach(counter => {
      counter.innerText = '0';
      const updateCount = () => {
        const target = +counter.getAttribute('data-target');
        const count = +counter.innerText;
        const inc = target / speed;
        if (count < target) {
          counter.innerText = Math.ceil(count + inc);
          setTimeout(updateCount, 15);
        } else {
          counter.innerText = target;
        }
      };
      const observer = new IntersectionObserver((entries) => {
        if(entries[0].isIntersecting) {
          updateCount();
          observer.unobserve(counter);
        }
      }, { threshold: 0.5 });
      observer.observe(counter);
    });
  };
  animate();
})();
</script>
</body>
"@

foreach ($file in $files) {
    if ($file.Name -match "^(temp|tmp|lovable_contact|blog)\.html$") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    # 1. Clean up old injected stats CSS
    if ($content -match '<style>\s*\.stats-grid\{display:grid;grid-template-columns:repeat\(4,1fr\);gap:1px;') {
        $content = $content -replace '(?s)<style>\s*\.stats-grid\{display:grid;grid-template-columns:repeat\(4,1fr\);gap:1px;.*?</style>', ''
        $modified = $true
    }
    
    # 2. Inject new CSS globally, if not already present
    if ($content -notmatch '\.stat-card \{ background: #fff; padding: 40px 20px;') {
        $content = $content -replace '</head>', "$cssSnippet`n</head>"
        $modified = $true
    }
    
    # 3. Replace the stats block HTML universally
    if ($content -match '<div class="stats-grid">') {
        $content = $content -replace '(?s)<div class="stats-grid">.*?</div>\s*</div>\s*</div>\s*</div>', $newHtml
        $modified = $true
    }
    
    # 4. Inject JS if missing
    if ($content -notmatch "const animate = \(\) => \{") {
        $content = $content -replace '</body>', $jsSnippet
        $modified = $true
    }
    
    if ($modified) {
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Updated $($file.Name)"
    }
}
