$file = "d:\ZAMAN\Ai Folder\Kj Digital World\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Find the block from <div class="marquee-track" id="mtrack"> to the closing </div></div>
# Actually, let's just replace the exact lines that have ??

$content = $content -replace '<div class="marquee-item"><span>\?\?</span>Local SEO</div>', '<div class="marquee-item"><span>📍</span>Local SEO</div>'
$content = $content -replace '<div class="marquee-item"><span>\?\?</span>Ecommerce SEO</div>', '<div class="marquee-item"><span>🛒</span>Ecommerce SEO</div>'
$content = $content -replace '<div class="marquee-item"><span>\?\?</span>SaaS SEO</div>', '<div class="marquee-item"><span>💻</span>SaaS SEO</div>'
$content = $content -replace '<div class="marquee-item"><span>\?\?</span>Web Design &amp; Dev</div>', '<div class="marquee-item"><span>🌐</span>Web Design &amp; Dev</div>'
$content = $content -replace '<div class="marquee-item"><span>\?\?</span>WordPress</div>', '<div class="marquee-item"><span>🔵</span>WordPress</div>'
$content = $content -replace '<div class="marquee-item"><span>\?\?</span>Shopify</div>', '<div class="marquee-item"><span>🟢</span>Shopify</div>'
$content = $content -replace '<div class="marquee-item"><span>\?\?</span>Google Ads</div>', '<div class="marquee-item"><span>🎯</span>Google Ads</div>'
$content = $content -replace '<div class="marquee-item"><span>\?\?</span>Facebook Ads</div>', '<div class="marquee-item"><span>🟦</span>Facebook Ads</div>'
$content = $content -replace '<div class="marquee-item"><span>\?\?</span>Content Marketing</div>', '<div class="marquee-item"><span>✍️</span>Content Marketing</div>'
$content = $content -replace '<div class="marquee-item"><span>\?\?</span>Email Marketing</div>', '<div class="marquee-item"><span>✉️</span>Email Marketing</div>'

[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Output "Marquee emojis fixed."
