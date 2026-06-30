[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Read vercel.json to extract rewrites
$vercelJsonPath = Join-Path (Get-Location) "vercel.json"
$rewrites = @()
if (Test-Path $vercelJsonPath) {
    $vercelConfig = Get-Content $vercelJsonPath -Raw | ConvertFrom-Json
    if ($vercelConfig.rewrites) {
        $rewrites = $vercelConfig.rewrites
    }
}

# Resolve link function based on vercel.json rewrites
function Resolve-VercelLink {
    param (
        [string]$link
    )

    $linkPath = $link.Split('?')[0].Split('#')[0]
    if (-not $linkPath.StartsWith("/")) {
        $linkPath = "/" + $linkPath
    }

    # Check if this link looks like a static asset/file rather than an HTML page route
    $isAsset = $linkPath -match '\.(png|jpe?g|gif|svg|webp|ico|js|css|json|woff2?|ttf|otf|mp4|webm|pdf|docx?|xlsx?)$'

    # Match against Vercel rewrites in order
    foreach ($rule in $rewrites) {
        # If it's a static asset, don't fall back to the index.html routing rewrite
        if ($isAsset -and $rule.destination -eq "/index.html") {
            continue
        }

        $pattern = "^" + $rule.source + "$"
        if ($linkPath -match $pattern) {
            $capture = $Matches[1]
            $destination = $rule.destination
            # If destination uses $1, replace it with the captured group
            if ($destination.Contains('$1') -and $capture) {
                $destination = $destination.Replace('$1', $capture)
            }
            return $destination
        }
    }
    return $linkPath
}

# Cache for URL validation to speed up execution
$global:httpCache = @{}

function Check-LinkExists {
    param (
        [string]$originalLink,
        [string]$resolvedPath
    )

    # If it is a remote URL
    if ($resolvedPath -match '^https?://') {
        # Check cache first
        if ($global:httpCache.ContainsKey($resolvedPath)) {
            return $global:httpCache[$resolvedPath]
        }

        # LinkedIn and Indeed block automated checks, treat as valid if the format is correct
        if ($resolvedPath -match 'linkedin\.com' -or $resolvedPath -match 'indeed\.com') {
            $global:httpCache[$resolvedPath] = $true
            return $true
        }

        try {
            $response = Invoke-WebRequest -Uri $resolvedPath -Method Head -TimeoutSec 5 -UseBasicParsing -ErrorAction Stop
            if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 400) {
                $global:httpCache[$resolvedPath] = $true
                return $true
            }
        } catch {
            try {
                $response = Invoke-WebRequest -Uri $resolvedPath -Method Get -TimeoutSec 5 -UseBasicParsing -ErrorAction Stop
                if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 400) {
                    $global:httpCache[$resolvedPath] = $true
                    return $true
                }
            } catch {
                $global:httpCache[$resolvedPath] = $false
                return $false
            }
        }
        $global:httpCache[$resolvedPath] = $false
        return $false
    }

    # Normalize local path
    $cleanPath = $resolvedPath.Split('?')[0].Split('#')[0]
    if ($cleanPath.StartsWith("/")) {
        $cleanPath = $cleanPath.Substring(1)
    }

    if ([string]::IsNullOrEmpty($cleanPath)) {
        return $true # Root is always valid
    }

    # URL decode to handle spaces (%20) and other encoded characters in local filesystems
    $cleanPath = [uri]::UnescapeDataString($cleanPath)

    # Resolve local path
    $localFilePath = Join-Path (Get-Location) $cleanPath.Replace('/', [System.IO.Path]::DirectorySeparatorChar)
    if (Test-Path $localFilePath) {
        return $true
    }

    return $false
}

# Find all HTML files, ignoring temp/tmp files
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" | Where-Object { $_.Name -notin "temp.html", "tmp.html" }

$issues = [System.Collections.Generic.List[string]]::new()

foreach ($file in $htmlFiles) {
    Write-Host "Scanning $($file.Name)..."
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Check title
    if ($content -match '<title>(.*?)</title>') {
        $title = $Matches[1]
        if ([string]::IsNullOrWhiteSpace($title)) {
            $issues.Add("$($file.Name): Empty <title> tag")
        }
    } else {
        $issues.Add("$($file.Name): Missing <title> tag")
    }

    # Check meta description
    $hasMetaDesc = $false
    $metaMatches = [regex]::Matches($content, '(?i)<meta\s+[^>]*name=["'']description["''][^>]*>')
    if ($metaMatches.Count -gt 0) {
        foreach ($meta in $metaMatches) {
            if ($meta.Value -match 'content=["''](.*?)["'']') {
                $desc = $Matches[1]
                if (-not [string]::IsNullOrWhiteSpace($desc)) {
                    $hasMetaDesc = $true
                }
            }
        }
    }
    # Check alternative layout (content before name)
    if (-not $hasMetaDesc) {
        $metaMatchesAlt = [regex]::Matches($content, '(?i)<meta\s+[^>]*content=["'']([^"'']+)["''][^>]*name=["'']description["''][^>]*>')
        if ($metaMatchesAlt.Count -gt 0) {
            $hasMetaDesc = $true
        }
    }
    
    if (-not $hasMetaDesc) {
        $issues.Add("$($file.Name): Missing meta description")
    }

    # Extract all links (href="...")
    $hrefMatches = [regex]::Matches($content, '(?i)href=["'']([^"'']+)["'']')
    foreach ($m in $hrefMatches) {
        $link = $m.Groups[1].Value
        # Skip absolute links (non-proxied), mailto, tel, anchor hashes, CSS fonts, etc.
        if ($link -match '^mailto:' -or $link -match '^tel:' -or $link -match '^#' -or $link -match '^javascript:') {
            continue
        }
        # External URLs
        if ($link -match '^https?://') {
            if ($link -match 'fonts.googleapis.com' -or $link -match 'fonts.gstatic.com') {
                continue
            }
            if (-not (Check-LinkExists -originalLink $link -resolvedPath $link)) {
                $issues.Add("$($file.Name): Broken external link -> $link")
            }
            continue
        }
        
        # Resolve path using Vercel rewrites
        $resolved = Resolve-VercelLink -link $link
        if (-not (Check-LinkExists -originalLink $link -resolvedPath $resolved)) {
            $issues.Add("$($file.Name): Broken link/asset -> $link (resolved: $resolved)")
        }
    }

    # Extract all images/scripts (src="...")
    $srcMatches = [regex]::Matches($content, '(?i)src=["'']([^"'']+)["'']')
    foreach ($m in $srcMatches) {
        $src = $m.Groups[1].Value
        if ($src -match '^data:' -or $src -match '^javascript:') {
            continue
        }
        if ($src -match '^https?://') {
            if (-not (Check-LinkExists -originalLink $src -resolvedPath $src)) {
                $issues.Add("$($file.Name): Broken external resource -> $src")
            }
            continue
        }
        
        # Resolve path using Vercel rewrites
        $resolved = Resolve-VercelLink -link $src
        if (-not (Check-LinkExists -originalLink $src -resolvedPath $resolved)) {
            $issues.Add("$($file.Name): Missing resource -> $src (resolved: $resolved)")
        }
    }
}

$issues | Out-File -FilePath "issues.txt" -Encoding utf8
Write-Output "Scan complete. Found $($issues.Count) issues. Output written to issues.txt"
