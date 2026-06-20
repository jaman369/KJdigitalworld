[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$content = Get-Content lovable_blog.html -Raw -Encoding UTF8
$content = $content -replace '(?s)<aside\s+id="lovable-badge".*?</aside>', ''
$content = $content -replace '(?s)<script class="\$tsr".*?</script>', ''
$content = $content -replace '(?s)<script type="module" async="">.*?</script>', ''
$content = $content -replace '(?s)<script defer src="/~flock.js".*?</script>', ''
$content = $content -replace '(?s)<script defer src="/__l5e/events.js".*?</script>', ''
$content = $content -replace '(?s)</body>\s*</html>', ''

$filterScript = @"
<script>
  // Category Filtering Logic
  document.addEventListener('DOMContentLoaded', () => {
    const filterChips = document.querySelectorAll('.filter-chip');
    const posts = document.querySelectorAll('.post-card, .featured-card');

    filterChips.forEach(chip => {
      chip.addEventListener('click', () => {
        // Remove active class from all chips
        filterChips.forEach(c => c.classList.remove('active'));
        // Add active class to clicked chip
        chip.classList.add('active');

        const category = chip.getAttribute('data-cat');

        posts.forEach(post => {
          if (category === 'all' || post.getAttribute('data-cat') === category) {
            post.style.display = '';
          } else {
            post.style.display = 'none';
          }
        });
      });
    });
  });
</script>
</body>
</html>
"@

$content = $content + $filterScript
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllText("$pwd\blog.html", $content, $Utf8NoBomEncoding)
