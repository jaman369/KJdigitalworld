# ============================================================
# Fix: Replace simple nav with full mega-dropdown nav on all
# 4 service pages to match home page navigation exactly
# ============================================================

$files = @(
  @{ file="services-seo.html";     active="seo"     },
  @{ file="services-web.html";     active="web"     },
  @{ file="services-ppc.html";     active="ppc"     },
  @{ file="services-content.html"; active="content" }
)

# ── Shared NAV CSS to inject (replaces old simple nav CSS) ──────────────────
$navCSS = @'
/* ── NAV ── */
nav{position:fixed;top:0;left:0;right:0;z-index:1000;height:var(--nav-h);background:rgba(29,29,31,.85);backdrop-filter:saturate(180%) blur(20px);-webkit-backdrop-filter:saturate(180%) blur(20px);border-bottom:.5px solid rgba(255,255,255,.06);transition:background .3s;}
nav .nav-wrap{max-width:1160px;margin:0 auto;height:100%;padding:0 24px;display:flex;align-items:center;justify-content:space-between;}
nav .nav-logo{font-family:var(--font-d);font-size:17px;color:#fff;cursor:pointer;letter-spacing:-.3px;display:flex;align-items:center;gap:8px;user-select:none;text-decoration:none;}
nav .logo-dot{width:8px;height:8px;border-radius:50%;background:var(--blue);box-shadow:0 0 12px var(--blue);}
nav .nav-links{display:flex;align-items:center;gap:2px;}
nav .nav-link{position:relative;color:rgba(255,255,255,.78);font-size:12px;font-weight:400;padding:8px 12px;border-radius:8px;cursor:pointer;transition:color .2s,background .2s;letter-spacing:.01em;text-decoration:none;display:inline-block;}
nav .nav-link:hover{color:#fff;background:rgba(255,255,255,.08);}
nav .nav-link.has-drop:after{content:'';display:inline-block;width:4px;height:4px;border-right:1px solid currentColor;border-bottom:1px solid currentColor;transform:rotate(45deg);margin-left:5px;vertical-align:middle;transition:transform .2s;}
nav .nav-link.has-drop:hover:after{transform:rotate(-135deg);}
nav .nav-link.has-drop{padding-bottom:18px;margin-bottom:-10px;}
nav .mega-drop{position:fixed;top:var(--nav-h);left:0;right:0;background:rgba(18,18,20,.97);backdrop-filter:blur(30px);border-bottom:.5px solid rgba(255,255,255,.08);padding:32px 0 36px;opacity:0;pointer-events:none;transition:opacity .25s var(--ease) .35s,transform .25s var(--ease) .35s,visibility 0s linear .6s;transform:translateY(-8px);visibility:hidden;z-index:999;}
nav .nav-link.has-drop:hover .mega-drop,nav .mega-drop:hover{opacity:1!important;pointer-events:all!important;transform:translateY(0)!important;visibility:visible!important;transition:opacity .2s var(--ease),transform .2s var(--ease),visibility 0s linear 0s;}
nav .mega-inner{max-width:1160px;margin:0 auto;padding:0 24px;display:grid;grid-template-columns:repeat(4,1fr);gap:32px;}
nav .mega-col h3{font-size:10px;font-weight:600;color:rgba(255,255,255,.45);letter-spacing:.1em;text-transform:uppercase;margin-bottom:12px;padding-bottom:8px;border-bottom:.5px solid rgba(255,255,255,.07);}
nav .mega-col a{display:block;font-size:12px;color:rgba(255,255,255,.62);padding:5px 0;transition:color .15s;cursor:pointer;text-decoration:none;}
nav .mega-col a:hover{color:#fff;}
nav .nav-cta{background:var(--blue);color:#fff;font-size:12px;font-weight:500;padding:8px 16px;border-radius:980px;cursor:pointer;border:none;font-family:var(--font-b);transition:background .2s,transform .15s;text-decoration:none;}
nav .nav-cta:hover{background:var(--blue-h);transform:scale(1.03);}
@media(max-width:900px){nav .nav-links{display:none!important;}nav .nav-cta{display:none!important;}}

/* ── MOBILE MENU ── */
.mobile-toggle{display:none;position:absolute;top:50%;right:20px;transform:translateY(-50%);background:none;border:none;width:40px;height:40px;cursor:pointer;flex-direction:column;justify-content:center;align-items:center;gap:5px;padding:0;z-index:1001;}
.mobile-toggle span{display:block;width:22px;height:2px;background:#fff;transition:transform .3s,opacity .2s;}
.mobile-toggle.open span:nth-child(1){transform:translateY(7px) rotate(45deg);}
.mobile-toggle.open span:nth-child(2){opacity:0;}
.mobile-toggle.open span:nth-child(3){transform:translateY(-7px) rotate(-45deg);}
.mobile-drawer{position:fixed;top:var(--nav-h);left:0;right:0;bottom:0;background:rgba(18,18,20,.98);-webkit-backdrop-filter:blur(30px);backdrop-filter:blur(30px);z-index:998;padding:24px 20px 80px;overflow-y:auto;transform:translateX(100%);transition:transform .3s ease;display:none;}
.mobile-drawer.open{transform:translateX(0);}
.mobile-drawer a{display:block;padding:14px 4px;color:rgba(255,255,255,.85);font-size:16px;border-bottom:.5px solid rgba(255,255,255,.06);text-decoration:none;}
.mobile-drawer a:hover{color:#fff;}
.mobile-drawer .ms-section{font-size:11px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:#0071e3;padding:18px 4px 6px;border:none;cursor:pointer;display:flex;align-items:center;justify-content:space-between;user-select:none;}
.mobile-drawer .ms-section::after{content:'+';font-size:18px;color:#0071e3;font-weight:300;transition:transform .25s;}
.mobile-drawer .ms-section.open::after{content:'\2212';}
.mobile-drawer .ms-group{max-height:0;overflow:hidden;transition:max-height .35s ease;}
.mobile-drawer .ms-group.open{max-height:600px;}
.mobile-drawer .ms-sub{padding-left:16px;font-size:14px;color:rgba(255,255,255,.65);}
.mobile-drawer .mobile-cta{display:block;background:#0071e3;color:#fff;text-align:center;padding:14px;border-radius:980px;margin-top:24px;font-weight:500;border:none;text-decoration:none;}
@media(max-width:900px){.mobile-toggle{display:flex;}.mobile-drawer{display:block;}}
@media(max-width:600px){:root{--nav-h:56px;}}
'@

# ── Shared NAV HTML ─────────────────────────────────────────────────────────
# Note: DATA_ACTIVE_CLASS will be replaced per-page below
$navHTML_template = @'
<!-- ── NAV ── -->
<nav>
  <div class="nav-wrap">
    <a href="/" class="nav-logo"><div class="logo-dot"></div>Digital World</a>
    <div class="nav-links">
      <a href="/" class="nav-link">Home</a>
      <div class="nav-link has-drop has-mega DATA_ACTIVE_CLASS">Services
        <div class="mega-drop">
          <div class="mega-inner">
            <div class="mega-col">
              <h3>🔍 SEO</h3>
              <a href="/services/seo#svc-local">Local SEO</a>
              <a href="/services/seo#svc-ecom">Ecommerce SEO</a>
              <a href="/services/seo#svc-intl">International SEO</a>
              <a href="/services/seo#svc-yt">Youtube / Video SEO</a>
              <a href="/services/seo#svc-saas">SaaS SEO</a>
              <a href="/services/seo#svc-semantic">Semantic SEO</a>
              <a href="/services/seo#svc-ai">AI SEO</a>
            </div>
            <div class="mega-col">
              <h3>🎯 PPC / Paid Ads</h3>
              <a href="/services/ppc#svc-search">Google Search Ads</a>
              <a href="/services/ppc#svc-shopping">Google Shopping Ads</a>
              <a href="/services/ppc#svc-pmax">Performance Max</a>
              <a href="/services/ppc#svc-youtube">YouTube Ads</a>
              <a href="/services/ppc#svc-remarketing">Remarketing</a>
              <a href="/services/ppc#svc-facebook">Facebook Ads</a>
              <a href="/services/ppc#svc-instagram">Instagram Ads</a>
              <a href="/services/ppc#svc-tiktok">TikTok / LinkedIn Ads</a>
            </div>
            <div class="mega-col">
              <h3>🌐 Web Design &amp; Dev</h3>
              <a href="/services/web#svc-uiux">Website Design (UI/UX)</a>
              <a href="/services/web#svc-wordpress">WordPress Development</a>
              <a href="/services/web#svc-shopify">Shopify Development</a>
              <a href="/services/web#svc-landing">Landing Page Design</a>
              <a href="/services/web#svc-speed">Website Speed Optimization</a>
              <a href="/services/web#svc-maintenance">Website Maintenance</a>
              <a href="/services/web#svc-migration">Website Migration</a>
              <a href="/services/web#svc-cms">CMS Setup</a>
            </div>
            <div class="mega-col">
              <h3>✍️ Content &amp; More</h3>
              <a href="/services/content#svc-blog">Blog Writing &amp; Management</a>
              <a href="/services/content#svc-email">Email Marketing</a>
              <a href="/services/content#svc-content">Content Marketing</a>
              <a href="/services/content#svc-cro">CRO Audit &amp; Testing</a>
              <a href="/services/content#svc-backlink">Backlink Building</a>
              <a href="/services/content#svc-pr">Digital PR &amp; HARO</a>
              <a href="/services/content#svc-social">Social Media Content</a>
              <a href="/services/content#svc-press">Press Releases &amp; PR</a>
            </div>
          </div>
        </div>
      </div>
      <a href="/portfolio" class="nav-link">Portfolio</a>
      <a href="/about" class="nav-link">About</a>
      <a href="/blog" class="nav-link">Blog</a>
      <a href="/contact" class="nav-link">Contact</a>
    </div>
    <a href="/contact" class="nav-cta">Get Started</a>
  </div>
  <button class="mobile-toggle" id="mobToggle" aria-label="Toggle menu"><span></span><span></span><span></span></button>
  <div class="mobile-drawer" id="mobDrawer">
    <a href="/">Home</a>
    <div class="ms-section">SEO Services</div>
    <div class="ms-group">
      <a class="ms-sub" href="/services/seo">All SEO Services</a>
      <a class="ms-sub" href="/services/seo#svc-local">Local SEO</a>
      <a class="ms-sub" href="/services/seo#svc-ecom">Ecommerce SEO</a>
      <a class="ms-sub" href="/services/seo#svc-intl">International SEO</a>
      <a class="ms-sub" href="/services/seo#svc-semantic">Semantic SEO</a>
    </div>
    <div class="ms-section">PPC / Paid Ads</div>
    <div class="ms-group">
      <a class="ms-sub" href="/services/ppc">All Paid Ads</a>
      <a class="ms-sub" href="/services/ppc#svc-search">Google Ads</a>
      <a class="ms-sub" href="/services/ppc#svc-facebook">Facebook Ads</a>
      <a class="ms-sub" href="/services/ppc#svc-remarketing">Remarketing</a>
    </div>
    <div class="ms-section">Web Design &amp; Dev</div>
    <div class="ms-group">
      <a class="ms-sub" href="/services/web">All Web Services</a>
      <a class="ms-sub" href="/services/web#svc-wordpress">WordPress</a>
      <a class="ms-sub" href="/services/web#svc-shopify">Shopify</a>
    </div>
    <div class="ms-section">Content &amp; More</div>
    <div class="ms-group">
      <a class="ms-sub" href="/services/content">All Content Services</a>
      <a class="ms-sub" href="/services/content#svc-email">Email Marketing</a>
      <a class="ms-sub" href="/services/content#svc-content">Content Marketing</a>
    </div>
    <a href="/portfolio" style="margin-top:14px;">Portfolio</a>
    <a href="/about">About</a>
    <a href="/blog">Blog</a>
    <a href="/contact">Contact</a>
    <a href="/contact" class="mobile-cta">Get Started</a>
  </div>
</nav>
'@

# ── Nav script (mobile toggle + collapsible groups) ─────────────────────────
$navScript = @'
<script>
(function(){
  var t=document.getElementById('mobToggle'),d=document.getElementById('mobDrawer');
  if(t&&d){
    t.addEventListener('click',function(){t.classList.toggle('open');d.classList.toggle('open');});
    d.querySelectorAll('a:not(.ms-sub)').forEach(function(a){
      a.addEventListener('click',function(){t.classList.remove('open');d.classList.remove('open');});
    });
    // collapsible section groups
    d.querySelectorAll('.ms-section').forEach(function(sec){
      sec.addEventListener('click',function(){
        sec.classList.toggle('open');
        var grp=sec.nextElementSibling;
        if(grp&&grp.classList.contains('ms-group'))grp.classList.toggle('open');
      });
    });
  }
})();
</script>
'@

# ── OLD nav CSS patterns to find+replace (seo/web/content) ──────────────────
$oldNavCSS_simple = '/* ── NAV ── */
nav{position:fixed;top:0;left:0;right:0;z-index:1000;height:var(--nav-h);background:rgba(29,29,31,.85);backdrop-filter:saturate(180%) blur(20px);-webkit-backdrop-filter:saturate(180%) blur(20px);border-bottom:.5px solid rgba(255,255,255,.06);}
nav .nav-wrap{max-width:1160px;margin:0 auto;height:100%;padding:0 24px;display:flex;align-items:center;justify-content:space-between;}
nav .nav-logo{font-family:var(--font-d);font-size:17px;color:#fff;cursor:pointer;letter-spacing:-.3px;display:flex;align-items:center;gap:8px;user-select:none;text-decoration:none;}
nav .logo-dot{width:8px;height:8px;border-radius:50%;background:var(--blue);box-shadow:0 0 12px var(--blue);}
nav .nav-links{display:flex;align-items:center;gap:2px;}
nav .nav-link{position:relative;color:rgba(255,255,255,.78);font-size:12px;font-weight:400;padding:8px 12px;border-radius:8px;cursor:pointer;transition:color .2s,background .2s;letter-spacing:.01em;text-decoration:none;display:inline-block;}
nav .nav-link:hover{color:#fff;background:rgba(255,255,255,.08);}
nav .nav-cta{background:var(--blue);color:#fff;font-size:12px;font-weight:500;padding:8px 16px;border-radius:980px;cursor:pointer;border:none;font-family:var(--font-b);transition:background .2s,transform .15s;text-decoration:none;}
nav .nav-cta:hover{background:var(--blue-h);transform:scale(1.03);}
@media(max-width:900px){nav .nav-links{display:none!important;}nav .nav-cta{display:none!important;}}

/* ── MOBILE MENU ── */
.mobile-toggle{display:none;position:absolute;top:50%;right:20px;transform:translateY(-50%);background:none;border:none;width:40px;height:40px;cursor:pointer;flex-direction:column;justify-content:center;align-items:center;gap:5px;padding:0;z-index:1001;}
.mobile-toggle span{display:block;width:22px;height:2px;background:#fff;transition:transform .3s,opacity .2s;}
.mobile-toggle.open span:nth-child(1){transform:translateY(7px) rotate(45deg);}
.mobile-toggle.open span:nth-child(2){opacity:0;}
.mobile-toggle.open span:nth-child(3){transform:translateY(-7px) rotate(-45deg);}
.mobile-drawer{position:fixed;top:var(--nav-h);left:0;right:0;bottom:0;background:rgba(18,18,20,.98);backdrop-filter:blur(30px);z-index:998;padding:24px 20px 80px;overflow-y:auto;transform:translateX(100%);transition:transform .3s ease;display:none;}
.mobile-drawer.open{transform:translateX(0);}
.mobile-drawer a{display:block;padding:14px 4px;color:rgba(255,255,255,.85);font-size:16px;border-bottom:.5px solid rgba(255,255,255,.06);text-decoration:none;}
.mobile-drawer .ms-section{font-size:11px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:#0071e3;padding:18px 4px 6px;border:none;}
.mobile-drawer .ms-sub{padding-left:16px;font-size:14px;color:rgba(255,255,255,.65);}
.mobile-drawer .mobile-cta{display:block;background:#0071e3;color:#fff;text-align:center;padding:14px;border-radius:980px;margin-top:24px;font-weight:500;border:none;text-decoration:none;}
@media(max-width:900px){.mobile-toggle{display:flex;}.mobile-drawer{display:block;}}'

# ── OLD nav HTML pattern (common to seo/web/content) ────────────────────────
$oldNavHTML_simple = @'
<!-- ── NAV ── -->
<nav>
  <div class="nav-wrap">
    <a href="/" class="nav-logo"><div class="logo-dot"></div>Digital World</a>
    <div class="nav-links">
      <a href="/" class="nav-link">Home</a>
      DATA_OLD_SVC_LINK
      <a href="/portfolio" class="nav-link">Portfolio</a>
      <a href="/about" class="nav-link">About</a>
      <a href="/blog" class="nav-link">Blog</a>
      <a href="/contact" class="nav-link">Contact</a>
    </div>
    <a href="/contact" class="nav-cta">Get Started</a>
  </div>
  <button class="mobile-toggle" id="mobToggle" aria-label="Toggle menu"><span></span><span></span><span></span></button>
  <div class="mobile-drawer" id="mobDrawer">
    <a href="/">Home</a>
    <div class="ms-section">Services</div>
    <a class="ms-sub" href="/services/seo">SEO</a>
    <a class="ms-sub" href="/services/web">Web Design</a>
    <a class="ms-sub" href="/services/ppc">PPC / Paid Ads</a>
    <a class="ms-sub" href="/services/content">Content Marketing</a>
    <a href="/portfolio">Portfolio</a>
    <a href="/about">About</a>
    <a href="/blog">Blog</a>
    <a href="/contact">Contact</a>
    <a href="/contact" class="mobile-cta">Get Started</a>
  </div>
</nav>
'@

# ── OLD nav script (simple) ──────────────────────────────────────────────────
$oldNavScript_simple = @'
<script>
document.addEventListener('DOMContentLoaded',()=>{const t=document.getElementById('mobToggle'),d=document.getElementById('mobDrawer');if(t&&d){t.addEventListener('click',()=>{t.classList.toggle('open');d.classList.toggle('open');});d.querySelectorAll('a').forEach(a=>a.addEventListener('click',()=>{t.classList.remove('open');d.classList.remove('open');}));}});
</script>
'@

# ─────────────────────────────────────────────────────────────────────────────
# Process each file
# ─────────────────────────────────────────────────────────────────────────────
foreach ($item in $files) {
  $file   = $item.file
  $active = $item.active

  Write-Host "Processing $file ..."
  $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

  # Build the active-class string (adds highlight to Services link)
  $activeClass = "style=`"color:#fff;`""  # minimal active indicator

  # Build nav HTML for this page (set active class, remove DATA_ACTIVE_CLASS placeholder)
  $navHTML = $navHTML_template -replace 'DATA_ACTIVE_CLASS', $activeClass

  # ── 1. Replace nav CSS ───────────────────────────────────────────────────
  # The seo/web/content files have the simple multi-line nav CSS
  # The ppc file has its own formatted CSS — handle both
  $content = $content -replace [regex]::Escape($oldNavCSS_simple), $navCSS

  # ── 2. Replace nav HTML for seo/web/content (simple single "Services" link)
  # Each page has a slightly different active link — use regex to match flexibly
  $content = $content -replace '(?s)<!-- ── NAV ── -->\s*<nav>.*?</nav>', $navHTML.Trim()

  # ── 3. Replace old nav script with new one ───────────────────────────────
  $content = $content -replace [regex]::Escape($oldNavScript_simple.Trim()), $navScript.Trim()
  # Also catch the DOMContentLoaded one-liner variant
  $content = $content -replace "(?s)<script>\s*document\.addEventListener\('DOMContentLoaded'[^<]+</script>", $navScript.Trim()

  [System.IO.File]::WriteAllText((Resolve-Path $file).Path, $content, [System.Text.Encoding]::UTF8)
  Write-Host "  -> Done: $file"
}

Write-Host ""
Write-Host "All 4 service pages updated with mega-dropdown nav."
