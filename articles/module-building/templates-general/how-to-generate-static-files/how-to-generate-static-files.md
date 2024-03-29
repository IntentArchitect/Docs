---
uid: module-building.templates-general.how-to-generate-static-files
---
# How to generate static files

This article will explain a more effective way to generate many files that are static in nature during a Software Factory Execution without having to create an individual Template for each one.

## Create a Module

Inside Intent Architect create a new Module for example `MyStaticContent` and click on `NEXT`. There is no need to specify an additional programming language for this Module so you may click on `CREATE` when done.

Open the `Module Builder` designer and create a `New Static Content Template` in the package provided for this Module. Give the template a name for example `MyHtmlFiles`. In the properties panel specify the following:

* Content Subfolder. Give it the path for example `htmlFiles`.
* Binary File Globbing Patterns. Supply file globbing patterns, to identify "binary" files in your content, this would include any file which should not be processed as text based files .
* Role. Give it the name of `Static.Html` for example.

>[!NOTE]
>The `Content Subfolder` can be left blank if you're only expecting to make one Static Content Template.

Save and run the Software Factory Execution.

## Setting up the content folder

In your Module project where your Visual Studio project is located for your Module, copy the content that you wish to distribute with your Module, inside the `content/htmlFiles` (example) folder.

## Setting up a relative output location prefix

In situations like having static content files be placed in a Solution Folder of the Visual Studio designer, it may be useful to have the relative output paths prefixed with one or more sub folders so that the output will be placed in these sub-folders on the file system, but these "prefixed" folders will not cause generation of Solution Folders within the `.sln` file.

Simply override the `RelativeOutputPathPrefix` getter property to do this:

```csharp
public override string RelativeOutputPathPrefix => "InRoot/SubFolderOfInRoot";
```

## Content custom keyword substitution

Though the content being processed will be static, there is a **basic keyword substitution** feature which can be set inside the Registration class by populating the `Replacements` property.

For example:

```cs
public override IReadOnlyDictionary<string, string> Replacements => new Dictionary<string, string> { {"Today", DateTime.Today.ToString("yyyy-MM-dd")} };
```

So any file content that features the following phrase `<#= Today #>` will be replaced by the Date for the current day when the content was generated.

> [!IMPORTANT]
> Please ensure that a single space is preserved between the `<#=`, `keyword` and `#>` symbols.

## Binary File Globbing Patterns

>[!NOTE]
>Binary File support was introduced Intent Architect v4.1, `Intent.Common` v3.5.0 and `Intent.ModuleBuilder` v3.7.0  modules, ensure you have at least this versions installed for this to work.

These patterns are used to identify binary or non text based files, so that they don't get processed as text based templates. This patterns are standard `File globbing` patterns,  for more information [see](https://learn.microsoft.com/dotnet/core/extensions/file-globbing).
The standard exclusions are images (jpg, png, ico), excel files and pdfs. This list can be adapted to your specific requirements.

```text
*.jpg
*.png
*.ico
*.xlsx
*.pdf
``````
