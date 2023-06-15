# June 2023

Welcome to the June 2023 edition of highlights of What's New with Intent Architect.

- Product updates
- Module updates (C#)
- Pre-released Module updates (C#)
  - **[Generate contracts only for services](#generate-contracts-only-for-services)** - Optionally turn off generation of implementations for a `Service` modelled in the Service designer.

## Product updates

## Module updates (C#)

## Pre-released Module updates (C#)

### Generate contracts only for services

It is now possible to specify that only contracts should be generated for a service by applying the `Contract Only` Stereotype to a Service. When applied, the interface ("contract") for the service will still be generated, but no implementation and corresponding dependency injection registration.

Available from:

- Intent.Application.ServiceImplementations 4.3.0 (pre)

### Version AspNetCore.NET services

Apply version information to Commands, Queries or Service elements in your service designer to make use of the `Microsoft.AspNetCore.Mvc.Versioning` library. Create an `OpenAPI Package` inside your Services designer, add a `Version Definition` (add a few versions to it) and then apply the `API Version` stereotype to the services you wish to version.

Available from:

- Intent.AspNetCore.Versioning 1.0.0 (pre)
- Intent.Metadata.WebApi 4.2.0 (pre)
- Intent.AspNetCore.Controllers 5.2.0 (pre)
- Intent.AspNetCore.Controllers.Dispatch.MediatR 5.2.0 (pre)
