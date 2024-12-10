# This script should be executed from the root folder of the "Docs" repo
# Example execution: .\PipelineScripts\merge-repo-docs.ps1 "development-4.4x" "https://github.com/IntentArchitect/Intent.Modules.NET.git" "Intent.Modules.NET" "modules-dotnet" 0

param(
    # The source branch name
    [string]$sourceBranchName,
    # The module repo URL
    [string]$moduleRepositoryUrl,
    # The default folder in which the module will be cloned into
    [string]$moduleFolderName,
    # The  name of the folder in docs where the the files from the modules repo should be placed
    [string]$moduleOutputFolder,
    # https://docs.microsoft.com/en-us/azure/devops/pipelines/build/variables?view=azure-devops&tabs=yaml#system-variables-devops-services
    [bool]$isOnBuildAgent = $($env:TF_BUILD -eq "True")
)

Write-Host "`$sourceBranchName=$sourceBranchName"
Write-Host "`$moduleRepositoryUrl=$moduleRepositoryUrl"
Write-Host "`$moduleFolderName=$moduleFolderName"
Write-Host "`$moduleOutputFolder=$moduleOutputFolder"
Write-Host "`$isOnBuildAgent=$isOnBuildAgent"

# clone only if the destination folder doesn't already exist
# Before this script is executed a `git clean -fdx` should be run to make sure the module is fresh
# but if it does exists for whatever reason, a git pull is done later to get the latest
if (-not (Test-Path -Path $moduleFolderName)) {
    Write-Host "Cloning module repo"
    git clone $moduleRepositoryUrl
}

cd $moduleFolderName

# Check the remote to see if a branch exists which matches the source branch
$branchExists = git ls-remote --heads origin $sourceBranchName | Select-String -Pattern $sourceBranchName

# either use the source branch name if it exists, or default to "development"
if ($branchExists) {
    Write-Host "Checkout $sourceBranchName"
    git checkout $sourceBranchName
    git pull
} else {
    Write-Host "Checkout development"
    git checkout development
    git pull
}

# detach the folder from git so can be cleaned up
if (Test-Path -Path .git) {
     Remove-Item -Recurse -Force .git
}

# get the full module path for later use. This is where the repo was cloned to
$fullModulePath = (Get-Location).Path
cd ..

# get all "README.md" files in a docs folder under the module folder name and order them by the fullname
$files = Get-ChildItem -Path "$fullModulePath" -Recurse -Filter "README.md" | 
    Where-Object { $_.DirectoryName -replace '\\', '/' -match '/docs$' } |
    Sort-Object FullName

$numberOfFiles = $files.Count
Write-Host "Number of files found: $numberOfFiles"

# switch to the articles folder
cd "articles"

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
        
        # here we are in the "articles" folder of "Docs". Append the module destination folder
        # example, c:\temp\docs\articles\modules-dotnet
        $destinationRepoFolder = Join-Path -Path (Get-Location) -ChildPath $moduleFolderName
        
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

cd..

if (Test-Path -Path $moduleFolderName) {
    Write-Host "Removing '$moduleFolderName'"
    Remove-Item -Path "$moduleFolderName" -Recurse -Force
}