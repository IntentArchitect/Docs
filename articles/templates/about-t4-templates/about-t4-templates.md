---
uid: templates.about-t4-templates
---
# About T4 Templates

This article serves the purpose of informing the reader about the essentials of T4 which will be necessary to design Templates for your [Modules](xref:modules.about-modules).

## What T4 Templates are

> ...a T4 text template is a mixture of text blocks and control logic that can generate a text file. The control logic is written as fragments of program code in Visual C# ... The generated file can be text, such as a web page, or a resource file, or program source code in any language.
>
> *- [Microsoft Documentation: Code Generation and T4 Text Templates](https://docs.microsoft.com/en-us/visualstudio/modeling/code-generation-and-t4-text-templates?view=vs-2022)*

Similar concepts in other languages and frameworks:

* [Python: Jinja](https://jinja.palletsprojects.com/en/3.0.x/templates/)
* [React.js: JSX](https://reactjs.org/docs/introducing-jsx.html)
* [ASP.NET Razor](https://www.w3schools.com/asp/razor_syntax.asp)
* [Java Server Pages](https://www.baeldung.com/spring-template-engines#java-server-pages)

> [!NOTE]
> Though your template will be aimed at generating code for a given file or programming language, the control logic of the template itself will be written in C#.

## T4 Text Blocks and Control Blocks

Assume the following template as an example (headers still to follow):

```csharp
using System;
using System.Collections.Generic;

[assembly: DefaultIntentManaged(Mode.Fully)]

namespace <#= Namespace #>
{
    public class <#= ClassName #> : <#= GetBaseType() #>
    {
<#  foreach(var attribute in Model.Attributes) { #>

        public <#= GetTypeName(attribute) #> <#= attribute.Name.ToPascalCase() #> { get; set; }
<#  } #>
<#  foreach(var associationEnd in Model.AssociatedClasses.Where(x => x.IsNavigable)) { #>

        public <#= GetTypeName(associationEnd) #> <#= associationEnd.Name.ToPascalCase() #> { get; set; }
<#  } #>
<#
    foreach (var method in Model.Operations)
    { 
#>

        public <#= GetTypeName(method) #> <#= method.Name.ToPascalCase() #>(<#= string.Join(", ", method.Parameters.Select(s => $"{GetTypeName(s)} {s.Name.ToCamelCase()}")) #>)
        {
            throw new NotImplementedException();
        }
<#
    } 
#>
    }
}
```

### Code Blocks

#### Standard Code Blocks

Notice the use of these symbols: `<#`, `#>`.

```csharp
<#  foreach(var attribute in Model.Attributes) { #>

        public <#= GetTypeName(attribute) #> <#= attribute.Name.ToPascalCase() #> { get; set; }
<#  } #>
```

Based on the example above, notice that the markers `<#` and `#>` help the T4 engine differentiate when it is in a text block and when it is in a code block. Anything that sits between `<#` and `#>` indicates a code block. This is where your C# control logic can be written which will manipulate the template content that gets generated.

In the example above there is `<#  foreach(var attribute in Model.Attributes) { #>` and `<#  } #>` as separate blocks. This is broken up to allow for a text block between them to be generated based on each `attribute` found in `Model.Attributes`.

So if there were two attributes in `Model.Attributes`:

* Type: `string`, Name: `name`
* Type: `int`, Name: `age`

It will generate this (including the whitespace found on that line):

```csharp
        public string Name { get; set; }
        public int Age { get; set; }
```

#### Expression Code Blocks

Notice the use of these symbols: `<#=`, `#>`. Those are markers that tell the T4 engine that the content between them are (expression) control blocks and not text blocks or directives.

```csharp
<#= attribute.Name.ToPascalCase() #>
```

This piece of code will instruct the T4 engine to execute the code expression inside it, expect a result and write out the result to the template at runtime.

So if `attribute.Name` was `firstName` at runtime, it will first evaluate the expression `attribute.Name`, evoke `ToPascalCase()` on that result which will produce `FirstName` and write out `FirstName` in the position where this Control Block is located in the template. You will find an example in the Standard Control Block section.

### Text Blocks

This is text content that will be directly written to the output generated file. These blocks (as mentioned before) may be situated between (standard) code blocks which would mean that based on the control logic, it will be manipulated or it may have (expression) code blocks which will substitute values or expressions inside them.

## T4 Template Header Directives

The next section to cover are the Header Directives. This is at least 1 line of code on top of your T4 file that typically look like this:

```csharp
<#@ template language="C#" inherits="CSharpTemplateBase<object>" #>
<#@ output extension=".cs" #>
<#@ import namespace="System.Collections.Generic" #>
<#@ import namespace="System.Linq" #>
<#@ import namespace="Intent.Modules.Common" #>
<#@ import namespace="Intent.Modules.Common.Templates" #>
<#@ import namespace="Intent.Modules.Common.CSharp.Templates" #>
<#@ import namespace="Intent.Templates" #>
<#@ import namespace="Intent.Metadata.Models" #>
```

Notice the use of these symbols: `<#@` and `#>`. Those are markers that tell the T4 engine that the content between them are directives and not text blocks or control blocks. Directives gives the T4 engine clear instructions on how to generate the content that follows after them.

### Template Directive

```csharp
<#@ template language="C#" inherits="CSharpTemplateBase<object>" #>
```

Instructs the T4 template that the control logic should be interpreted as C# code and that the template control logic should inherit a .NET class `CSharpTemplateBase<object>`. This will expose any methods, properties, etc. to the template which the developer can leverage when developing templates for their own Modules.

### Output Extension Directive

```csharp
<#@ output extension=".cs" #>
```

This directive is typically not needed for designing templates for your Modules, but it sometimes is handy to tell your IDE what kind of output file extension you're busy with so that you *might* get some syntax color highlighting for the actual template content and not just for the control logic blocks.

### Namespace Directive

```csharp
<#@ import namespace="System.Collections.Generic" #>
```

Instructs the T4 template to also include Types found at the namespace `System.Collections.Generic` to be included in this template for use.

## Learn more

* [Code Generation and T4 Text Templates](https://docs.microsoft.com/en-us/visualstudio/modeling/code-generation-and-t4-text-templates?view=vs-2022)