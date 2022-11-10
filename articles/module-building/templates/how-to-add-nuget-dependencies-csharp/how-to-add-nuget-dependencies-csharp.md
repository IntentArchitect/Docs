---
uid: module-building.templates.how-to-add-nuget-dependencies-csharp
---
# How to add nuget dependencies (C#)

Templates made in Intent Architect will produce source code for C# and that would inevitably be reliant on a 3rd party library. Templates allow you to define such dependencies by using the `AddNugetDependency` method.

Example of a Template introducing a nuget dependency:

```csharp
[IntentManaged(Mode.Merge, Signature = Mode.Fully)]
partial class MappingProfileTemplate : CSharpTemplateBase<object>
{
    [IntentManaged(Mode.Fully)]
    public const string TemplateId = "Intent.Application.AutoMapper.MappingProfile";

    [IntentManaged(Mode.Merge, Signature = Mode.Fully)]
    public MappingProfileTemplate(IOutputTarget outputTarget, object model = null) : base(TemplateId, outputTarget, model)
    {
        AddNugetDependency(NugetPackages.AutoMapper);
    }
...
```

> [!IMPORTANT]
> Ensure that you invoke this method only within the `Constructor` of the Template or in the overridden `BeforeTemplateExecution` method. Otherwise it will not reflect when the Software Factory execution occurs.
>
> [!TIP]
> A good practice is to keep your nuget package references in a class within your Module instead of defining them in each Template. This makes maintenance easier when nuget packages have to be revised or updated.
>
> Example of such a class:
>
> ```csharp
> using Intent.Modules.Common.VisualStudio;
> 
> namespace Intent.Modules.Application.AutoMapper;
> 
> public static class NugetPackages
> {
>     public static INugetPackageInfo AutoMapper = new NugetPackageInfo("AutoMapper", "10.1.1");
> }
> ```

Once the Template executes in the Software Factory, it will introduce this `PackageReference` in the Visual Studio Project file that contains the generated file.

```xml
<ItemGroup>
    <PackageReference Include="AutoMapper" Version="10.1.1" />
    ...
</ItemGroup>
```

> [!NOTE]
> Intent Architect does not define where the nuget packages come from. Your package sources need to be defined when Visual Studio or MSBuild tries to fetch those nuget packages. Thus, you can create your own privately held nuget packages and host it in your own privately hosted location and allow Intent Architect to still reference those packages.
