---
uid: module-building.templates.how-to-effectively-generate-lots-of-static-files
---
# How to effectively generate lots of static files

This article will explain a more effective way to generate many files that are static in nature during a Software Factory Execution without having to create an individual Template for each one.

## Overview

* Provide your static files inside a `content` folder.
* Modify the Module project with regards to the `content` folder.
* Create the Registration class
* Update `.imodspec` file

> [!TIP]
> When using Intent Architect, please ensure that all your modules are kept up to date for the best possible experience. Click on the Updates tab to see which modules can be updated.

## Setting up the content folder

In your Module project where your Visual Studio project is located for your Module, create a folder called `content`. This should be located in the same folder as your project's `.imod` file.

Copy the content, that you wish to distribute with your Module, inside that `content` folder. Note that it may have a nested folder structure and provides keyword substitution in the folder name. For example, giving a folder the name: `${ApplicationName}`, will be substituted during the Software Factory Execution with the name of your targeted Intent Architect application.

So for example, if your content folder looks like this:

* content
  * ${ApplicationName}
    * readme.md

Given that your application is named `MyApplication` (for example) it will be generated like this:

* content
  * MyApplication
    * readme.md

## Modify the Module project

The project file for your Module needs to be modified in order to ensure that the compiler won't interfere with the content.

Open your `csproj` file with a text editor (or in Visual Studio right click on the project and select `Edit`).

Add the following XML snippet between the `<Project Sdk="Microsoft.NET.Sdk">`, `</Project>` elements:

```xml
<ItemGroup>
  <Compile Remove="content\**\*.*" />
</ItemGroup>
```

## Create the Registration class

Inside your Module project ensure that it has the following folder structure in order to create our necessary Registration class.

* Templates
  * FileContent

Inside FileContent, create a class named `StaticContentTemplateRegistrations`:

```cs
using MyModule.Templates.FileContent;

namespace MyModule.Templates.SolutionItems
{
    public class StaticContentTemplateRegistrations : ModuleContentFilesTemplateRegistrations
    {
        public override string TemplateId => "MyModule.StaticContent";
        
        // Optional, you only want contents of this sub-folder to be used for this content.
        public override string ContentSubFolder => "SubFolder";
    }
}
```

## Update .imodspec file

Open up your `.imodspec` file and add the following XML snippet under the `<templates>`, `</templates>` section:

```xml
<template id="MyModule.StaticContent">
  <role>StaticContent</role>
</template>
```

## Content custom keyword substitution

Though the content being processed will be static, there is a basic keyword substitution feature which can be set inside the Registration class by populating the `Replacements` property.

For example:

```cs
public override IReadOnlyDictionary<string, string> Replacements => new Dictionary<string, string> { {"Today", DateTime.Today.ToString("yyyy-MM-dd")} };
```

So any file content that features the following phrase `<#= Today #>` will be replaced by the Date for that day when the content was generated.

> [!IMPORTANT]
> Please ensure that a single space is preserved between the `<#=`, `keyword` and `#>` symbols.
