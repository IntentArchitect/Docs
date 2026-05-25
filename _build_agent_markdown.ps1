$ErrorActionPreference = "Stop"

./PipelineScripts/export-agent-markdown.ps1 `
  -SourceRoot        "src" `
  -OutRoot           "_site/docs-md" `
  -RootLlmsTxtPath   "_site/llms.txt"
