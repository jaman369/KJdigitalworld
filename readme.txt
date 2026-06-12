=== Digital World Theme v2 — Setup Guide ===

WHAT'S NEW IN V2
================
- All pages are now REAL WordPress pages with proper URLs
- Services page has 4 sub-pages: SEO, Paid Ads, Web Design & Dev, Content Writing
- Mega menu "Services" dropdown links directly to each sub-page
- Mobile menu has an expandable "Services" submenu
- Blog page pulls REAL WordPress posts (with category filter tabs)
- Pages are AUTO-CREATED when you activate the theme!

INSTALLATION
============
1. WordPress Admin → Appearance → Themes → Add New → Upload Theme
2. Upload digitalworld-theme-v2.zip
3. Click "Activate"

✅ ALL PAGES ARE CREATED AUTOMATICALLY ON ACTIVATION:

  Page               | URL                          | Template
  -------------------|------------------------------|---------------------------
  Home               | yoursite.com/                | Homepage (auto set as front page)
  Services           | yoursite.com/services/       | All Services
  ├─ SEO             | yoursite.com/services/seo/   | SEO Services
  ├─ Paid Ads        | yoursite.com/services/paid-ads/      | PPC & Paid Ads
  ├─ Web Design      | yoursite.com/services/web-design/    | Web Design & Dev
  └─ Content Writing | yoursite.com/services/content-writing/ | Content Writing
  Portfolio          | yoursite.com/portfolio/      | Portfolio
  About              | yoursite.com/about/          | About
  Blog               | yoursite.com/blog/           | Blog (dynamic posts)
  Contact            | yoursite.com/contact/        | Contact

If pages already exist with the same slugs, the theme will NOT duplicate them.

IF PAGES DON'T APPEAR
======================
Sometimes WordPress needs a manual nudge:
1. Go to Settings → Permalinks
2. Click "Save Changes" (without changing anything) — this flushes the rewrite rules
3. Check Pages → All Pages — you should see all 10 pages listed

NAVIGATION MENU
================
The header menu is built into the theme (no need to set up a WP Menu).
"Services" shows a mega-dropdown with the 4 service sub-pages.
Mobile menu has a tap-to-expand "Services" section.

If you want to REORDER or ADD links, edit:
  template-parts/header.php

CUSTOMISE CONTENT
==================
Go to Appearance → Customize → Agency Settings:
- Email, Phone, WhatsApp number
- LinkedIn, Facebook URLs
- Homepage hero text (2 lines + subtext)

BLOG SETUP
==========
1. Go to Posts → Categories → Add categories like:
   SEO, Google Ads, Web Dev, Content Marketing, Email Marketing, Social Media
2. Go to Posts → Add New → write your article, set a Featured Image, assign category
3. To make a post "Featured" on the blog page → Click "Stick this post to the front page" 
   under Publish settings (Quick Edit or Post editor → Visibility → Edit → check Sticky)
4. Posts automatically appear on /blog/ with category filter tabs

PORTFOLIO
=========
Currently the Portfolio page uses static demo content matching the design.
To make it dynamic with real projects:
1. Go to Portfolio (custom post type, in left sidebar) → Add New
2. Set featured image, write description, assign Portfolio Category
3. (Optional: ask your developer to wire the loop — the CPT is already registered)

CONTACT FORM
============
Fully working AJAX form — sends email to your WP Admin email
(Settings → General → Email Address).

For Gmail/SMTP delivery reliability, install:
  WP Mail SMTP plugin → connect Gmail/SendGrid

RECOMMENDED PLUGINS
====================
- RankMath SEO          → meta titles, schema, sitemaps
- WP Mail SMTP          → reliable contact form emails
- WP Rocket / W3 Total Cache → speed
- Smush                 → image optimisation
- Wordfence             → security

COLOURS & FONTS
================
Primary Blue:     #2563eb
Accent Teal:      #14f1d9
Dark Background:  #04040f / #0f1117
Heading Font:     DM Serif Display (Google Fonts)
Body Font:        DM Sans (Google Fonts)

To change colours/fonts: edit assets/css/main.css → :root section

FILE STRUCTURE
==============
digitalworld-theme/
├── style.css                      (theme header)
├── functions.php                  (CPTs, menus, AJAX, auto page creation)
├── header.php / footer.php        (WP structure)
├── front-page.php                 (Home)
├── page-services.php              (Services landing)
├── page-seo.php                   (SEO sub-page)
├── page-ppc.php                   (Paid Ads sub-page)
├── page-web-design.php            (Web Design sub-page)
├── page-content-marketing.php     (Content Writing sub-page)
├── page-portfolio.php
├── page-about.php
├── page-blog.php                  (dynamic posts)
├── page-contact.php
├── category.php                   (blog category archive)
├── single.php / index.php / page.php / 404.php
├── assets/css/main.css            (ALL styles)
├── assets/js/main.js              (cursor, menus, forms, filters, counters)
├── template-parts/header.php      (nav + mega menu + mobile menu)
├── template-parts/footer.php      (footer)
└── page-templates/                (page content, included by templates)
    ├── home-content.php
    ├── services-content.php
    ├── portfolio-content.php
    ├── about-content.php
    ├── blog-content.php
    ├── contact-content.php
    └── services/
        ├── seo-content.php
        ├── ppc-content.php
        ├── web-content.php
        └── content-content.php

SUPPORT
=======
Built for Kamrujjaman Mufti — Digital World Agency
Dhaka, Bangladesh · WhatsApp: +880 1798-667820
