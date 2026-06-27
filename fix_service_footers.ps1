# Footer CSS that exists in service pages (old - to be replaced)
$oldFooterCSS = "/* -- FOOTER -- */`r`nfooter{background:#1d1d1f;padding:64px 24px 40px;border-top:.5px solid rgba(255,255,255,.07);}footer .footer-w{max-width:1120px;margin:0 auto;}footer .footer-top{display:grid;grid-template-columns:2.5fr 1fr 1fr 1fr;gap:48px;padding-bottom:48px;border-bottom:.5px solid rgba(255,255,255,.07);}footer .footer-brand{font-family:var(--font-d);font-size:22px;color:#fff;margin-bottom:10px;}footer .footer-tagline{font-size:13px;color:var(--gray);line-height:1.7;max-width:280px;margin-bottom:18px;}footer .footer-col-title{font-size:11px;font-weight:600;color:rgba(255,255,255,.35);letter-spacing:.08em;text-transform:uppercase;margin-bottom:14px;}footer .footer-link{display:block;font-size:13px;color:rgba(255,255,255,.6);padding:5px 0;transition:color .15s;text-decoration:none;}footer .footer-link:hover{color:#fff;}footer .footer-soc{display:flex;gap:12px;margin-top:14px;}footer .footer-soc-link{width:32px;height:32px;border-radius:50%;background:rgba(255,255,255,.06);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,.5);transition:background .2s,color .2s;text-decoration:none;}footer .footer-soc-link:hover{background:rgba(255,255,255,.12);color:#fff;}footer .footer-bottom{display:flex;justify-content:space-between;align-items:center;padding-top:28px;flex-wrap:wrap;gap:12px;}footer .footer-copy{font-size:12px;color:rgba(255,255,255,.3);}@media(max-width:900px){footer .footer-top{grid-template-columns:1fr 1fr;}}@media(max-width:600px){footer .footer-top{grid-template-columns:1fr;}.footer-bottom{flex-direction:column;text-align:center;}}"

# New footer CSS matching home page
$newFooterCSS = "/* -- FOOTER -- */`r`nfooter{background:#1d1d1f;padding:64px 24px 40px;border-top:.5px solid rgba(255,255,255,.07);}footer .footer-w{max-width:1120px;margin:0 auto;}footer .footer-top{display:grid;grid-template-columns:2.5fr 1fr 1fr 1fr;gap:48px;padding-bottom:48px;border-bottom:.5px solid rgba(255,255,255,.07);}footer .footer-brand{font-family:var(--font-d);font-size:22px;color:#fff;margin-bottom:10px;}footer .footer-tagline{font-size:13px;color:rgba(255,255,255,.55);line-height:1.7;max-width:320px;}footer .footer-flags{display:flex;flex-wrap:wrap;gap:6px;margin-top:16px;font-size:15px;}footer .footer-social{display:flex;gap:10px;margin-top:18px;flex-wrap:wrap;}footer .footer-soc-link{width:34px;height:34px;border-radius:8px;background:rgba(255,255,255,.06);border:.5px solid rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,.6);font-size:12px;font-weight:500;text-decoration:none;transition:background .2s,color .2s,border-color .2s;}footer .footer-soc-link:hover{background:var(--blue);color:#fff;border-color:#3399ff;}footer .footer-col h4{font-size:12px;font-weight:600;color:#fff;margin-bottom:16px;letter-spacing:.04em;}footer .footer-link{display:block;font-size:12px;color:rgba(255,255,255,.55);margin-bottom:9px;cursor:pointer;transition:color .2s;text-decoration:none;}footer .footer-link:hover{color:#fff;}footer .footer-bottom{display:flex;justify-content:space-between;align-items:center;padding-top:28px;flex-wrap:wrap;gap:12px;}footer .footer-copy{font-size:12px;color:rgba(255,255,255,.4);}footer .footer-copy a{color:#3399ff;text-decoration:none;}@media(max-width:900px){footer .footer-top{grid-template-columns:1fr 1fr;}}@media(max-width:600px){footer .footer-top{grid-template-columns:1fr;}.footer-bottom{flex-direction:column;text-align:center;}}"

