$files = Get-ChildItem -Filter *.html

$jsSnippet = @"
<script>
document.addEventListener('DOMContentLoaded', () => {
  const mobToggle = document.getElementById('mobToggle');
  const mobDrawer = document.getElementById('mobDrawer');
  if (mobToggle && mobDrawer) {
    mobToggle.addEventListener('click', () => {
      mobToggle.classList.toggle('open');
      mobDrawer.classList.toggle('open');
    });
    const drawerLinks = mobDrawer.querySelectorAll('a');
    drawerLinks.forEach(link => {
      link.addEventListener('click', () => {
        mobToggle.classList.remove('open');
        mobDrawer.classList.remove('open');
      });
    });
  }
});
</script>
</body>
"@

foreach ($file in $files) {
    if ($file.Name -match "^(temp|tmp|lovable_contact|blog)\.html$") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    # Inject mobile menu JS if not already present
    if ($content -notmatch "const mobToggle = document.getElementById\('mobToggle'\);") {
        $content = $content -replace '</body>', $jsSnippet
        $modified = $true
    }
    
    if ($modified) {
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Updated $($file.Name)"
    }
}
