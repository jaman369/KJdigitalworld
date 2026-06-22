$files = Get-ChildItem -Filter *.html

$newHtml = @"
    <div class="stats-grid"><div class="stat-box reveal">
        <div class="stat-num"><span class="cnt" data-target="150">0</span><span class="stat-suffix">+</span></div>
        <div class="stat-lbl">Projects Delivered</div>
      </div><div class="stat-box reveal reveal-delay-1">
        <div class="stat-num"><span class="cnt" data-target="120">0</span><span class="stat-suffix">+</span></div>
        <div class="stat-lbl">Happy Clients</div>
      </div><div class="stat-box reveal reveal-delay-2">
        <div class="stat-num"><span class="cnt" data-target="5">0</span><span class="stat-suffix">+</span></div>
        <div class="stat-lbl">Years Experience</div>
      </div><div class="stat-box reveal reveal-delay-3">
        <div class="stat-num"><span class="cnt" data-target="11">0</span><span class="stat-suffix">+</span></div>
        <div class="stat-lbl">Countries Served</div>
      </div></div>
"@

$cssSnippet = @"
<style>
.stats-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:1px;background:#e0e0e5;border-radius:20px;overflow:hidden;margin:20px 0;}
.stat-box{background:#f5f5f7;padding:40px 24px;text-align:center;transition:background .25s;}
.stat-box:hover{background:#ebebef;}
.stat-num{font-family:var(--font-d);font-size:clamp(44px,5vw,68px);color:#1d1d1f;line-height:1;margin-bottom:6px;}
.stat-suffix{font-size:.6em;vertical-align:super;color:#3399ff;}
.stat-lbl{font-size:13px;color:var(--gray);}
@media(max-width:900px){ .stats-grid{grid-template-columns:repeat(2,1fr);} }
@media(max-width:600px){ .stats-grid{grid-template-columns:1fr;} }
</style>
"@

foreach ($file in $files) {
    if ($file.Name -eq "temp.html" -or $file.Name -eq "tmp.html" -or $file.Name -eq "lovable_contact.html" -or $file.Name -eq "blog.html") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    # Fix index.html mangled html
    if ($file.Name -eq "index.html") {
        # regex to match everything from <section class="stats-section"> to </section>
        $content = $content -replace '(?s)<section class="stats-section">.*?</section>', "<section class=`"stats-section`">`n  <div class=`"stats-wrap`">`n    <p class=`"stats-label`">Proven track record</p>`n$newHtml`n  </div>`n</section>"
        $modified = $true
    }
    
    # Fix portfolio*.html
    if ($file.Name -like "portfolio*.html") {
        $content = $content -replace '(?s)<div class="portfolio-stats">.*?</div>\s*</div>\s*</section>', "$newHtml`n      </div>`n    </section>"
        # Inject CSS
        if ($content -notmatch "\.stat-box\{background:#f5f5f7") {
            $content = $content -replace '</head>', "$cssSnippet`n</head>"
        }
        $modified = $true
    }
    
    # Fix about.html
    if ($file.Name -eq "about.html") {
        $content = $content -replace '(?s)<div class="stats-grid">\s*<div class="stat-card">.*?</div>\s*</div>\s*</div>\s*</div>', "$newHtml`n        </div>"
        if ($content -notmatch "\.stat-box\{background:#f5f5f7") {
            $content = $content -replace '</head>', "$cssSnippet`n</head>"
        }
        $modified = $true
    }
    
    if ($modified) {
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Updated $($file.Name)"
    }
}
