$ErrorActionPreference = "Stop"

$html = Get-Content "blog.html" -Raw

# Extract head
$headMatch = [regex]::Match($html, "(?s)(<!DOCTYPE html>.*?</head>)")
$head = if ($headMatch.Success) { $headMatch.Groups[1].Value } else { "" }

# Extract nav
$navMatch = [regex]::Match($html, "(?s)(<body>.*?</div>`r?`n</nav>)")
if (-not $navMatch.Success) {
    $navMatch = [regex]::Match($html, "(?s)(<body>.*?<!-- ══════════════ HERO ══════════════ -->)")
}
if (-not $navMatch.Success) {
    $navMatch = [regex]::Match($html, "(?s)(<body>.*?)(?:<div class=`"blog-layout`"|<section)")
}

$nav_content = if ($navMatch.Success) { $navMatch.Groups[1].Value } else { "<body><nav>...</nav>" }
$nav_content = $nav_content -replace "(?s)<!-- ══════════════ HERO ══════════════ -->", ""

# Extract footer
$footerMatch = [regex]::Match($html, "(?s)(<footer>.*</html>)")
$footer = if ($footerMatch.Success) { $footerMatch.Groups[1].Value } else { "</footer></body></html>" }

$categories = @(
    @{ id="all"; name="All Projects"; filename="portfolio.html" },
    @{ id="seo"; name="SEO"; filename="portfolio-seo.html" },
    @{ id="web"; name="Web Design & Dev"; filename="portfolio-web.html" },
    @{ id="ppc"; name="PPC / Paid Ads"; filename="portfolio-ppc.html" },
    @{ id="social"; name="Social Media Ads"; filename="portfolio-social.html" },
    @{ id="content"; name="Content Marketing"; filename="portfolio-content.html" },
    @{ id="cro"; name="CRO"; filename="portfolio-cro.html" }
)

$portfolio_css = @"
<style>
/* Portfolio Specific Styles */
.portfolio-hero {
  background: #fff;
  padding: 120px 24px 72px;
  position: relative;
  overflow: hidden;
  border-bottom: .5px solid var(--soft);
  text-align: center;
}
.portfolio-hero-inner {
  max-width: 900px;
  margin: 0 auto;
  position: relative;
  z-index: 2;
}
.portfolio-title {
  font-family: var(--font-d);
  font-size: clamp(44px, 6vw, 72px);
  color: var(--near-black);
  line-height: 1.04;
  margin-bottom: 20px;
  letter-spacing: -0.02em;
}
.portfolio-sub {
  font-size: 18px;
  font-weight: 300;
  color: var(--gray);
  line-height: 1.7;
  max-width: 600px;
  margin: 0 auto 40px;
}
.portfolio-stats {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 32px;
  flex-wrap: wrap;
}
.portfolio-stat {
  text-align: center;
}
.p-stat-num {
  font-family: var(--font-d);
  font-size: 32px;
  color: var(--blue);
  line-height: 1;
  margin-bottom: 4px;
}
.p-stat-label {
  font-size: 12px;
  color: var(--gray);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
.filter-bar {
  background: #fff;
  border-bottom: .5px solid var(--soft);
  position: sticky;
  top: var(--nav-h);
  z-index: 800;
  padding: 16px 0;
}
.filter-inner {
  max-width: 1180px;
  margin: 0 auto;
  padding: 0 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  flex-wrap: wrap;
}
.filter-btn {
  font-size: 13px;
  font-weight: 500;
  padding: 8px 18px;
  border-radius: 980px;
  border: 1px solid var(--mid);
  background: #fff;
  color: var(--gray);
  cursor: pointer;
  transition: all .2s;
  text-decoration: none;
}
.filter-btn:hover {
  border-color: var(--near-black);
  color: var(--near-black);
}
.filter-btn.active {
  background: var(--near-black);
  color: #fff;
  border-color: var(--near-black);
}
.portfolio-grid {
  max-width: 1180px;
  margin: 0 auto;
  padding: 64px 24px 96px;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 32px;
}
.project-card {
  background: #fff;
  border-radius: 16px;
  border: .5px solid var(--soft);
  overflow: hidden;
  transition: box-shadow .3s, transform .3s;
  display: block;
  text-decoration: none;
}
.project-card:hover {
  box-shadow: 0 20px 40px rgba(0,0,0,.08);
  transform: translateY(-4px);
}
.project-visual {
  height: 220px;
  background: linear-gradient(135deg, #f0f0f2, #e8e8ed);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 48px;
}
.project-body {
  padding: 24px;
}
.project-cat {
  font-size: 11px;
  font-weight: 600;
  color: var(--blue);
  letter-spacing: .1em;
  text-transform: uppercase;
  margin-bottom: 12px;
}
.project-title {
  font-family: var(--font-d);
  font-size: 22px;
  color: var(--near-black);
  line-height: 1.2;
  margin-bottom: 12px;
}
.project-desc {
  font-size: 14px;
  color: var(--gray);
  line-height: 1.6;
}
</style>
"@

foreach ($cat in $categories) {
    $page_head = $head -replace "<title>Blog", "<title>Portfolio"
    
    $filter_html = "<div class=`"filter-bar`"><div class=`"filter-inner`">"
    foreach ($c in $categories) {
        $active_class = if ($c.id -eq $cat.id) { " active" } else { "" }
        $url = "/" + $c.filename.Replace(".html", "")
        if ($c.id -eq "all") { $url = "/portfolio" }
        $filter_html += "<a href=`"$url`" class=`"filter-btn$active_class`">$($c.name)</a>`n"
    }
    $filter_html += "</div></div>"
    
    $main_content = @"
    $portfolio_css
    <section class="portfolio-hero">
      <div class="portfolio-hero-inner">
        <h1 class="portfolio-title">Work that speaks for itself.</h1>
        <p class="portfolio-sub">Explore a selection of projects across SEO, web design, paid advertising, and content marketing.</p>
        <div class="portfolio-stats">
          <div class="portfolio-stat">
            <div class="p-stat-num">50+</div>
            <div class="p-stat-label">Projects Delivered</div>
          </div>
          <div class="portfolio-stat">
            <div class="p-stat-num">35+</div>
            <div class="p-stat-label">Happy Clients</div>
          </div>
          <div class="portfolio-stat">
            <div class="p-stat-num">11+</div>
            <div class="p-stat-label">Countries</div>
          </div>
          <div class="portfolio-stat">
            <div class="p-stat-num">5+</div>
            <div class="p-stat-label">Years Experience</div>
          </div>
        </div>
      </div>
    </section>
    
    $filter_html
    
    <div class="portfolio-grid">
      <!-- PLACEHOLDER PROJECTS: YOU CAN EDIT THESE LOCALLY -->
      <a href="#" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #020610, #04091a); color: #fff;">🔍</div>
        <div class="project-body">
          <div class="project-cat">SEO</div>
          <h3 class="project-title">B2B SaaS SEO Strategy</h3>
          <p class="project-desc">150% organic traffic growth in 6 months for a leading HR software provider.</p>
        </div>
      </a>
      
      <a href="#" class="project-card">
        <div class="project-visual" style="background: linear-gradient(135deg, #1a0a00, #331800); color: #fff;">✍️</div>
        <div class="project-body">
          <div class="project-cat">Content Marketing</div>
          <h3 class="project-title">E-commerce Content Strategy</h3>
          <p class="project-desc">Complete blog and content restructure driving 40% more inbound leads.</p>
        </div>
      </a>
      <!-- Add more projects here -->
    </div>
"@

    $full_html = $page_head + "`n" + $nav_content + "`n" + $main_content + "`n" + $footer
    Set-Content -Path $cat.filename -Value $full_html -Encoding UTF8
    Write-Host "Generated $($cat.filename)"
}
