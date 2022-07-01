---
uid: module-building.templates.how-to-generate-static-files
---
# How to generate static files

This article will explain a more effective way to generate many files that are static in nature during a Software Factory Execution without having to create an individual Template for each one.

## Create a Module

Inside Intent Architect create a new Module for example `MyStaticContent` and click on `NEXT`. There is no need to specify an additional programming language for this Module so you may click on `CREATE` when done.

Open the `Module Builder` designer and create a `New Static Content Template` in the package provided for this Module. Give the template a name for example `MyHtmlFiles`. In the properties panel specify the following:

* Content Subfolder. Give it the path for example `htmlfiles`.
* Role. Give it the name of `Static.Html` for example.

>[!NOTE]
>The `Content Subfolder` can be left blank if you're only expecting to make one Static Content Template.

Save and run the Software Factory Execution.

## Setting up the content folder

In your Module project where your Visual Studio project is located for your Module, copy the content that you wish to distribute with your Module, inside the `content/htmlfiles` (example) folder.

## Content custom keyword substitution

Though the content being processed will be static, there is a **basic keyword substitution** feature which can be set inside the Registration class by populating the `Replacements` property.

For example:

```cs
public override IReadOnlyDictionary<string, string> Replacements => new Dictionary<string, string> { {"Today", DateTime.Today.ToString("yyyy-MM-dd")} };
```

So any file content that features the following phrase `<#= Today #>` will be replaced by the Date for the current day when the content was generated.

> [!IMPORTANT]
> Please ensure that a single space is preserved between the `<#=`, `keyword` and `#>` symbols.
