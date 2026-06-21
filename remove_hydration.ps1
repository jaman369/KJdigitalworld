$files = Get-ChildItem -Path "d:\ZAMAN\Ai Folder\Kj Digital World" -Filter "*.html"
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Remove the Lovable React hydration script
    $content = $content -replace '<script class="\$tsr" id="\$tsr-stream-barrier">.*?</script>', ''
    $content = $content -replace '<script type="module" async="">import\(".*?"\)</script>', ''
    
    # Write back
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Hydration removed."
