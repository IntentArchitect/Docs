param(
    [Parameter(Mandatory=$true)]
    [string]$RootPath,          # e.g. E:\Intent.Docs\articles
    [Parameter(Mandatory=$true)]
    [string]$BaseUrl,           # e.g. https://docs.intentarchitect.com/articles
    [string]$OutputFile
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (!(Test-Path -LiteralPath $RootPath -PathType Container)) {
    throw "RootPath not found or not a folder: $RootPath"
}

$rootFull = (Resolve-Path -LiteralPath $RootPath).Path.TrimEnd('\','/')
if ($BaseUrl -notmatch '/$') { $BaseUrl += '/' }

function Get-RelativeToRoot {
    param([string]$Root, [string]$Full)
    if (-not $Full.StartsWith($Root, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "File is not under root. Root: '$Root'  File: '$Full'"
    }
    $Full.Substring($Root.Length).TrimStart('\','/')
}

function To-UrlPath {
    param([string]$RelFsPath)

    if ($RelFsPath -notlike '*.md') { return $null }

    # Normalize separators to URL style and change extension to .html
    $p = $RelFsPath -replace '\\','/'
    $p = [Regex]::Replace($p, '\.md$', '.html', 'IgnoreCase')

    # encode each segment
    $segments = $p -split '/'
    $encoded = foreach ($s in $segments) {
        if ([string]::IsNullOrWhiteSpace($s)) { continue }
        [Uri]::EscapeDataString($s)
    }

    ($encoded -join '/')
}

$files = Get-ChildItem -LiteralPath $rootFull -Recurse -File -Filter *.md

$urls = foreach ($f in $files) {
    $relFs = Get-RelativeToRoot -Root $rootFull -Full $f.FullName
    $relUrl = To-UrlPath -RelFsPath $relFs
    if ($relUrl) { $BaseUrl.TrimEnd('/') + '/' + $relUrl.TrimStart('/') }
}

$urls = $urls | Sort-Object -Unique

if ($OutputFile) {
    $dir = Split-Path -Path $OutputFile -Parent
    if ($dir -and !(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    Set-Content -LiteralPath $OutputFile -Value ($urls -join [Environment]::NewLine) -Encoding UTF8
    Write-Host "Wrote $($urls.Count) URLs to $OutputFile"
} else {
    $urls
}
