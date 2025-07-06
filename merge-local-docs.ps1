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

function Process-ModuleFolder {
    param(
        [string]$sourceFolderPath,
        [string]$moduleOutputFolder
    )

    Write-Host "Processing module folder: $sourceFolderPath"

    # get all "README.md" files in a docs folder under the module folder name and order them by the fullname
    $files = Get-ChildItem -Path "$sourceFolderPath" -Recurse -Filter "README.md" | 
        Where-Object { $_.DirectoryName -replace '\\', '/' -match '/docs$' } |
        Sort-Object FullName

    $numberOfFiles = $files.Count
    Write-Host "Number of files found: $numberOfFiles"

    # switch to the articles folder
    cd "articles"

    # create the toc file for the module folder
    $tocPath = Join-Path -Path $moduleOutputFolder -ChildPath "toc.yml"
    Set-Content -Path $tocPath -Value "items:"

    foreach ($file in $files) {
        Write-Host "Found matching file: $($file.FullName)"

        # Scan the file contents for the markdown header (starts with #)
        $firstHeader = Get-Content $($file.FullName) | Where-Object { $_ -match '^#' } | Select-Object -First 1
        if ($firstHeader) {
            # strip out the # from the header, to be left with the module name
            $moduleName = $firstHeader -replace '^#\s*', ''  
            
            # here we are in the "articles" folder of "Docs". Append the module destination folder
            $destinationRepoFolder = Join-Path -Path (Get-Location) -ChildPath $moduleOutputFolder
            
            # To lower the module name and replace the "." with "-"
            $destinationModuleFolderName = $moduleName.ToLower() -replace '\.', '-'
            $destinationModuleFileName = "$destinationModuleFolderName.md"
            $relativeModuleFolder = Join-Path -Path $destinationModuleFolderName -ChildPath "$destinationModuleFolderName.md"

            # update the toc
            Add-Content -Path $tocPath -Value "  - name: $moduleName"
            Add-Content -Path $tocPath -Value "    href: $relativeModuleFolder"
            Add-Content -Path $tocPath -Value ""

            # the full output path
            $fullDestinationFolder = Join-Path -Path $moduleOutputFolder -ChildPath $destinationModuleFolderName

            # Check if the folder structure exists; if not, create it
            if (-not (Test-Path -Path $fullDestinationFolder)) {
                New-Item -Path $fullDestinationFolder -ItemType Directory -Force
                Write-Host "Folder structure created: $fullDestinationFolder"
            } else {
                Write-Host "Folder structure already exists: $fullDestinationFolder"
            }

            # final output with the folder + filename
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

    cd ..
}

# Process both module folders
Process-ModuleFolder -sourceFolderPath $sourceFolderPath1 -moduleOutputFolder $moduleOutputFolder1
Process-ModuleFolder -sourceFolderPath $sourceFolderPath2 -moduleOutputFolder $moduleOutputFolder2 