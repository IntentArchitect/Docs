---
uid: module-building.templates-csharp.how-to-model-nuget-dependencies-csharp
---
# How to model NuGet dependencies (C#)

Often when building modules the generated patterns require NuGet packages are installed. These NuGet dependencies can be modeled and managed within the module building ecosystem.

> [!NOTE]
> This functionality is available from `Intent.ModuleBuilder.CSharp` v3.6.*.

If this example we will model our module having a dependency on the `Microsoft.EntityFrameworkCore` NuGet package.

- Right-Click on the `Module Builder` root and select `Add NuGet Packages`

![Add `NuGet Packages`](./images/add-nuget-packages.png)

- Right-Click on the `NuGet Packages` element and select `Add NuGet Package`

![Add A `NuGet Package`](./images/add-nuget-package.png)

- Type in the name of the NuGet package you have a dependency on e.g. `Microsoft.EntityFrameworkCore`, `MediatR`, etc.

![Fill in the package name](./images/capture-package-name.png)

- Right-Click on the package you added select `Get latest from NuGet.org`

This will get let latest version information and configure the latest versions to be installed per .Net Framework version. This process is addative and will update existing entries. (It will not remove any existing entries.)

> [!NOTE]
> You can get latest for all packages by performing `Get latest from NuGet.org` on the `NuGet Packages` element.

![Update version info from NuGet](./images/get-latest-versions.png)

See the relevant versioning information under the package.

![Versions Captured](./images/versions.png)

> [!NOTE]
> The versions are `>=`, in this example version `7.0.20` will be used for `.net6` and `.net7`, while `8.0.8` will be used for `.net8`.

At this point, if you run the Software Factory is will add a NuGetPackages class to your module. This class is responsible for registering your modules `NuGet` requirements, and has accessor methods for your templates to declare their specific `NuGet` dependencies.

```csharp
public class NugetPackages : INugetPackages
{
    public const string MicrosoftEntityFrameworkCorePackageName = "Microsoft.EntityFrameworkCore";

    public void RegisterPackages()
    {
        NugetRegistry.Register(MicrosoftEntityFrameworkCorePackageName,
            (framework) => framework switch
                {
                    ( >= 8, 0) => new PackageVersion("8.0.8"),
                    ( >= 6, 0) => new PackageVersion("7.0.20"),
                    _ => throw new Exception($"Unsupported Framework `{framework.Major}` for NuGet package '{MicrosoftEntityFrameworkCorePackageName}'"),
                }
            );
    }

    public static NugetPackageInfo MicrosoftEntityFrameworkCore(IOutputTarget outputTarget) 
        => NugetRegistry.GetVersion(MicrosoftEntityFrameworkCorePackageName, outputTarget.GetMaxNetAppVersion());
}
```

Then in your Template you can use the `AddNugetDependency` method:

```csharp
[IntentManaged(Mode.Merge, Signature = Mode.Fully)]
partial class MyTemplateTemplate : CSharpTemplateBase<object>
{
...
    [IntentManaged(Mode.Merge, Signature = Mode.Fully)]
    public MyTemplateTemplate(IOutputTarget outputTarget, object model = null) : base(TemplateId, outputTarget, model)
    {
        AddNugetDependency(NugetPackages.MicrosoftEntityFrameworkCore(outputTarget));
    }
...
```

> [!IMPORTANT]
> The `AddNugetDependency` method call must be invoked in either the `Constructor` or in the overridden `BeforeTemplateExecution` method as the updates to the Visual Studio Project files may not reflect the when the Software Factory execution occurs.

Once the Template executes in the Software Factory, it will introduce a `PackageReference` in the corresponding Visual Studio Project file:

```xml
<ItemGroup>
    <PackageReference Include="EntityFrameworkCore" Version="8.0.8" />
    ...
</ItemGroup>
```

> [!NOTE]
> Actual package restoration is still handled by your IDE (`Visual Studio`, `Rider`, etc.) / `dotnet` commands for package restoration. Refer to the NuGet documentation on how to manage package sources.

## Modules vote on versions

If you have multiple modules installed all requesting the same `NuGet` package, the `Software Factory` will select the highest version of the package, which the modules specify will be used.
For example, If :

`Module1` wants  `EntityFrameworkCore` `8.0.7` and,
`Module2` wants  `EntityFrameworkCore` `8.0.8`,

`EntityFrameworkCore` `8.0.8` will be installed.

This is true provided none of the modules are `locking` the versions. if there are locked versions the lowest locked version will be used.

## Locking NuGet package versions

If the Module designer you can `lock` you NuGet versions, either at the package level or for a specific .Net Framework Version.

This will do two things

- The `Get latest from NuGet.org` function will not change locked versions.
- When deciding which version of the NuGet package to install the `Software Factory` will favour locked versions.(installing the lowest locked version if there are multiple)

In the example below we can see that the `EntityFrameworkCore` NuGet package is configured such that

For `.net6` and `.net7` the version will be locked at `7.0.20` and will not go above this version
while for `.net8` it's at `8.0.8` and can be bumped up by another module asking for a newer version say `8.0.8` for example.

![Locked versions](./images/locked-version.png)
