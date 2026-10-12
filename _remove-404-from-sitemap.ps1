param(
    [string]$SitePath = '_site'
)

$sitemapPath = Join-Path $SitePath 'sitemap.xml'
if (Test-Path $sitemapPath) {
    [xml]$sitemap = Get-Content $sitemapPath
    $ns = New-Object System.Xml.XmlNamespaceManager($sitemap.NameTable)
    $ns.AddNamespace("sm", "http://www.sitemaps.org/schemas/sitemap/0.9")
    $urlsToRemove = @($sitemap.SelectNodes("//sm:url[sm:loc[contains(., '/404.html')]]", $ns))

    # Also remove pages marked `_noindex: true` in their frontmatter (e.g. archived pages),
    # which the template renders as <meta name="robots" content="noindex">.
    foreach ($url in $sitemap.SelectNodes("//sm:url", $ns)) {
        $relativePath = [uri]::UnescapeDataString(([uri]$url.loc).AbsolutePath).TrimStart('/')
        $htmlPath = Join-Path $SitePath $relativePath
        if ((Test-Path $htmlPath -PathType Leaf) -and
            (Select-String -Path $htmlPath -Pattern '<meta name="robots" content="noindex">' -SimpleMatch -Quiet)) {
            $urlsToRemove += $url
        }
    }

    foreach ($url in $urlsToRemove) { $url.ParentNode.RemoveChild($url) | Out-Null }
    $sitemap.Save((Resolve-Path $sitemapPath).Path)
}
