$files = Get-ChildItem -Filter portfolio*.html
$newStats = @"
        <div class="portfolio-stats">
          <div class="portfolio-stat">
            <div class="p-stat-num"><span class="cnt" data-target="50">0</span>+</div>
            <div class="p-stat-label">Projects Delivered</div>
          </div>
          <div class="portfolio-stat">
            <div class="p-stat-num"><span class="cnt" data-target="35">0</span>+</div>
            <div class="p-stat-label">Happy Clients</div>
          </div>
          <div class="portfolio-stat">
            <div class="p-stat-num"><span class="cnt" data-target="11">0</span>+</div>
            <div class="p-stat-label">Countries</div>
          </div>
          <div class="portfolio-stat">
            <div class="p-stat-num"><span class="cnt" data-target="5">0</span>+</div>
            <div class="p-stat-label">Years Experience</div>
          </div>
        </div>
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
    if ($file.Name -eq "temp.html" -or $file.Name -eq "tmp.html") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace the old stats block
    $content = $content -replace '(?s)<div class="portfolio-stats">.*?</div>\s*</div>\s*</section>', "$newStats`n      </div>`n    </section>"
    
    # Inject JS if not present
    if ($content -notmatch "const animate = \(\) => \{") {
        $content = $content -replace '</body>', $jsSnippet
    }
    
    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
    Write-Host "Fixed $($file.Name)"
}
