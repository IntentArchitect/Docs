param(
    [string]$SitePath = '_site'
)

$sitemapPath = Join-Path $SitePath 'sitemap.xml'
if (Test-Path $sitemapPath) {
    [xml]$sitemap = Get-Content $sitemapPath
    $ns = New-Object System.Xml.XmlNamespaceManager($sitemap.NameTable)
    $ns.AddNamespace("sm", "http://www.sitemaps.org/schemas/sitemap/0.9")
    $urlsToRemove = $sitemap.SelectNodes("//sm:url[sm:loc[contains(., '/404.html')]]", $ns)
    foreach ($url in $urlsToRemove) { $url.ParentNode.RemoveChild($url) | Out-Null }
    $sitemap.Save((Resolve-Path $sitemapPath).Path)
}
