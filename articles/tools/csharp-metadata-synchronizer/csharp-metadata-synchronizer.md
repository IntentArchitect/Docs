# Intent C# Metadata Synchronizer

The Intent C# Metadata Synchronizer CLI tool can be used to synchronize your `cs` files into an Intent Architect Domain package.

This tool can be useful for creating Intent Architect Domain Packages based on your C# Class `cs` files.

## Pre-requisites

Latest Long Term Support (LTS) version of [.NET](https://dotnet.microsoft.com/download).

## Installation

The tool is available as a [.NET Tool](https://docs.microsoft.com/dotnet/core/tools/global-tools) and can be installed with the following command:

```powershell
dotnet tool install Intent.MetadataSynchronizer.CSharp.CLI --global --prerelease
```

> [!NOTE]
> If `dotnet tool install` fails with an error to the effect of `The required NuGet feed can't be accessed, perhaps because of an Internet connection problem.` and it shows a private NuGet feed URL, you can try add the `--ignore-failed-sources` command line option ([source](https://learn.microsoft.com/dotnet/core/tools/troubleshoot-usage-issues#nuget-feed-cant-be-accessed)).

You should see output to the effect of:

```text
You can invoke the tool using the following command: intent-csharp-metadata-synchronizer
Tool 'intent.metadatasynchronizer.csharp.cli' (version 'x.x.x') was successfully installed.
```

## Usage

`intent-csharp-metadata-synchronizer [options]`

### Options

| Option                                  | Description                                                                                                                                                                                                                                                                     |
|-----------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `--config-file <config-file>`           | Path to a [JSON formatted file](#configuration-file) containing options to use for execution of this tool as an alternative to using command line options. The `--generate-config-file` option can be used to generate a file with all the possible fields populated with null. |
| `--generate-config-file`                | Scaffolds into the current working directory a "config.json" for use with the `--config-file` option.                                                                                                                                                                           |
| `--isln-file <isln-file>`               | The Intent Architect solution (.isln) file containing the Intent Architect Application into which to synchronize the metadata.                                                                                                                                                  |
| `--domain-entities-folder`              | This folder location will be used to sync the C# Classes/Records contained within it as Domain Entities.                                                                                                                                                                        |
| `--domain-enums-folder`                 | This folder location will be used to sync the C# Enums contained within it as Domain Enums.                                                                                                                                                                                     |
| `--domain-services-folder`              | This folder location will be used to sync the C# Classes/Records contained within it as Domain Services.                                                                                                                                                                        |
| `--domain-repositories-folder`          | This folder location will be used to sync the C# Classes/Records contained within it as Domain Repositories.                                                                                                                                                                    |
| `--domain-data-contracts-folder`        | This folder location will be used to sync the C# Classes/Records contained within it as Domain Data Contracts.                                                                                                                                                                  |
| `--service-dtos-folder`                 | This folder location will be used to sync the C# Classes/Records contained within it as Service DTOs.                                                                                                                                                                           |
| `--service-enums-folder`                | This folder location will be used to sync the C# Classes contained within it as Service Enums.                                                                                                                                                                                  |
| `--value-objects-folder`                | This folder location will be used to sync the C# Classes/Records contained within it as Value Objects.                                                                                                                                                                          |
| `--application-name <application-name>` | The name of the Intent Architect Application (as per the Application Settings view) containing the Intent Architect Package into which to synchronize the metadata.                                                                                                             |
| `--package-id <package-id>`             | The id of the Intent Architect Package containing the Intent Architect Package into which to synchronize the metadata.                                                                                                                                                          |
| `--designer-name <designer-name>`       | The name of the Designer where the package is located. i.e. "Domain" or "Services". Defaults to "Domain".                                                                                                                                                                       |
| `--target-folder-id <target-folder-id>` | The target folder within the Intent Architect package into which to synchronize the metadata. If unspecified then the metadata will be synchronized into the root of the Intent Architect package.                                                                              |
| `--allow-removal <bool>`                | Remove previously imported data which is no longer being imported?                                                                                                                                                                                                              |
| `--version`                             | Show version information                                                                                                                                                                                                                                                        |
| `-?`, `-h`, `--help`                    | Show help and usage information                                                                                                                                                                                                                                                 |

### Configuration file

The `--config-file` option expects the name of a file containing configuration options to be used as an alternative to adding them as CLI options. A template for the configuration file can be generated using the `--generate-config-file` option. The content of the generated template is as follows:

```json
{
  "DomainEntitiesFolder": null,
  "DomainEnumsFolder": null,
  "DomainServicesFolder": null,
  "DomainRepositoriesFolder": null,
  "DomainDataContractsFolder": null,
  "ServiceEnumsFolder": null,
  "ServiceDtosFolder": null,
  "ValueObjectsFolder": null,
  "IslnFile": null,
  "ApplicationName": null,
  "PackageId": null,
  "DesignerName": null,
  "TargetFolderId": null,
  "AllowRemoval": true
}
```
