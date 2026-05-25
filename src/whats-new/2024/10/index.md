# What's new in Intent Architect (October 2024)

Welcome to the October 2024 edition of highlights of What's New in Intent Architect.

We are thrilled to announce the official release of Intent Architect version 4.3! This update brings a range of exciting new features and enhancements, including powerful front-end design capabilities and much more. You can find the full release details [here](xref:release-notes.intent-architect-v4.3).

To explore the new front-end capabilities in action, don't miss our [Front-end automation with Blazor webinar](https://intentarchitect.com/#/redirect/?category=resources&subCategory=front-end-automation-webinar). Plus, get hands-on experience by checking out our sample implementation [here](https://github.com/IntentArchitect/Intent.Samples.MudBlazor).

- Highlights
  - **[Build Blazor front-ends](#build-blazor-front-ends)** - A new Blazor application template, UI Designers and Blazor modules to model Blazor front-ends.
  - **[Map CQRS Operations and Application Services to Repository Operations](#map-cqrs-operations-and-application-services-to-repository-operations)** - Add bespoke Operations on Repositories in the Domain designer and invoke them from Services using mappings in the Services designer.
  - **[CosmosDB Module Enums stored as String](#cosmosdb-module-enums-stored-as-string)** - CosmosDB module now allows Enums to be stored as strings in your documents.
  - **[OpenTelemetry Module Enhanced with Expanded Configurations and New Export Options](#opentelemetry-module-enhanced-with-expanded-configurations-and-new-export-options)** - The OpenTelemetry module now supports expanded configuration options and introduces a new export option.
  - **[Import Stored Procedures for Repositories](#import-stored-procedures-for-repositories)** - Import definitions of Stored Procedures from SQL Server into your Domain Repository.
  - **[C# code management: Overriding return statements is now easier](#c-code-management-overriding-return-statements-is-now-easier)** - Return statements can now be ignored more simply.
  - **[Specify implicit (global) usings for .csproj files](#specify-implicit-global-usings-for-csproj-files)** - Add custom global usings to projects from the Visual Studio designer.
  - **[XML doc comment generation for repositories](#xml-doc-comment-generation-for-repositories)** - Comments are now generated as XML doc comments.

## Update details

### Build Blazor front-ends

We have a new Blazor application template to quickly setup and model your front-end Blazor applications.

![New Blazor Application Template](images/blazor-application-template.png)

This will create an Intent Architect application for modeling Blazor applications using the MudBlazor component library.

For a comprehensive overview, check out our [Front-end automation with Blazor webinar](https://intentarchitect.com/#/redirect/?category=resources&subCategory=front-end-automation-webinar). Plus, get hands-on experience by checking out our sample implementation [here](https://github.com/IntentArchitect/Intent.Samples.MudBlazor).

Available from:

- Intent Architect 4.3+
- Intent.Blazor 1.0.0-beta.1

### Map CQRS Operations and Application Services to Repository Operations

Add Operations on Repositories in the Domain designer and invoke them from Services using mappings in the Services designer.

Example Repository with Operation:

![Example Domain](images/repository-operation-mapping-domain.png)

Example Command:

![Example Command](images/repository-operation-mapping-command-menu.png)

Example invocation from Command to Repository Operation:

![Mapping between Command and Repository](images/repository-operation-mapping-service-invocation.png)

![Data Mapping](images/repository-operation-mapping-invocaiton-mapping.png)

Available from:

- Intent.Modelers.Services.DomainInteractions 1.1.4

Ensure you are using at least the versions of the following modules (if you have them installed):

- Intent.Application.MediatR.CRUD 6.0.12
- Intent.Application.ServiceImplementations.Conventions.CRUD 5.0.9

### CosmosDB Module Enums stored as String

CosmosDB module now allows Enums to be stored as strings in your documents.

You can switch this on with the "Store enums as string" setting.

![Store Enums As String Setting](images/store-enum-as-string-setting.png)

The Document's that represent Entities in the Infrastructure layer will then decorate the Enum Properties with a `JsonConverter` attribute when the setting is switched on.

```c#
[JsonConverter(typeof(EnumJsonConverter))]
public EnumExample EnumExample { get; set; }
```

This will allow Enums to be persisted in CosmosDB as `strings` however it is also durable in that it can also parse Enums in their `int` representations allowing for backward compatibility.

Available from:

- Intent.CosmosDB 1.2.4

### OpenTelemetry Module Enhanced with Expanded Configurations and New Export Options

The OpenTelemetry module now features expanded configuration options, allowing users to enable metrics alongside the previously available traces and logs. Additional instrumentation has been introduced with Trace or Metric indicators, providing greater flexibility in monitoring applications.

![Full Module Settings](images/opentelemtry-full-module-settings.png)

Moreover, a new export option, "Azure Monitor OpenTelemetry Distro," has been added, which offers hybrid capabilities that blend OpenTelemetry and Azure Application Insights' proprietary features, such as "Live Metrics."

![Azure Monitor Open Telemetry Distro](images/opentelemetry-az-ot-distro.png)

Users can also configure the application instance name in conjunction with the application service name for better identification.

```json
"OpenTelemetry": {
    "ServiceName": "My Sample Service",
    "ServiceInstanceId": "Development"
}
```

Available from:

- Intent.OpenTelemetry 2.2.0

### Import Stored Procedures for Repositories

Import definitions of Stored Procedures from SQL Server into your Domain Repository.

You can right click on a Repository and select `Stored Procedure Import`.

![Stored Procedure Import Operations](images/sp-import-operations.png)

Specify names of stored procedures as a comma separated list.

![Import prompt](images/sp-import-prompt.png)

Import Stored Procedures either as Operations or Specialized elements.

![Stored Proc Types](images/sp-stored-proc-types.png)

> [!NOTE]
>
> Stored Procedure elements will be phased out in favor of using Operations once the Operations variant has reached parity with the specialized elements.

Available from:

- Intent.SqlServerImporter 1.0.6

### C# code management: Overriding return statements is now easier

Previously when wanting to "override" a generated return statement in a fully managed method you would need to qualify the `// IntentIgnore` with a `(Match = "return")`, now only a simple `// IntentIgnore` is required:

```csharp
// Generated:
[IntentFully]
public int Method()
{
    return 0;
}

// What was previously required to override the return statement:
[IntentFully]
public int Method()
{
    // IntentIgnore(Match = "return")
    return 1;
}

// What is now required to override the return statement:
[IntentFully]
public int Method()
{
    // IntentIgnore
    return 1;
}
```

Available from:

- Intent.OutputManager.RoslynWeaver 4.7.7

### Specify implicit (global) usings for .csproj files

It is now possible to specify [implicit usings](https://learn.microsoft.com/dotnet/core/project-sdk/overview#implicit-using-directives) (global usings) to add to `.csproj` files:

![Example of using custom implicit usings in the Visual Studio designer](images/vs-designer-implicit-usings.png)

The above will then add the following to the `.csproj` file:

```xml
<ItemGroup>
  <Using Include="System.Transactions" />
</ItemGroup>
```

Available from:

- Intent.VisualStudio.Projects 3.8.1

### XML doc comment generation for repositories

- Comments captured on repositories and their operations in the Domain designer will now cause corresponding [XML doc comments](https://learn.microsoft.com/dotnet/csharp/language-reference/xmldoc/) to also be generated in the output files.
