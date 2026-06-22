[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$newSocialHtml = @"
        <div class="footer-social">
          <a href="https://www.facebook.com/digitalworld1988" class="footer-soc-link" target="_blank" rel="noopener" title="Facebook" aria-label="Facebook">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 24 24"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path></svg>
          </a>
          <a href="https://www.instagram.com/" class="footer-soc-link" target="_blank" rel="noopener" title="Instagram" aria-label="Instagram">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg>
          </a>
          <a href="https://x.com/" class="footer-soc-link" target="_blank" rel="noopener" title="X (Twitter)" aria-label="X">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" viewBox="0 0 1200 1227"><path d="M714.163 519.284 1160.89 0h-105.86L667.137 450.887 357.328 0H0l468.492 681.821L0 1226.37h105.866l409.625-476.152 327.181 476.152H1200L714.137 519.284h.026ZM569.165 687.828l-47.468-67.894-377.686-540.24h162.604l304.797 435.991 47.468 67.894 396.2 566.721H892.476L569.196 687.854v-.026Z"/></svg>
          </a>
          <a href="https://www.pinterest.com/" class="footer-soc-link" target="_blank" rel="noopener" title="Pinterest" aria-label="Pinterest">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 24 24"><path d="M12.017 0C5.396 0 .029 5.367.029 11.987c0 5.079 3.158 9.417 7.618 11.162-.105-.949-.199-2.403.041-3.439.219-.937 1.406-5.957 1.406-5.957s-.359-.72-.359-1.781c0-1.663.967-2.911 2.168-2.911 1.024 0 1.518.769 1.518 1.688 0 1.029-.653 2.567-.992 3.992-.285 1.193.6 2.165 1.775 2.165 2.128 0 3.768-2.245 3.768-5.487 0-2.861-2.063-4.869-5.008-4.869-3.41 0-5.409 2.562-5.409 5.199 0 1.033.394 2.143.889 2.741.099.12.112.225.085.345-.09.375-.293 1.199-.334 1.363-.053.225-.172.271-.401.165-1.495-.69-2.433-2.878-2.433-4.646 0-3.776 2.748-7.252 7.951-7.252 4.168 0 7.392 2.967 7.392 6.923 0 4.135-2.607 7.462-6.233 7.462-1.214 0-2.354-.629-2.758-1.379l-.749 2.848c-.269 1.045-1.004 2.352-1.498 3.146 1.123.345 2.306.535 3.55.535 6.607 0 11.985-5.365 11.985-11.987C23.97 5.367 18.592 0 12.017 0z"></path></svg>
          </a>
          <a href="https://www.youtube.com/" class="footer-soc-link" target="_blank" rel="noopener" title="YouTube" aria-label="YouTube">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 24 24"><path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"></path></svg>
          </a>
          <a href="https://www.indeed.com/" class="footer-soc-link" target="_blank" rel="noopener" title="Indeed" aria-label="Indeed">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 24 24"><path d="M6.34 21.05l-4.52-4.53A2.08 2.08 0 0 1 1 15.06V2.05A1.05 1.05 0 0 1 2.05 1h4.15a1.05 1.05 0 0 1 1.05 1.05v13.56l3.52 3.52-4.43 4.42zm7.65-4.2h9.24a.8.8 0 0 1 .8.8v3.42a.8.8 0 0 1-.8.8H14a5.05 5.05 0 0 1-3.6-1.5l-4.32-4.32 4.43-4.42 1.62 1.62a2.03 2.03 0 0 0 1.86.6zm6.3-15.85a3.5 3.5 0 1 1-3.5 3.5 3.5 3.5 0 0 1 3.5-3.5z"></path></svg>
          </a>
          <a href="https://www.linkedin.com/in/kamrujjaman-mufti/" class="footer-soc-link" target="_blank" rel="noopener" title="LinkedIn" aria-label="LinkedIn">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 24 24"><path d="M22.23 0H1.77C.8 0 0 .77 0 1.72v20.56C0 23.23.8 24 1.77 24h20.46c.98 0 1.77-.77 1.77-1.72V1.72C24 .77 23.2 0 22.23 0zM7.12 20.45H3.56V9h3.56v11.45zM5.34 7.43a2.06 2.06 0 1 1 0-4.13 2.06 2.06 0 0 1 0 4.13zm15.11 13.02h-3.56v-5.56c0-1.32-.02-3.02-1.84-3.02-1.84 0-2.12 1.44-2.12 2.92v5.66H9.37V9h3.41v1.56h.05c.48-.9 1.64-1.84 3.36-1.84 3.59 0 4.25 2.36 4.25 5.43v6.3z"></path></svg>
          </a>
        </div>
"@

$files = Get-ChildItem -Filter *.html
foreach ($file in $files) {
    if ($file.Name -eq "temp.html" -or $file.Name -eq "tmp.html") { continue }
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace the existing footer-social div with the new SVG-based one
    $content = $content -replace '(?s)<div class="footer-social">.*?</div>(\s*<a href="/contact")', "$newSocialHtml`$1"
    
    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
    Write-Host "Updated $($file.Name)"
}
