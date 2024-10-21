# What's new in Intent Architect (November 2024)

Welcome to the November 2024 edition of highlights of What's New in Intent Architect.

- Highlights
  - **[Hangfire Scheduler](#hangfire-scheduler-module)** - This module allows you to model scheduled jobs in the Services Designer. These scheduled job are then realized using [Hangfire](http://www.hangfire.io)
  - **[Google Cloud Storage Module](#google-cloud-storage-module)** - New support for Google Cloud Storage integration in .NET applications.
  - **[Generate a .gitignore file](#gitignore-file-generation)** - Automatically generate a .NET .gitignore file for your application
  - **[Command field default values](#command-field-default-values)** - Default values configured on Command fields are now used in the Command constructor

## Update details

### Hangfire Scheduler Module

This module allows you to model scheduled jobs in the Services Designer. These scheduled job are then realized using the [Hangfire](https://hangfire.io/).

![Modeled scheduled jobs](images/hangfire-services-modeler.png)

See the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Hangfire/README.md) for more details.

Available from:

- Intent.Hangfire 1.0.0

### Google Cloud Storage Module

The `Google Cloud Storage` module for .NET provides an easier-to-use API via the `ICloudStorage` interface. This release simplifies interactions such as uploading, downloading, listing, and deleting objects with Google Cloud Storage, enabling developers to focus more on business logic and less on backend infrastructure.

For more details, refer to the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Google.CloudStorage/README.md).

Available from:

- Intent.Google.CloudStorage 1.0.0

### .gitignore file generation

You can now specify the inclusion of a .NET .gitignore file as part of your application.

![.gitignore setting](images/gitignore-setting.png)

Available from:

- Intent.VisualStudio.Projects 3.8.2

### Command field default values

When a default values is set on a Command field in the Services Designer:

![command field default value](images/command-services-designer.png)

The value will now pull through and be used on the Command constructor:

![command constructor](images/command-constructor.png)

Available from:

- Intent.Application.MediatR 4.2.9
- Intent.Modelers.Services.CQRS 5.0.1
