#Requires -Version 7
<#
.SYNOPSIS
    Publish a clean, stable, link-resolved Markdown mirror of the existing documentation for AI agents.

.DESCRIPTION
    Copies source Markdown files to $OutRoot, resolves DocFX xref: links into normal Markdown
    links, and generates supplementary files (llms.txt, index.md, toc.md, xrefmap.yml).

    DocFX continues to own the human-facing HTML site (_site/).
    This exporter owns the agent-facing Markdown site (_site/docs-md/).

.PARAMETER SourceRoot
    Root of the docs repository. Default: current directory.

.PARAMETER OutRoot
    Output folder for the generated Markdown corpus. Default: _site/docs-md.

.PARAMETER BaseUrl
    Public URL where the Markdown output will be hosted. Required with -UseAbsoluteLinks.
    Example: https://docs.intentarchitect.com/docs-md/

.PARAMETER UseAbsoluteLinks
    When set, rewrite resolved links to absolute public URLs using BaseUrl.
    When not set, generate relative Markdown links.

.PARAMETER StripDocfxFrontMatter
    When set, remove YAML frontmatter from output Markdown files.
    Default: preserve frontmatter (useful for AI agents and RAG systems).

.PARAMETER FailOnUnresolvedXref
    When set, exit non-zero if any xref: reference cannot be resolved. Use in CI.

