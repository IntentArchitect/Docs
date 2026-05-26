Write-Host "If the 'docfx.exe' doesn't run, ensure you've installed it using _install_tools.ps1"
Start-Process "dotnet" -Wait -NoNewWindow -ArgumentList "docfx", "src/docfx.json"

./_remove-404-from-sitemap.ps1

Start-Process "http://localhost:8080/"
Start-Process "dotnet" -Wait -NoNewWindow -ArgumentList "docfx", "serve", "_site"
