#Requires -Version 7
param(
    [string] $BaseUrl              = 'https://docs.intentarchitect.com/docs-md/',
    [switch] $FailOnUnresolvedXref
)

Write-Host "If 'docfx' is not found, ensure you have installed it using _install_tools.ps1"
& dotnet docfx src/docfx.json
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

./_remove-404-from-sitemap.ps1

$exportArgs = @{
    SourceRoot          = 'src'
    OutRoot             = '_site/docs-md'
    UseAbsoluteLinks    = $true
    BaseUrl             = $BaseUrl
    RootLlmsTxtPath     = '_site/llms.txt'
    RootLlmsFullTxtPath = '_site/llms-full.txt'
}
if ($FailOnUnresolvedXref) { $exportArgs['FailOnUnresolvedXref'] = $true }

./PipelineScripts/export-agent-markdown.ps1 @exportArgs
