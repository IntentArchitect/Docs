# This script should be executed from the root folder of the "Docs" repo.
# The module repo must already be checked out at $moduleFolderName before calling this.
# Example execution: .\PipelineScripts\merge-repo-docs.ps1 "Intent.Modules.NET" "modules-dotnet"

param(
    # The folder containing the already-checked-out module repo (relative to docs root)
    [string]$moduleFolderName,
    # The name of the folder in docs/src where the files should be placed
    [string]$moduleOutputFolder
)

$ErrorActionPreference = "Stop"

Write-Host "`$moduleFolderName=$moduleFolderName"
Write-Host "`$moduleOutputFolder=$moduleOutputFolder"

$fullModulePath = (Resolve-Path $moduleFolderName).Path

# get all "README.md" files in a docs folder under the module folder name and order them by the fullname
$files = Get-ChildItem -Path "$fullModulePath" -Recurse -Filter "README.md" |
    Where-Object { $_.DirectoryName -replace '\\', '/' -match '/docs$' } |
    Sort-Object FullName

$numberOfFiles = $files.Count
Write-Host "Number of files found: $numberOfFiles"

Set-Location "src"

# create the toc file for the module folder
New-Item -Path $moduleOutputFolder -ItemType Directory -Force
$tocPath = Join-Path -Path $moduleOutputFolder -ChildPath "toc.yml"
Set-Content -Path $tocPath -Value "items:"

foreach ($file in $files) {
    Write-Host "Found matching file: $($file.FullName)"

    # Scan the file contents for the markdown header (starts with #)
    $firstHeader = Get-Content $($file.FullName) | Where-Object { $_ -match '^#' } | Select-Object -First 1
    if ($firstHeader) {

        # strip out the # from the header, to be left with the module name
        $moduleName = $firstHeader -replace '^#\s*', ''

        # To lower the module name and replace the "." with "-"
        $destinationModuleFolderName = $moduleName.ToLower() -replace '\.', '-'
        $destinationModuleFileName = "$destinationModuleFolderName.md"
        $relativeModuleFolder = Join-Path -Path $destinationModuleFolderName -ChildPath "$destinationModuleFolderName.md"

        # update the toc
        Add-Content -Path $tocPath -Value "  - name: $moduleName"
        Add-Content -Path $tocPath -Value "    href: $relativeModuleFolder"
        Add-Content -Path $tocPath -Value ""

        # the full output path
        # example, modules-dotnet\intent-application-mediatr-fluentvalidation
        $fullDestinationFolder = Join-Path -Path $moduleOutputFolder -ChildPath $destinationModuleFolderName

        # Check if the folder structure exists; if not, create it
        if (-not (Test-Path -Path $fullDestinationFolder)) {
            New-Item -Path $fullDestinationFolder -ItemType Directory -Force
            Write-Host "Folder structure created: $fullDestinationFolder"
        } else {
            Write-Host "Folder structure already exists: $fullDestinationFolder"
        }

        # final output with the folder + filename
        # example, modules-dotnet\intent-application-mediatr-fluentvalidation\intent-application-mediatr-fluentvalidation.md
        $destinationFullPath = Join-Path -Path $fullDestinationFolder -ChildPath $destinationModuleFileName

        Write-Host "Copying '$($file.FullName)' to '$destinationFullPath'"
        Copy-Item -Path $($file.FullName) -Destination $destinationFullPath

        # copy images folder if it exists
        $sourceFolder = [System.IO.Path]::GetDirectoryName($file.FullName)
        $sourceFolder = Join-Path -Path $sourceFolder -ChildPath "images"

        if (Test-Path -Path $sourceFolder) {
            Write-Host "Copying images folder: '$sourceFolder'"
            Copy-Item -Path $sourceFolder -Destination $fullDestinationFolder -Force -Recurse
        } else {
            Write-Host "No images folder to copy: '$sourceFolder'"
        }
    } else {
        Write-Host "No header found - skipping file"
    }
}

Set-Location ..
