# What's new in Intent Architect (February 2025)

Welcome to the February 2025  edition of highlights of What's New in Intent Architect.

- Updates
  - **[Destructive Changes Detection](#destructive-changes-detection)** - Easily spot changes to manually written code in the Software Factory changes view (4.4 Feature).
  - **[Module-based Contextual Help](#module-based-contextual-help)** - New help topics have been added to many of our existing modules (4.4 Feature).
  - **[Data Masking Support](#data-masking-module)** - Mask sensitive data from unauthorized users when using Entity Framework Core.
  - **[Temporal Table Support](#temporal-table-module)** - SQL Server/Azure SQL Temporal table support is now available, enabling tracking of historical data changes.
  - **[Custom Validation Messages](#custom-validation-messages)** - Add custom validation messages for `Regular Expression` and `Must` validations.

## Update details

### Destructive changes detection

Sometimes the Software Factory wants to make changes to code which was manually written and should be reviewed to avoid possible loss of custom code, however, these changes may be easily missed if they are interspersed between other file changes which are benign as they are for code which was not manually written.

The Software Factory changes view will now bring attention to changes which are known to be "destructive" of user written code:

![Destructive change example](images/destructive-change-example.png)

A pending change is deemed as having destructive changes when it is removing or replacing code which is known to have been added manually.

Available from:

- Intent Architect 4.4.0
- Intent.OutputManager.RoslynWeaver 4.9.0

### Module-based Contextual Help

With the release of Intent Architect 4.4, many of our modules have been enhanced to leverage the new contextual help feature. Now, when pressing F1 within any designer, you will receive module-specific help topics tailored to the modules you have installed. This feature is context-sensitive, meaning that pressing F1 on a Model will present relevant documentation specific to that context.

Additionally, all existing module documentation has been migrated to our website under the respective "Modules" sections. These topics remain accessible via the in-product help system, allowing for seamless navigation between in-app guidance and comprehensive online documentation.

![Help Topics](images/module-help-topics.png)

### Data Masking Module

It is now possible to mask specific `properties` on a `class` with `data masking` requirements.

Several masking types are available, with built-in security integration to ensure that authorized users can still access the unmasked data.

![Data Masking Properties](images/data-masking.png)

Available from:

- Intent.EntityFrameworkCore.DataMasking 1.0.0-beta.3

### Temporal Table Module

`Classes` can now be marked as `Temporal Tables`, allowing SQL Server/Azure SQL to automatically track historical data changes, even after updates or deletions.

The module configures Entity Framework Core and updates relevant `repositories` for easy retrieval of historical data.

![Temporal Tables](images/temporal-tables.png)

Available from:

- Intent.EntityFrameworkCore.TemporalTables 1.0.0-beta.2

### Custom Validation Messages

Custom validation messages can now be specified for `Regular Expression` and `Must` validations.

Available from:

- Intent.Application.FluentValidation 3.10.1
- Intent.Application.FluentValidation.Dtos 3.11.1
- Intent.Application.MediatR.FluentValidation 4.8.1
