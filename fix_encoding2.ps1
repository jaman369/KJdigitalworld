 = "d:\ZAMAN\Ai Folder\Kj Digital World"
 = Get-ChildItem -Path  -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch "node_modules" -and $_.FullName -notmatch "\.git" -and $_.FullName -notmatch "tmp\.html" }

 = New-Object System.Text.UTF8Encoding $false

foreach ( in ) {
     = [System.IO.File]::ReadAllText(.FullName, [System.Text.Encoding]::UTF8)
     = 
    
     = .Replace("ðŸ” ", "🔍")
     = .Replace("ðŸŽ¯", "🎯")
     = .Replace("ðŸŒ ", "🌐")
     = .Replace("âœ ï¸ ", "✍️")
     = .Replace("â€”", "—")
     = .Replace("Â·", "·")
     = .Replace("Portfolio \?" Digital World A Kamrujjaman", "Portfolio — Digital World · Kamrujjaman")
     = .Replace("Blog \?" Digital World A Kamrujjaman", "Blog — Digital World · Kamrujjaman")
    
    if ( -cne ) {
        [System.IO.File]::WriteAllText(.FullName, , )
        Write-Output "Fixed encoding in $(.Name)"
    }
}
