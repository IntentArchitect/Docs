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
