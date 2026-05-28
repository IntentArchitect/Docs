# This script should be executed from the root folder of the "Docs" repo
# Example execution: .\merge-local-docs.ps1 "C:\path\to\modules-common" "C:\path\to\modules-dotnet" "modules-common" "modules-dotnet"

param(
    # The source folder path for the first module
    [string]$sourceFolderPath1,
    # The source folder path for the second module
    [string]$sourceFolderPath2,
    # The name of the folder in docs where the files from the first module should be placed
    [string]$moduleOutputFolder1,
    # The name of the folder in docs where the files from the second module should be placed
    [string]$moduleOutputFolder2
)

Write-Host "`$sourceFolderPath1=$sourceFolderPath1"
Write-Host "`$sourceFolderPath2=$sourceFolderPath2"
Write-Host "`$moduleOutputFolder1=$moduleOutputFolder1"
Write-Host "`$moduleOutputFolder2=$moduleOutputFolder2"

./PipelineScripts/merge-repo-docs.ps1 $sourceFolderPath1 $moduleOutputFolder1
./PipelineScripts/merge-repo-docs.ps1 $sourceFolderPath2 $moduleOutputFolder2
