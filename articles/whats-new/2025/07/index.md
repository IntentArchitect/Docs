# What's new in Intent Architect (July 2025)

Welcome to the July 2025 edition of highlights of What's New in Intent Architect. Here's a roundup of the latest updates and improvements.

- Highlights
  - **[Universal Azure Service Bus Integration](#universal-azure-service-bus-integration)** - Seamlessly integrate Azure Service Bus messaging with ASP.NET Core, Windows Host Services through intelligent host detection.
  - **[Ignore specific lines of C# chained statements](#ignore-specific-lines-of-c-chained-statements)** - Use `// IntentIgnore` on specific lines of method chains in C# files.
  - **[ASP.NET Core Identity Service](#aspnet-core-identity-service)** - Adds the latest ASP.NET Core Identity Service with HTTP Endpoints.
  - **[ASP.NET Core Identity](#aspnet-core-identity)** - The latest `Intent.AspNetCore.Identity` module now exposes the entire Identity model within the Domain Designer.

- More updates
  - **[Suppression of "Namespace does not match folder structure" warnings on eventing contracts](#automatic-suppression-of-namespace-does-not-match-folder-structure-ide0130-warnings-on-generated-eventing-messages)** - No more warnings from eventing contracts when `dotnet_style_namespace_match_folder` is enabled in your `.editorconfig` file.

## Update details

### Universal Azure Service Bus Integration

The Azure Service Bus module now automatically detects your hosting platform and configures appropriate message consumption patterns. Whether you're building ASP.NET Core web applications or Windows Host Services, message handling is automatically configured.

Your host configuration will have this background service running to process incoming messages from an Azure Service Bus queue or topic:

```csharp
builder.Services.AddHostedService<AzureServiceBusHostedService>();
```

To learn more about the Azure Service Bus module, read the [documentation here](https://docs.intentarchitect.com/articles/modules-dotnet/intent-eventing-azureservicebus/intent-eventing-azureservicebus.html).

Available from:

- Intent.Eventing.AzureServiceBus 1.1.0

### Ignore specific lines of C# chained statements

It is now possible to ignore specific lines on chained methods in C# files by adding an `// IntentIgnore` on the line you wish to ignore, for example:

```csharp
void Method()
{
    Member
      .GeneratedChain1()
      // IntentIgnore
      .ManuallyAddedChain()
      .GeneratedChain2();
}
```

This is also documented in our [](xref:application-development.code-weaving-and-generation.about-code-management-csharp#method-chains) article.

Available from:

- Intent.OutputManager.RoslynWeaver 4.9.9

### ASP.NET Core Identity Service

The `Intent.AspNetCore.IdentityService` module exposes the latest ASP.NET Core Identity Services as a HTTP endpoints. This module exposes additional configuration within the Service Designer.

![Service Desginer](images/identity-service-service-designer.png)

This module also allows you to inject the `IIdentityManagerService` and use the functionality in other services.

To learn more about the Identity Service module, read the [documentation here](https://docs.intentarchitect.com/articles/modules-dotnet/intent-aspnetcore-identityservice/intent-aspnetcore-identityservice.html).

### ASP.NET Core Identity

From version `4.2.0` the `Intent.AspNetCore.Identity` module now exposes the ASP.NET Core Identity model within the Domain Designer. This give you more control over how ASP.NET Core Identity is modelled, and you are able to extend any of the model classes.

![Domain Desginer](images/identity-domain-designer.png)

`Intent.AspNetCore.AccountController V4.1.6` and `Intent.AspNetCore.IdentityService V1.2.0` have also been updated with this Module and are extending the default ASP.NET Core Identity `IdentityUser<T>` model.

To learn more about the Identity module, read the [documentation here](https://docs.intentarchitect.com/articles/modules-dotnet/intent-aspnetcore-identity/intent-aspnetcore-identity.html).

### Automatic suppression of "Namespace does not match folder structure (IDE0130)" warnings on generated eventing messages

For de-serialization of eventing message contracts to work between different applications, their namespaces needs to be consistent between them and thus in most cases do not match the folder structure of your Visual Studio project. If `dotnet_style_namespace_match_folder` is enabled in your `.editorconfig` file this causes an [IDE0130](https://learn.microsoft.com/dotnet/fundamentals/code-analysis/style-rules/ide0130) warning to occur during compilation.

To suppress this warning, an assembly attribute like the following is now generated in an `AssemblyAttributes.cs` for each namespace which needs to be suppressed:

```csharp
[assembly: System.Diagnostics.CodeAnalysis.SuppressMessage("Formatting", "IDE0130:Namespace does not match folder structure.", Justification = "Message namespaces need to consistent between applications for deserialization to work", Scope = "namespaceanddescendants", Target = "<namespace>")]
```

Available from:

- Intent.Eventing.Contracts 5.2.1