.PARAMETER RootLlmsTxtPath
    When specified, write a domain-root llms.txt to this path in addition to the one inside
    OutRoot. Set to the DocFX output folder so it is picked up by the existing blob sync.
    Example: _site/llms.txt

    The llms.txt specification requires the file to be served at the root of the subdomain
    (https://docs.intentarchitect.com/llms.txt), not at a sub-path. Because the pipeline
    syncs _site/ to the blob container root, placing the file in _site/ achieves this.

.PARAMETER VerboseLogging
    When set, print detailed copy/rewrite activity.
#>
param(
    [string] $SourceRoot        = ".",
    [string] $OutRoot           = "_site/docs-md",
    [string] $BaseUrl           = "",
    [string] $RootLlmsTxtPath     = "",
    [string] $RootLlmsFullTxtPath = "",
    [switch] $UseAbsoluteLinks,
    [switch] $StripDocfxFrontMatter,
    [switch] $FailOnUnresolvedXref,
    [switch] $VerboseLogging
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ---------------------------------------------------------------------------
# Shared state
# ---------------------------------------------------------------------------

$script:MarkdownFilesProcessed = 0
$script:AssetsCopied           = 0
$script:XRefsRewritten         = 0
$script:HtmlLinksRewritten     = 0
$script:UnresolvedXrefs        = [System.Collections.Generic.List[string]]::new()
$script:UidMap                 = [System.Collections.Generic.Dictionary[string, hashtable]]::new(
                                     [System.StringComparer]::OrdinalIgnoreCase)

$AssetExtensions = [System.Collections.Generic.HashSet[string]]::new(
    [string[]]@('.png', '.jpg', '.jpeg', '.gif', '.svg', '.webp',
                '.mp4', '.webm', '.mov', '.pdf', '.zip'),
    [System.StringComparer]::OrdinalIgnoreCase
)

$Utf8NoBom = [System.Text.UTF8Encoding]::new($false)

# ---------------------------------------------------------------------------
# Get-OutputPath
#   Maps a source path to an output path, stripping the leading "src/"
#   segment so that documentation sits at the root of OutRoot rather than
#   inside an src/ subdirectory.
# ---------------------------------------------------------------------------
function Get-OutputPath {
    param([string] $SourcePath)

    $absSource = [System.IO.Path]::GetFullPath($SourcePath)
    $absRoot   = [System.IO.Path]::GetFullPath($SourceRoot)
    $absOut    = [System.IO.Path]::GetFullPath($OutRoot)

    $relative = $absSource.Substring($absRoot.Length).TrimStart([char]'\', [char]'/')

    return [System.IO.Path]::Combine($absOut, $relative)
}

# ---------------------------------------------------------------------------
# Get-RelativeMarkdownPath
# ---------------------------------------------------------------------------
function Get-RelativeMarkdownPath {
    param(
        [string] $FromFile,
        [string] $ToFile
    )

    $fromDir = [System.IO.Path]::GetDirectoryName([System.IO.Path]::GetFullPath($FromFile))
    $toAbs   = [System.IO.Path]::GetFullPath($ToFile)

    # Use URI relative path calculation (works cross-platform)
    $fromUri = [System.Uri]::new("file:///" + $fromDir.Replace('\', '/').TrimEnd('/') + '/')
    $toUri   = [System.Uri]::new("file:///" + $toAbs.Replace('\', '/'))

    $relative = $fromUri.MakeRelativeUri($toUri).ToString()
    return $relative  # Already uses forward slashes
}

# ---------------------------------------------------------------------------
# Get-PublicHref
# ---------------------------------------------------------------------------
function Get-PublicHref {
    param(
        [string] $FromOutputFile,
        [string] $ToOutputFile,
        [string] $Fragment = ""
    )

    if ($UseAbsoluteLinks -and $BaseUrl) {
        $absOut    = [System.IO.Path]::GetFullPath($OutRoot)
        $absTo     = [System.IO.Path]::GetFullPath($ToOutputFile)
        $relToOut  = $absTo.Substring($absOut.Length).TrimStart([char]'\', [char]'/').Replace('\', '/')
        $base      = $BaseUrl.TrimEnd('/')
        $href      = "$base/$relToOut"
    } else {
        $href = Get-RelativeMarkdownPath -FromFile $FromOutputFile -ToFile $ToOutputFile
    }

    if ($Fragment) { $href = "$href#$Fragment" }
    return $href
}

# ---------------------------------------------------------------------------
# Decode-UrlText
# ---------------------------------------------------------------------------
function ConvertFrom-UrlEncoding {
    param([string] $Text)
    return [System.Uri]::UnescapeDataString($Text)
}

# ---------------------------------------------------------------------------
# Get-MarkdownMetadata
#   Returns: @{ Uid; Title; H1; HasFrontmatter }
# ---------------------------------------------------------------------------
function Get-MarkdownMetadata {
    param([string] $FilePath)

    $result = @{ Uid = $null; Title = $null; H1 = $null; HasFrontmatter = $false }

    if (-not (Test-Path $FilePath -PathType Leaf)) { return $result }

    $lines = [System.IO.File]::ReadAllLines($FilePath, $Utf8NoBom)
    if ($lines.Count -eq 0) { return $result }

    $frontmatterEnd = -1

    if ($lines[0] -eq '---') {
        $result.HasFrontmatter = $true
        for ($i = 1; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -eq '---' -or $lines[$i] -eq '...') {
                $frontmatterEnd = $i
                break
            }
            if ($lines[$i] -match '^uid:\s*(.+)$') {
                $result.Uid = $Matches[1].Trim().Trim("'").Trim('"')
            }
            if ($lines[$i] -match '^title:\s*(.+)$') {
                $result.Title = $Matches[1].Trim().Trim("'").Trim('"')
            }
        }
    }

    $searchStart = if ($frontmatterEnd -ge 0) { $frontmatterEnd + 1 } else { 0 }
    for ($i = $searchStart; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^#\s+(.+)$') {
            $result.H1 = $Matches[1].Trim()
            break
        }
    }

    return $result
}

# ---------------------------------------------------------------------------
# Split-MarkdownPreservingCodeFences
#   Returns a list of @{ Lines = string[]; IsCode = bool }
#   Lines across all segments, concatenated in order and joined by newline,
#   exactly reproduce the original content.
# ---------------------------------------------------------------------------
function Split-MarkdownPreservingCodeFences {
    param([string] $Content)

    # Normalize line endings so we only deal with LF
    $Content = $Content -replace "`r`n", "`n" -replace "`r", "`n"

    $lines    = $Content -split "`n"
    $segments = [System.Collections.Generic.List[hashtable]]::new()

    $inCode        = $false
    $codeFenceChar = [char]0
    $codeFenceLen  = 0
    $current       = [System.Collections.Generic.List[string]]::new()

    foreach ($line in $lines) {
        if (-not $inCode) {
            if ($line -match '^ {0,3}(```+|~~~+)') {
                $marker = $Matches[1]
                # Flush pending non-code segment
                if ($current.Count -gt 0) {
                    $segments.Add(@{ Lines = $current.ToArray(); IsCode = $false })
                    $current = [System.Collections.Generic.List[string]]::new()
                }
                $inCode        = $true
                $codeFenceChar = $marker[0]
                $codeFenceLen  = $marker.Length
                $current.Add($line)
            } else {
                $current.Add($line)
            }
        } else {
            # Inside a code block: only close on a line that is purely fence chars
            if ($line -match '^ {0,3}(```+|~~~+)\s*$') {
                $marker = $Matches[1]
                if ($marker[0] -eq $codeFenceChar -and $marker.Length -ge $codeFenceLen) {
                    $current.Add($line)
                    $segments.Add(@{ Lines = $current.ToArray(); IsCode = $true })
                    $current       = [System.Collections.Generic.List[string]]::new()
                    $inCode        = $false
                    $codeFenceChar = [char]0
                    $codeFenceLen  = 0
                } else {
                    $current.Add($line)
                }
            } else {
                $current.Add($line)
            }
        }
    }

    # Flush any remaining lines (including unclosed fences)
    if ($current.Count -gt 0) {
        $segments.Add(@{ Lines = $current.ToArray(); IsCode = $inCode })
    }

    return $segments
}

# ---------------------------------------------------------------------------
# Resolve-Xref
# ---------------------------------------------------------------------------
function Resolve-Xref {
    param([string] $Uid)

    if ($script:UidMap.ContainsKey($Uid)) { return $script:UidMap[$Uid] }
    return $null
}

# ---------------------------------------------------------------------------
# Get-ResolvedXrefLink  (internal helper)
# ---------------------------------------------------------------------------
function Get-ResolvedXrefLink {
    param(
        [string] $Uid,
        [string] $LinkText,
        [string] $Fragment,
        [string] $FromOutputFile
    )

    $entry = Resolve-Xref -Uid $Uid
    if ($entry) {
        $displayText = if ($LinkText) { $LinkText } else { $entry.Title }
        $href        = Get-PublicHref -FromOutputFile $FromOutputFile -ToOutputFile $entry.OutputPath -Fragment $Fragment
        $script:XRefsRewritten++
        return "[$displayText]($href)"
    }

    $key = "$Uid (in $FromOutputFile)"
    if (-not $script:UnresolvedXrefs.Contains($key)) {
        $script:UnresolvedXrefs.Add($key)
    }
    if ($VerboseLogging) { Write-Warning "Unresolved xref '$Uid' in $FromOutputFile" }
    return $null  # caller leaves original text unchanged
}

# ---------------------------------------------------------------------------
# Convert-XrefsInText
# ---------------------------------------------------------------------------
function Convert-XrefsInText {
    param(
        [string] $Text,
        [string] $FromOutputFile
    )

    # --- Form 1: [Text](xref:uid), [Text](xref:uid#frag), [Text](xref:uid?q=v) ---
    $Text = [regex]::Replace(
        $Text,
        '\[([^\]]*)\]\(xref:([^\)#\?\s]+)(?:#([^\)\?]*))?(?:\?([^\)]*))?\)',
        {
            param($m)
            $linkText = $m.Groups[1].Value
            $uid      = $m.Groups[2].Value.Trim()
            $fragment = $m.Groups[3].Value
            $query    = $m.Groups[4].Value

            if ($query -match '(?:^|&)text=([^&]*)') {
                $linkText = ConvertFrom-UrlEncoding $Matches[1]
            }

            $resolved = Get-ResolvedXrefLink -Uid $uid -LinkText $linkText `
                                             -Fragment $fragment -FromOutputFile $FromOutputFile
            return ($null -ne $resolved) ? $resolved : $m.Value
        }
    )

    # --- Form 2: <xref:uid>, <xref:uid#frag>, <xref:uid?text=...> ---
    $Text = [regex]::Replace(
        $Text,
        '<xref:([^>#\?\s]+)(?:#([^>\?]*))?(?:\?([^>]*))??>',
        {
            param($m)
            $uid      = $m.Groups[1].Value.Trim()
            $fragment = $m.Groups[2].Value
            $query    = $m.Groups[3].Value

            $linkText = $null
            if ($query -match '(?:^|&)text=([^&]*)') {
                $linkText = ConvertFrom-UrlEncoding $Matches[1]
            }

            $resolved = Get-ResolvedXrefLink -Uid $uid -LinkText $linkText `
                                             -Fragment $fragment -FromOutputFile $FromOutputFile
            return ($null -ne $resolved) ? $resolved : $m.Value
        }
    )

    # --- Form 3: href="xref:uid" in inline HTML attributes ---
    $Text = [regex]::Replace(
        $Text,
        'href="xref:([^"#\?\s]+)(?:#([^"\?]*))?(?:\?([^"]*))?"',
        {
            param($m)
            $uid      = $m.Groups[1].Value.Trim()
            $fragment = $m.Groups[2].Value

            $entry = Resolve-Xref -Uid $uid
            if ($entry) {
                $href = Get-PublicHref -FromOutputFile $FromOutputFile -ToOutputFile $entry.OutputPath -Fragment $fragment
                $script:XRefsRewritten++
                return "href=""$href"""
            }

            $key = "$uid (in $FromOutputFile)"
            if (-not $script:UnresolvedXrefs.Contains($key)) { $script:UnresolvedXrefs.Add($key) }
            if ($VerboseLogging) { Write-Warning "Unresolved xref '$uid' in $FromOutputFile" }
            return $m.Value
        }
    )

    # --- Form 4: @uid shorthand (conservative) ---
    # Only rewrite when the UID is in the map; not part of email addresses (handled by
    # negative lookbehind on word chars / @), not inside inline code (handled by caller).
    $Text = [regex]::Replace(
        $Text,
        '(?<![a-zA-Z0-9_@])@([a-zA-Z][a-zA-Z0-9.\-_]+)',
        {
            param($m)
            $uid   = $m.Groups[1].Value
            $entry = Resolve-Xref -Uid $uid
            if ($entry) {
                $href = Get-PublicHref -FromOutputFile $FromOutputFile -ToOutputFile $entry.OutputPath
                $script:XRefsRewritten++
                return "[$($entry.Title)]($href)"
            }
            return $m.Value
        }
    )

    return $Text
}

# ---------------------------------------------------------------------------
# Convert-HtmlLinksInText
# ---------------------------------------------------------------------------
function Convert-HtmlLinksInText {
    param([string] $Text)

    # Rewrite [Text](path.html) and [Text](path.html#frag) to [Text](path.md...)
    # Skip external links and root-relative/anchor-only links.
    $Text = [regex]::Replace(
        $Text,
        '\[([^\]]*)\]\((?!https?://|mailto:|tel:|#|/)([^#\)\s]+)\.html(#[^\)]*)?\)',
        {
            param($m)
            $linkText = $m.Groups[1].Value
            $path     = $m.Groups[2].Value
            $fragment = $m.Groups[3].Value
            $script:HtmlLinksRewritten++
            return "[$linkText]($path.md$fragment)"
        }
    )

    return $Text
}

# ---------------------------------------------------------------------------
# Convert-IframeEmbeds
#   Replaces HTML iframe embeds with plain Markdown links so LLMs see readable
#   content instead of raw HTML. YouTube embeds become watch links; unrecognised
#   iframes are removed entirely.
# ---------------------------------------------------------------------------
function Convert-IframeEmbeds {
    param([string] $Text)

    $ytWatch = 'https://www.youtube.com/watch?v='

    # DocFX video alert: > [!Video https://www.youtube.com/embed/VIDEO_ID...]
    $Text = [regex]::Replace(
        $Text,
        '>\s*\[!Video\s+https://www\.youtube\.com/embed/([A-Za-z0-9_-]+)[^\]]*\]',
        { param($m) "[Watch video on YouTube](${ytWatch}$($m.Groups[1].Value))" },
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
    )

    # Div-wrapped YouTube iframe: <div ...><iframe ... src="...embed/ID..." ...></iframe></div>
    $Text = [regex]::Replace(
        $Text,
        '<div[^>]*>\s*<iframe[^>]+src="[^"]*youtube\.com/embed/([A-Za-z0-9_-]+)[^"]*"[^>]*>(?:.*?</iframe>)?\s*</div>',
        { param($m) "[Watch video on YouTube](${ytWatch}$($m.Groups[1].Value))" },
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    # Standalone YouTube iframe: <iframe ... src="...embed/ID..." ...></iframe>
    $Text = [regex]::Replace(
        $Text,
        '<iframe[^>]+src="[^"]*youtube\.com/embed/([A-Za-z0-9_-]+)[^"]*"[^>]*>(?:.*?</iframe>)?',
        { param($m) "[Watch video on YouTube](${ytWatch}$($m.Groups[1].Value))" },
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    # Remaining div+iframe (non-YouTube) — remove entirely
    $Text = [regex]::Replace(
        $Text,
        '<div[^>]*>\s*<iframe[^>]*>(?:.*?</iframe>)?\s*</div>',
        '',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    # Remaining bare iframes — remove entirely
    $Text = [regex]::Replace(
        $Text,
        '<iframe[^>]*>(?:.*?</iframe>)?',
        '',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    # YouTube embed links (chapter navigation): rewrite embed URLs to watch URLs with timestamps
    $Text = [regex]::Replace(
        $Text,
        '\[([^\]]+)\]\(https://www\.youtube\.com/embed/([A-Za-z0-9_-]+)([^)]*)\)',
        {
            param($m)
            $linkText   = $m.Groups[1].Value
            $videoId    = $m.Groups[2].Value
            $query      = $m.Groups[3].Value
            $startMatch = [regex]::Match($query, '[?&]start=(\d+)')
            $watchUrl   = "https://www.youtube.com/watch?v=$videoId"
            if ($startMatch.Success -and $startMatch.Groups[1].Value -ne '0') {
                $watchUrl += "&t=$($startMatch.Groups[1].Value)"
            }
            return "[$linkText]($watchUrl)"
        },
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
    )

    return $Text
}

# ---------------------------------------------------------------------------
# Remove-InlineAttributes
#   Strips DocFX inline attribute syntax that is meaningless outside
#   a DocFX build: link attributes [text](url){...} and paragraph class
#   markers {: .classname } / {: #id }.
# ---------------------------------------------------------------------------
function Remove-InlineAttributes {
    param([string] $Text)

    # Inline link attributes: [text](url){...}
    $Text = [regex]::Replace($Text, '(\]\([^)]+\))\{[^}]+\}', '$1')

    # Paragraph/block class attributes: {: .classname } or {: #id }
    $Text = [regex]::Replace($Text, '\{:[^}]+\}', '')

    return $Text
}

# ---------------------------------------------------------------------------
# Remove-InlineCodeSpans / Restore-InlineCodeSpans
#   Temporarily replace `inline code` with opaque tokens so that xref and
#   HTML-link rewriting does not touch content inside backtick spans.
# ---------------------------------------------------------------------------
function Remove-InlineCodeSpans {
    param([string] $Text)

    $placeholders = @{}
    $matchList    = [regex]::Matches($Text, '`[^`\n]+`')
    $result       = $Text

    # Replace from back to front to keep indices valid
    for ($i = $matchList.Count - 1; $i -ge 0; $i--) {
        $m   = $matchList[$i]
        $key = "XZINLINEX${i}XZ"
        $placeholders[$key] = $m.Value
        $result = $result.Remove($m.Index, $m.Length).Insert($m.Index, $key)
    }

    return @{ Text = $result; Placeholders = $placeholders }
}

function Restore-InlineCodeSpans {
    param([string] $Text, [hashtable] $Placeholders)

    foreach ($key in $Placeholders.Keys) {
        $Text = $Text.Replace($key, $Placeholders[$key])
    }
    return $Text
}

# ---------------------------------------------------------------------------
# Remove-YamlFrontmatter
# ---------------------------------------------------------------------------
function Remove-YamlFrontmatter {
    param([string] $Content)

    if ($Content -match '^---[ \t]*\n') {
        return [regex]::Replace(
            $Content,
            '^---[ \t]*\n.*?\n(---|\.\.\.)[ \t]*\n?',
            '',
            [System.Text.RegularExpressions.RegexOptions]::Singleline
        )
    }
    return $Content
}

# ---------------------------------------------------------------------------
# Convert-MarkdownFile
# ---------------------------------------------------------------------------
function Convert-MarkdownFile {
    param(
        [string] $SourceFile,
        [string] $OutputFile
    )

    $content = [System.IO.File]::ReadAllText($SourceFile, $Utf8NoBom)
    if (-not $content) { $content = "" }

    # Normalize to LF so segment logic is consistent
    $content = $content -replace "`r`n", "`n" -replace "`r", "`n"

    if ($StripDocfxFrontMatter) {
        $content = Remove-YamlFrontmatter -Content $content
    }

    $segments = Split-MarkdownPreservingCodeFences -Content $content

    # Process each segment; collect all lines back in order.
    # Because Split-MarkdownPreservingCodeFences distributes every original line
    # to exactly one segment, re-joining all lines with "\n" reproduces the file.
    $allLines = [System.Collections.Generic.List[string]]::new()

    foreach ($seg in $segments) {
        if ($seg.IsCode) {
            $allLines.AddRange([string[]]$seg.Lines)
        } else {
            $text = $seg.Lines -join "`n"

            # Protect inline code spans from xref/HTML rewriting
            $ic      = Remove-InlineCodeSpans -Text $text
            $text    = $ic.Text

            $text    = Convert-XrefsInText      -Text $text -FromOutputFile $OutputFile
            $text    = Convert-HtmlLinksInText  -Text $text
            $text    = Convert-IframeEmbeds     -Text $text
            $text    = Remove-InlineAttributes  -Text $text

            $text    = Restore-InlineCodeSpans -Text $text -Placeholders $ic.Placeholders

            $allLines.AddRange([string[]]($text -split "`n"))
        }
    }

    $finalContent = ($allLines.ToArray()) -join "`n"

    $outputDir = [System.IO.Path]::GetDirectoryName($OutputFile)
    if ($outputDir -and -not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }

    [System.IO.File]::WriteAllText($OutputFile, $finalContent, $Utf8NoBom)
}

# ---------------------------------------------------------------------------
# Get-TocSections  (parses src/toc.yml for llms.txt section generation)
# ---------------------------------------------------------------------------
function Get-TocSections {
    $tocPath = [System.IO.Path]::Combine($script:AbsDocfxSrc, "toc.yml")
    if (-not (Test-Path $tocPath)) {
        return [System.Collections.Generic.List[hashtable]]::new()
    }

    $lines    = [System.IO.File]::ReadAllLines($tocPath, $Utf8NoBom)
    $sections = [System.Collections.Generic.List[hashtable]]::new()
    $current  = $null

    foreach ($line in $lines) {
        if ($line -match '^\s*-\s+name:\s+(.+)$') {
            $current = @{ Name = $Matches[1].Trim().Trim('"').Trim("'"); Href = ''; TopicUid = ''; TopicHref = '' }
            $sections.Add($current)
        }
        elseif ($null -ne $current) {
            if ($line -match '^\s+href:\s+(.+)$')      { $current.Href      = $Matches[1].Trim() }
            if ($line -match '^\s+topicUid:\s+(.+)$')  { $current.TopicUid  = $Matches[1].Trim() }
            if ($line -match '^\s+topicHref:\s+(.+)$') { $current.TopicHref = $Matches[1].Trim() }
        }
    }

    return $sections
}

# ---------------------------------------------------------------------------
# Resolve-SectionUrl  (resolves a toc section to a docs-md URL)
# ---------------------------------------------------------------------------
function Resolve-SectionUrl {
    param([hashtable] $Section, [string] $DocsMdUrl, [string] $AbsOutRoot)

    $base   = $DocsMdUrl.TrimEnd('/')
    $srcOut = $script:AbsOutDocfxSrc

    # URL prefix for content relative to the docs-md root (e.g. "src/" or "")
    $srcUrlPfx = if ($srcOut -ne $AbsOutRoot) {
        $srcOut.Substring($AbsOutRoot.Length).TrimStart('\', '/').Replace('\', '/') + '/'
    } else { '' }

    # 1. topicUid → UidMap lookup (OutputPath is already the full absolute path)
    if ($Section.TopicUid -and $script:UidMap.ContainsKey($Section.TopicUid)) {
        $entry   = $script:UidMap[$Section.TopicUid]
        $relPath = $entry.OutputPath.Substring($AbsOutRoot.Length).TrimStart('\', '/').Replace('\', '/')
        return "$base/$relPath"
    }

    # 2. topicHref → strip fragment, resolve under docfx src output
    if ($Section.TopicHref) {
        $mdPath   = ($Section.TopicHref -replace '#.*$', '').Trim()
        $fullPath = [System.IO.Path]::Combine($srcOut, $mdPath.Replace('/', [System.IO.Path]::DirectorySeparatorChar))
        if (Test-Path $fullPath) { return "$base/$srcUrlPfx$mdPath" }
    }

    # 3. href: folder/toc.yml → find landing page by naming convention
    if ($Section.Href -match '^(.+)/toc\.yml$') {
        $folder = $Matches[1]
        foreach ($candidate in @("$folder/$folder.md", "$folder/overview.md")) {
            $fullPath = [System.IO.Path]::Combine($srcOut, $candidate.Replace('/', [System.IO.Path]::DirectorySeparatorChar))
            if (Test-Path $fullPath) { return "$base/$srcUrlPfx$candidate" }
        }
    }

    # 4. href: direct .md file
    if ($Section.Href -match '\.md') {
        $mdPath   = ($Section.Href -replace '#.*$', '').Trim()
        $fullPath = [System.IO.Path]::Combine($srcOut, $mdPath.Replace('/', [System.IO.Path]::DirectorySeparatorChar))
        if (Test-Path $fullPath) { return "$base/$srcUrlPfx$mdPath" }
    }

    # 5. href: folder/toc.yml → read section's toc.yml and use first resolvable entry
    if ($Section.Href -match '^(.+)/toc\.yml$') {
        $folder     = $Matches[1]
        $subTocPath = [System.IO.Path]::Combine(
            $script:AbsDocfxSrc,
            $folder.Replace('/', [System.IO.Path]::DirectorySeparatorChar), "toc.yml")
        if (Test-Path $subTocPath) {
            foreach ($subLine in [System.IO.File]::ReadAllLines($subTocPath, $Utf8NoBom)) {
                if ($subLine -match '^\s+topicUid:\s+(.+)$') {
                    $uid = $Matches[1].Trim()
                    if ($script:UidMap.ContainsKey($uid)) {
                        $entry   = $script:UidMap[$uid]
                        $relPath = $entry.OutputPath.Substring($AbsOutRoot.Length).TrimStart('\', '/').Replace('\', '/')
                        return "$base/$relPath"
                    }
                }
                if ($subLine -match '^\s+href:\s+(\S+\.md)\s*$') {
                    $relMd    = $Matches[1].Trim()
                    $fullPath = [System.IO.Path]::Combine(
                        $srcOut, $folder.Replace('/', [System.IO.Path]::DirectorySeparatorChar),
                        $relMd.Replace('/', [System.IO.Path]::DirectorySeparatorChar))
                    if (Test-Path $fullPath) {
                        return "$base/$srcUrlPfx$($folder -replace '\\','/')/$($relMd -replace '\\','/')"
                    }
                }
            }
        }
    }

    return $null
}

# ---------------------------------------------------------------------------
# Get-LlmsTxtHref  (internal helper for llms.txt generation)
# ---------------------------------------------------------------------------
function Get-LlmsTxtHref {
    param([string] $RelPath)

    if ($UseAbsoluteLinks -and $BaseUrl) {
        return ($BaseUrl.TrimEnd('/') + '/' + $RelPath.TrimStart('/'))
    }
    return "./$RelPath"
}

# ---------------------------------------------------------------------------
# Write-AgentLlmsTxt
# ---------------------------------------------------------------------------
function Write-AgentLlmsTxt {
    $outFile = [System.IO.Path]::Combine([System.IO.Path]::GetFullPath($OutRoot), "llms.txt")

    $indexHref = Get-LlmsTxtHref "index.md"
    $tocHref   = Get-LlmsTxtHref "toc.md"

    $content = @"
# Intent Architect Documentation

This is the AI-agent-friendly Markdown version of the Intent Architect documentation.

Use these Markdown files instead of scraping the HTML documentation site when answering questions about Intent Architect.

Primary entry points:

- Markdown index: $indexHref
- Markdown table of contents: $tocHref

The source documentation is authored in Markdown and published in this folder with DocFX cross-references resolved to normal Markdown links.
"@

    [System.IO.File]::WriteAllText($outFile, $content, $Utf8NoBom)
    if ($VerboseLogging) { Write-Host "  Generated: $outFile" }
}

# ---------------------------------------------------------------------------
# Write-LlmsFullTxt
#   Concatenates all processed Markdown files into a single llms-full.txt,
#   returning the content string so the caller can also write it to the
#   domain root without re-reading the files.
# ---------------------------------------------------------------------------
function Write-LlmsFullTxt {
    $absOut  = [System.IO.Path]::GetFullPath($OutRoot)
    $outFile = [System.IO.Path]::Combine($absOut, "llms-full.txt")

    $mdFiles = Get-ChildItem -Path $absOut -Filter "*.md" -Recurse |
        Where-Object { $_.Name -notin @("index.md", "toc.md") } |
        Sort-Object FullName

    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine("# Intent Architect - Complete Documentation")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("> This file contains the complete Intent Architect documentation concatenated into a single document for use by LLMs with large context windows.")
    [void]$sb.AppendLine("")

    foreach ($file in $mdFiles) {
        $relPath = $file.FullName.Substring($absOut.Length).TrimStart([char]'\', [char]'/').Replace('\', '/')
        $content = [System.IO.File]::ReadAllText($file.FullName, $Utf8NoBom)
        $content = Remove-YamlFrontmatter -Content $content
        $content = $content.Trim()

        if ($content) {
            [void]$sb.AppendLine("")
            [void]$sb.AppendLine("---")
            [void]$sb.AppendLine("")
            [void]$sb.AppendLine("<!-- Source: $relPath -->")
            [void]$sb.AppendLine("")
            [void]$sb.Append($content)
            [void]$sb.AppendLine("")
        }
    }

    $fullContent = $sb.ToString()
    [System.IO.File]::WriteAllText($outFile, $fullContent, $Utf8NoBom)
    if ($VerboseLogging) { Write-Host "  Generated: $outFile" }

    return $fullContent
}

# ---------------------------------------------------------------------------
# Write-AgentIndex
# ---------------------------------------------------------------------------
function Write-AgentIndex {
    $outFile  = [System.IO.Path]::Combine([System.IO.Path]::GetFullPath($OutRoot), "index.md")

    # Process src/index.agent.md into index.md — the LLM-facing overview entry point.
    # src/index.md (the browser landing page) is skipped from the main loop and never
    # reaches docs-md/; src/index.agent.md is the clean-markdown twin used here instead.
    $agentSrc = [System.IO.Path]::Combine($script:AbsDocfxSrc, "index.agent.md")
    if (Test-Path $agentSrc) {
        Convert-MarkdownFile -SourceFile $agentSrc -OutputFile $outFile
        if ($VerboseLogging) { Write-Host "  Generated: $outFile (from index.agent.md)" }
        return
    }

    # Fallback: index.agent.md absent; write minimal navigation stub.
    $content = @"
---
title: Intent Architect Documentation
---

# Intent Architect Documentation

This is the AI-agent-friendly Markdown version of the Intent Architect documentation.

## Entry Points

- [Table of Contents](toc.md)
- [XRef Map](xrefmap.yml)

Use these Markdown files instead of scraping the HTML documentation site.
"@
    [System.IO.File]::WriteAllText($outFile, $content, $Utf8NoBom)
    if ($VerboseLogging) { Write-Host "  Generated: $outFile (fallback stub)" }
}

# ---------------------------------------------------------------------------
# Write-AgentToc
# ---------------------------------------------------------------------------
function Write-AgentToc {
    $absOut  = [System.IO.Path]::GetFullPath($OutRoot)
    $outFile = [System.IO.Path]::Combine($absOut, "toc.md")

    $mdFiles = Get-ChildItem -Path $absOut -Filter "*.md" -Recurse |
        Where-Object {
            $_.FullName -ne $outFile -and
            $_.Name     -notin @("index.md", "toc.md")
        } |
        Sort-Object FullName

    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add("# Table of Contents")
    $lines.Add("")

    foreach ($file in $mdFiles) {
        $meta  = Get-MarkdownMetadata -FilePath $file.FullName
        $title = if ($meta.Title)  { $meta.Title }
                 elseif ($meta.H1) { $meta.H1 }
                 elseif ($meta.Uid){ $meta.Uid }
                 else              { $file.BaseName }

        # Relative path from the toc.md (in the root of $absOut)
        $fromUri = [System.Uri]::new("file:///" + $absOut.Replace('\', '/').TrimEnd('/') + '/')
        $toUri   = [System.Uri]::new("file:///" + $file.FullName.Replace('\', '/'))
        $relPath = $fromUri.MakeRelativeUri($toUri).ToString()

        $lines.Add("- [$title]($relPath)")
    }

    $content = $lines -join "`n"
    [System.IO.File]::WriteAllText($outFile, $content, $Utf8NoBom)
    if ($VerboseLogging) { Write-Host "  Generated: $outFile" }
}

# ---------------------------------------------------------------------------
# Write-RootLlmsTxt
#   Writes a spec-compliant llms.txt to the domain root (e.g. _site/llms.txt).
#   The llms.txt spec requires the file at the root of the subdomain so that AI
#   agents can discover it at https://docs.intentarchitect.com/llms.txt.
#   The pipeline's existing _site/ blob sync picks it up automatically.
# ---------------------------------------------------------------------------
function Write-RootLlmsTxt {
    param([string] $OutputPath)

    $docsMdUrl = if ($BaseUrl) { $BaseUrl.TrimEnd('/') + '/' } `
                 else          { "https://docs.intentarchitect.com/docs-md/" }

    $htmlBaseUrl = if ($BaseUrl) {
        $uri = [System.Uri]$BaseUrl
        "$($uri.Scheme)://$($uri.Host)/"
    } else {
        "https://docs.intentarchitect.com/"
    }

    $absOutRoot    = [System.IO.Path]::GetFullPath($OutRoot)
    $sections      = Get-TocSections
    $docLines      = [System.Collections.Generic.List[string]]::new()
    $optionalLines = [System.Collections.Generic.List[string]]::new()
    $seenUrls      = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

    $sectionDescriptions = @{
        'Overview'                = 'What Intent Architect is and how it works'
        'Getting started'         = 'Installation, setup, and quick start guide'
        'Key Concepts'            = 'Core concepts: modules, designers, software factory, and code management'
        'Tutorials'               = 'Step-by-step tutorials for building applications with Intent Architect'
        'Application development' = 'Working with designers, the software factory, and code management day-to-day'
        'AI in Intent Architect'  = 'Built-in AI agents, MCP server integration, and AI-assisted development'
        'Module building'         = 'Creating, packaging, and publishing custom Intent Architect modules'
        'Application Templates'   = 'Building reusable templates for bootstrapping new applications'
        'Tools'                   = 'CLI tools: Software Factory CLI, Module Server, and Packager'
        'Getting help'            = 'Support resources, community forums, and feedback channels'
        'Modules (Common)'        = 'Pre-built modules for cross-platform patterns and utilities'
        'Modules (Importers)'     = 'Modules for importing existing codebases and schemas into Intent Architect'
        'Modules (.NET)'          = 'Pre-built modules for .NET application patterns and integrations'
    }

    foreach ($s in $sections) {
        $url = Resolve-SectionUrl -Section $s -DocsMdUrl $docsMdUrl -AbsOutRoot $absOutRoot
        if (-not $url -or -not $seenUrls.Add($url)) { continue }
        $desc = $sectionDescriptions[$s.Name]
        $line = if ($desc) { "- [$($s.Name)]($url): $desc" } else { "- [$($s.Name)]($url)" }
        if ($s.Href -match 'release-notes|whats-new') {
            $optionalLines.Add($line)
        }
        else {
            $docLines.Add($line)
        }
    }

    $docLines.Add("- [Full article index](${docsMdUrl}toc.md): Alphabetical index linking every documentation article")

    $optionalLines.Add("- [Full documentation — single file for large-context LLMs](${htmlBaseUrl}llms-full.txt)")
    $optionalLines.Add("- [Documentation index](${docsMdUrl}index.md)")

    $docSection      = [string]::Join([System.Environment]::NewLine, $docLines)
    $optionalSection = [string]::Join([System.Environment]::NewLine, $optionalLines)

    $content = @"
# Intent Architect

> Intent Architect is a platform for designing software applications and automatically generating production-quality code using customizable, modular blueprints. It lets teams capture architecture decisions as reusable modules and apply them consistently across projects.

## Docs

$docSection

## Optional

$optionalSection
"@

    $absOutputPath = [System.IO.Path]::GetFullPath($OutputPath)
    $outputDir     = [System.IO.Path]::GetDirectoryName($absOutputPath)
    if ($outputDir -and -not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }

    [System.IO.File]::WriteAllText($absOutputPath, $content, $Utf8NoBom)
    if ($VerboseLogging) { Write-Host "  Generated: $absOutputPath" }
}

# ---------------------------------------------------------------------------
# Write-ExportSummary
# ---------------------------------------------------------------------------
function Write-ExportSummary {
    $absOut    = [System.IO.Path]::GetFullPath($OutRoot)
    $absSource = [System.IO.Path]::GetFullPath($SourceRoot)

    Write-Host ""
    Write-Host "Agent Markdown export complete."
    Write-Host ""
    Write-Host "  Source root:               $absSource"
    Write-Host "  Output root:               $absOut"
    Write-Host "  Markdown files processed:  $($script:MarkdownFilesProcessed)"
    Write-Host "  Assets copied:             $($script:AssetsCopied)"
    Write-Host "  UIDs discovered:           $($script:UidMap.Count)"
    Write-Host "  XRefs rewritten:           $($script:XRefsRewritten)"
    Write-Host "  HTML links rewritten:      $($script:HtmlLinksRewritten)"
    Write-Host "  Unresolved XRefs:          $($script:UnresolvedXrefs.Count)"
    Write-Host "  Output index:              $absOut\index.md"
    Write-Host "  Output llms.txt:           $absOut\llms.txt"
    Write-Host "  Output llms-full.txt:      $absOut\llms-full.txt"
    if ($RootLlmsTxtPath) {
        $absRoot = [System.IO.Path]::GetFullPath($RootLlmsTxtPath)
        Write-Host "  Domain-root llms.txt:      $absRoot"
    }
    if ($RootLlmsFullTxtPath) {
        $absRootFull = [System.IO.Path]::GetFullPath($RootLlmsFullTxtPath)
        Write-Host "  Domain-root llms-full.txt: $absRootFull"
    }

    if ($script:UnresolvedXrefs.Count -gt 0) {
        Write-Host ""
        Write-Warning "Unresolved XRefs:"
        $seen = [System.Collections.Generic.HashSet[string]]::new()
        foreach ($ref in $script:UnresolvedXrefs) {
            if ($seen.Add($ref)) {
                Write-Warning "  $ref"
            }
        }
    }
}

# ===========================================================================
# MAIN
# ===========================================================================

$absSourceRoot = [System.IO.Path]::GetFullPath($SourceRoot)
$absOutRoot    = [System.IO.Path]::GetFullPath($OutRoot)

# Directory containing DocFX source content (.md files, toc.yml).
# When $SourceRoot is the repo root ("."): content is in $SourceRoot/src.
# When $SourceRoot is already the src folder ("src"): content is at $SourceRoot.
$script:AbsDocfxSrc = if (Test-Path ([System.IO.Path]::Combine($absSourceRoot, "src", "toc.yml"))) {
    [System.IO.Path]::Combine($absSourceRoot, "src")
} else {
    $absSourceRoot
}

# Output folder that mirrors the DocFX source content within $OutRoot.
$script:AbsOutDocfxSrc = if ($script:AbsDocfxSrc -ne $absSourceRoot) {
    $rel = $script:AbsDocfxSrc.Substring($absSourceRoot.Length).TrimStart('\', '/')
    [System.IO.Path]::Combine($absOutRoot, $rel)
} else {
    $absOutRoot
}

if ($UseAbsoluteLinks -and -not $BaseUrl) {
    Write-Error "-UseAbsoluteLinks requires -BaseUrl to be specified."
    exit 1
}

Write-Host "Exporting agent-friendly Markdown documentation..."
Write-Host "  Source: $absSourceRoot"
Write-Host "  Output: $absOutRoot"
Write-Host ""

# Clean and recreate output folder
if (Test-Path $absOutRoot) {
    Write-Host "Removing existing output folder..."
    Remove-Item -Recurse -Force $absOutRoot
}
New-Item -ItemType Directory -Path $absOutRoot -Force | Out-Null

# ---------------------------------------------------------------------------
# Phase 1: Build UID map
# ---------------------------------------------------------------------------

Write-Host "Phase 1: Building UID map..."

$absArticlesRoot = $absSourceRoot

# Source root files handled specially by Write-AgentIndex / skipped from export:
# - index.md       → browser landing page; uid registers in Phase 1 for xref resolution,
#                    but skipped in Phase 2 (Write-AgentIndex writes clean content instead).
# - index.agent.md → LLM overview source; skipped in Phase 2 (Write-AgentIndex reads it
#                    and writes the output to index.md).
# - 404.md         → browser error page; skipped in both phases.
$srcRootIndexMd      = [System.IO.Path]::Combine($script:AbsDocfxSrc, "index.md")
$srcRootIndexAgentMd = [System.IO.Path]::Combine($script:AbsDocfxSrc, "index.agent.md")
$srcRoot404Md        = [System.IO.Path]::Combine($script:AbsDocfxSrc, "404.md")

$allMdFiles = Get-ChildItem -Path $absArticlesRoot -Filter "*.md" -Recurse

foreach ($file in $allMdFiles) {
    if ($file.FullName -eq $srcRoot404Md) { continue }

    $meta       = Get-MarkdownMetadata -FilePath $file.FullName
    $outputPath = Get-OutputPath -SourcePath $file.FullName

    $title = if ($meta.Title)  { $meta.Title }
             elseif ($meta.H1) { $meta.H1 }
             elseif ($meta.Uid){ $meta.Uid }
             else              { $file.BaseName }

    if ($meta.Uid) {
        $script:UidMap[$meta.Uid] = @{
            SourcePath = $file.FullName
            OutputPath = $outputPath
            Title      = $title
        }
    }
}

Write-Host "  Found $($script:UidMap.Count) UIDs."

# ---------------------------------------------------------------------------
# Phase 2: Copy and process files
# ---------------------------------------------------------------------------

Write-Host "Phase 2: Processing and copying files..."

# Only copy from src/. Everything else (tooling, CI config, branding,
# developer docs) is not relevant to AI agents consuming the documentation.
$allFiles = Get-ChildItem -Path $absArticlesRoot -Recurse |
    Where-Object { -not $_.PSIsContainer }

foreach ($file in $allFiles) {
    if ($file.FullName -in @($srcRootIndexMd, $srcRootIndexAgentMd, $srcRoot404Md)) { continue }

    $ext        = $file.Extension.ToLower()
    $outputPath = Get-OutputPath -SourcePath $file.FullName

    if ($ext -eq '.md') {
        if ($VerboseLogging) { Write-Host "  Processing: $($file.FullName)" }

        Convert-MarkdownFile -SourceFile $file.FullName -OutputFile $outputPath
        $script:MarkdownFilesProcessed++

    } elseif ($AssetExtensions.Contains($ext)) {
        $outputDir = [System.IO.Path]::GetDirectoryName($outputPath)
        if ($outputDir -and -not (Test-Path $outputDir)) {
            New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
        }
        Copy-Item -Path $file.FullName -Destination $outputPath -Force
        $script:AssetsCopied++
        if ($VerboseLogging) { Write-Host "  Asset:      $($file.Name)" }
    }
    # YAML files (toc.yml etc.) are DocFX navigation config — not copied.
}

# ---------------------------------------------------------------------------
# Phase 3: Generate supplementary files
# ---------------------------------------------------------------------------

Write-Host "Phase 3: Generating supplementary files..."

Write-AgentLlmsTxt
Write-AgentIndex
Write-AgentToc
$fullContent = Write-LlmsFullTxt

if ($RootLlmsTxtPath -or $RootLlmsFullTxtPath) {
    Write-Host "Phase 4: Writing domain-root llms files..."

    if ($RootLlmsTxtPath) {
        Write-RootLlmsTxt -OutputPath $RootLlmsTxtPath
    }

    if ($RootLlmsFullTxtPath) {
        $absRootFull = [System.IO.Path]::GetFullPath($RootLlmsFullTxtPath)
        $rootFullDir = [System.IO.Path]::GetDirectoryName($absRootFull)
        if ($rootFullDir -and -not (Test-Path $rootFullDir)) {
            New-Item -ItemType Directory -Path $rootFullDir -Force | Out-Null
        }
        [System.IO.File]::WriteAllText($absRootFull, $fullContent, $Utf8NoBom)
        if ($VerboseLogging) { Write-Host "  Generated: $absRootFull" }
    }
}

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------

Write-ExportSummary

if ($FailOnUnresolvedXref -and $script:UnresolvedXrefs.Count -gt 0) {
    Write-Error "Export failed: $($script:UnresolvedXrefs.Count) unresolved xref(s) found."
    exit 1
}
