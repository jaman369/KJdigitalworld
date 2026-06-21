$dir = "d:\ZAMAN\Ai Folder\Kj Digital World"
$files = Get-ChildItem -Path $dir -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch "node_modules" -and $_.FullName -notmatch "\.git" -and $_.FullName -notmatch "tmp\.html" }

$utf8NoBom = New-Object System.Text.UTF8Encoding $false

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $original = $content
    
    $content = $content.Replace("ðŸ” ", "🔍")
    $content = $content.Replace("ðŸŽ¯", "🎯")
    $content = $content.Replace("ðŸŒ ", "🌐")
    $content = $content.Replace("âœ ï¸ ", "✍️")
    $content = $content.Replace("â€”", "—")
    $content = $content.Replace("Â·", "·")
    
    if ($content -cne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Output "Fixed encoding in $($file.Name)"
    }
}
