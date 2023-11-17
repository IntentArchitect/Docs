# Intent JSON Metadata Synchronizer

The Intent JSON Metadata Synchronizer CLI tool can be used to synchronize an object graph in a JSON file into an Intent Architect Document DB Domain Package.

This can be useful for doing most, if not all, the work of capturing a pre-existing a JSON document's object graph in the Domain designer for when you are using a Document store as your persistence.

## Pre-requisites

Latest Long Term Support (LTS) version of [.NET](https://dotnet.microsoft.com/download).

## Installation

The tool is available as a [.NET Tool](https://docs.microsoft.com/dotnet/core/tools/global-tools) and can be installed with the following command:

```powershell
dotnet tool install Intent.MetadataSynchronizer.Json.CLI --global --prerelease
```

> [!NOTE]
> If `dotnet tool install` fails with an error to the effect of `The required NuGet feed can't be accessed, perhaps because of an Internet connection problem.` and it shows a private NuGet feed URL, you can try add the `--ignore-failed-sources` command line option ([source](https://learn.microsoft.com/dotnet/core/tools/troubleshoot-usage-issues#nuget-feed-cant-be-accessed)).

You should see output to the effect of:

```text
You can invoke the tool using the following command: intent-json-metadata-synchronizer
Tool 'intent.metadatasynchronizer.json.cli' (version 'x.x.x') was successfully installed.
```

## Usage

`intent-json-metadata-synchronizer [options]`

### Options

|Option                                   |Description|
|-----------------------------------------|-----------|
|`--config-file <config-file>`            |Path to a [JSON formatted file](#configuration-file) containing options to use for execution of this tool as an alternative to using command line options. The `--generate-config-file` option can be used to generate a file with all the possible fields populated with null.|
|`--generate-config-file`                 |Scaffolds into the current working directory a "config.json" for use with the `--config-file` option.|
|`--source-json-file <source-json-file>`  |The name of the JSON file to parse and synchronize into the Intent Architect Package.|
|`--isln-file <isln-file>`                |The Intent Architect solution (.isln) file containing the Intent Architect Application into which to synchronize the metadata.|
|`--application-name <application-name>`  |The name of the Intent Architect Application (as per the Application Settings view) containing the Intent Architect Package into which to synchronize the metadata.|
|`--package-id <package-id>`              |The id of the Intent Architect Package containing the Intent Architect Package into which to synchronize the metadata.|
|`--target-folder-id <target-folder-id>`  |The target folder within the Intent Architect package into which to synchronize the metadata. If unspecified then the metadata will be synchronized into the root of the Intent Architect package.|
|`--casing-convention <AsIs|PascalCase>`  |Casing convention to be applied on imported elements. Options are PascalCase or AsIs.|
|`--version`                              |Show version information|
|`-?`, `-h`, `--help`                     |Show help and usage information|

### Configuration file

The `--config-file` option expects the name of a file containing configuration options to be used as an alternative to adding them as CLI options. A template for the configuration file can be generated using the `--generate-config-file` option. The content of the generated template is as follows:

```json
{
  "SourceJsonFile": null,
  "IslnFile": null,
  "ApplicationName": null,
  "PackageId": null,
  "TargetFolderId": null,
  "CasingConvention": "AsIs"
}
```
