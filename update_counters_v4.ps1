$files = Get-ChildItem -Filter *.html

$newHtml = @"
    <div class="stats-grid-minimal">
      <div class="stat-item">
        <div class="stat-num-m"><span class="cnt" data-target="150">0</span><span>+</span></div>
        <div class="stat-lbl-m">Projects Completed</div>
      </div>
      <div class="stat-item">
        <div class="stat-num-m"><span class="cnt" data-target="120">0</span><span>+</span></div>
        <div class="stat-lbl-m">Happy Clients</div>
      </div>
      <div class="stat-item">
        <div class="stat-num-m"><span class="cnt" data-target="5">0</span></div>
        <div class="stat-lbl-m">Years Experience</div>
      </div>
      <div class="stat-item">
        <div class="stat-num-m"><span class="cnt" data-target="11">0</span></div>
        <div class="stat-lbl-m">Countries Served</div>
      </div>
    </div>
"@

$cssSnippet = @"
<style>
.stats-grid-minimal { display: grid; grid-template-columns: repeat(4, 1fr); max-width: 1000px; margin: 40px auto; align-items: center; }
.stat-item { text-align: center; padding: 20px; position: relative; }
.stat-item:not(:last-child)::after { content: ''; position: absolute; right: 0; top: 15%; height: 70%; width: 1px; background-color: #e5e5e5; }
.stat-num-m { font-family: var(--font-d, 'DM Serif Display', serif); font-size: 56px; color: #111; line-height: 1; margin-bottom: 8px; }
.stat-num-m span { color: #0071e3; font-size: 32px; vertical-align: super; }
.stat-lbl-m { font-size: 13px; color: #777; font-weight: 500; text-transform: uppercase; letter-spacing: 0.05em; }
@media (max-width: 900px) {
  .stats-grid-minimal { grid-template-columns: repeat(2, 1fr); gap: 30px 0; }
  .stat-item:not(:last-child)::after { display: none; }
  .stat-item:nth-child(odd)::after { content: ''; display: block; position: absolute; right: 0; top: 15%; height: 70%; width: 1px; background-color: #e5e5e5; }
}
@media (max-width: 600px) {
  .stats-grid-minimal { grid-template-columns: 1fr; }
  .stat-item::after { display: none !important; }
}
</style>
"@

foreach ($file in $files) {
    if ($file.Name -match "^(temp|tmp|lovable_contact|blog)\.html$") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    # 1. Clean up old injected CSS
    if ($content -match '<style>\r?\n\.stats-grid \{ display: grid; grid-template-columns: repeat\(4, 1fr\); gap: 24px; margin: 20px 0; \}') {
        $content = $content -replace '(?s)<style>\r?\n\.stats-grid \{ display: grid; grid-template-columns: repeat\(4, 1fr\); gap: 24px; margin: 20px 0; \}.*?</style>', ''
        $modified = $true
    }
    
    # 2. Inject new CSS globally, if not already present
    if ($content -notmatch '\.stats-grid-minimal \{ display: grid;') {
        $content = $content -replace '</head>', "$cssSnippet`n</head>"
        $modified = $true
    }
    
    # 3. Replace the stats HTML universally
    if ($content -match '<div class="stats-grid">\s*<div class="stat-card">') {
        $content = $content -replace '(?s)<div class="stats-grid">\s*<div class="stat-card">.*?</div>\s*</div>\s*</div>\s*</div>', $newHtml
        $modified = $true
    }
    
    if ($modified) {
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Updated $($file.Name)"
    }
}