$files = @("services-seo.html", "services-web.html", "services-ppc.html", "services-content.html")

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
    
    # Check if old CSS exists (exact match won't work due to line endings, use -replace with regex)
    if ($content -match [regex]::Escape("footer .footer-soc-link{width:32px;height:32px;border-radius:50%")) {
        # Replace just the footer-soc-link rule
        $content = $content -replace [regex]::Escape("footer .footer-soc-link{width:32px;height:32px;border-radius:50%;background:rgba(255,255,255,.06);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,.5);transition:background .2s,color .2s;text-decoration:none;}"), "footer .footer-soc-link{width:34px;height:34px;border-radius:8px;background:rgba(255,255,255,.06);border:.5px solid rgba(255,255,255,.08);display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,.6);font-size:12px;font-weight:500;text-decoration:none;transition:background .2s,color .2s,border-color .2s;}"
        
        $content = $content -replace [regex]::Escape("footer .footer-soc-link:hover{background:rgba(255,255,255,.12);color:#fff;}"), "footer .footer-soc-link:hover{background:var(--blue);color:#fff;border-color:#3399ff;}"
        
        # Replace footer-soc container with footer-social styling
        $content = $content -replace [regex]::Escape("footer .footer-soc{display:flex;gap:12px;margin-top:14px;}"), "footer .footer-flags{display:flex;flex-wrap:wrap;gap:6px;margin-top:16px;font-size:15px;}footer .footer-social{display:flex;gap:10px;margin-top:18px;flex-wrap:wrap;}footer .footer-col h4{font-size:12px;font-weight:600;color:#fff;margin-bottom:16px;letter-spacing:.04em;}"
        
        # Fix footer-link styling
        $content = $content -replace [regex]::Escape("footer .footer-link{display:block;font-size:13px;color:rgba(255,255,255,.6);padding:5px 0;transition:color .15s;text-decoration:none;}"), "footer .footer-link{display:block;font-size:12px;color:rgba(255,255,255,.55);margin-bottom:9px;cursor:pointer;transition:color .2s;text-decoration:none;}"
        
        # Fix footer-tagline
        $content = $content -replace [regex]::Escape("footer .footer-tagline{font-size:13px;color:var(--gray);line-height:1.7;max-width:280px;margin-bottom:18px;}"), "footer .footer-tagline{font-size:13px;color:rgba(255,255,255,.55);line-height:1.7;max-width:320px;}"
        
        # Fix footer-col-title removal (if present)
        $content = $content -replace [regex]::Escape("footer .footer-col-title{font-size:11px;font-weight:600;color:rgba(255,255,255,.35);letter-spacing:.08em;text-transform:uppercase;margin-bottom:14px;}"), ""
        
        # Fix footer-copy color
        $content = $content -replace [regex]::Escape("footer .footer-copy{font-size:12px;color:rgba(255,255,255,.3);}"), "footer .footer-copy{font-size:12px;color:rgba(255,255,255,.4);}footer .footer-copy a{color:#3399ff;text-decoration:none;}"
        
        [System.IO.File]::WriteAllText((Resolve-Path $file).Path, $content, [System.Text.Encoding]::UTF8)
        Write-Host "SUCCESS: Updated $file"
    } else {
        Write-Host "INFO: Pattern not found in $file - checking alternative..."
        # For services-content.html which has single-line CSS
        if ($content -match [regex]::Escape("footer .footer-soc-link{width:32px;height:32px;border-radius:50%")) {
            Write-Host "  Found alternative pattern"
        } else {
            Write-Host "  No footer soc-link pattern found - may already be updated or different format"
        }
    }
}
