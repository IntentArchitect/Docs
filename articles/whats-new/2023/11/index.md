# November 2023

Welcome to the November 2023 edition of highlights of What's New with Intent Architect.

- Highlights
- More updates
  - **[Email Address Validation](#email-address-validation)** - "Email Address" checkbox property added to the "Validation" stereotype.

## Update details

### Email Address Validation

An "Email Address" checkbox property has been added to the "Validation" stereotype, when checked it applies the [Email Validator](https://docs.fluentvalidation.net/en/latest/built-in-validators.html#email-validator) in FluentValidation modules and the [EmailAddressAttribute](https://learn.microsoft.com/dotnet/api/system.componentmodel.dataannotations.emailaddressattribute) in DataAnnotations modules.

Available from:

- Intent.Application.FluentValidation 3.8.3
- Intent.Application.FluentValidation.Dtos 3.7.1
- Intent.Application.MediatR.FluentValidation 4.4.2
- Intent.Blazor.HttpClients.Dtos.DataAnnotations 1.0.1
- Intent.Blazor.HttpClients.Dtos.FluentValidation 1.0.1
