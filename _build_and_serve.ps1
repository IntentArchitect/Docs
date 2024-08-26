Write-Host "If the 'docfx.exe' doesn't run, ensure you've installed it using _install_tools.ps1"
Start-Process "http://localhost:8080/"
Start-Process "dotnet" -Wait -NoNewWindow -ArgumentList "docfx", "docfx.json", "--serve"
