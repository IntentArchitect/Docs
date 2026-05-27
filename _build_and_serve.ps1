./_build.ps1

Start-Process "http://localhost:8080/"
Start-Process "dotnet" -Wait -NoNewWindow -ArgumentList "docfx", "serve", "_site"
