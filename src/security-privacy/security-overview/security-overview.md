---
uid: security-privacy.security-overview
description: "Intent Architect's security posture: a local-first desktop architecture that keeps customer project content in your environment, with limited supporting cloud services and customer-controlled AI providers."
---
# Security Overview

## Executive summary

Intent Architect is a **locally installed software development tool** used by developers on customer-managed workstations. It is architecturally similar to a desktop IDE rather than a hosted SaaS application.

The core security characteristic of Intent Architect is that **customer project content remains primarily within the customer's own environment**. Source code, design models, project files, generated code, and related development assets remain on the developer's machine and/or in the customer's own repositories and storage systems unless the customer deliberately transmits data to an external service they have configured, such as an AI provider.

Intent Architect does operate a limited set of supporting cloud services for product operation, including licensing, update and module services, telemetry, crash/error reporting, and account-related services. These services process **operational service data**, which is separate from customer project content.

## Product architecture

### Local-first application model

Intent Architect is installed and executed locally on customer-managed devices. Normal use of the product involves:

- Opening and editing local project files.
- Creating and maintaining design models.
- Generating code into local solutions.
- Interacting with local development environments and source control chosen by the customer.

Intent Architect does **not** provide a hosted cloud workspace for customer software projects.

### Supporting cloud services

Intent Architect uses a limited number of hosted supporting services for product operation, including:

- Licence activation and validation.
- Update checks.
- Public module registry/distribution.
- Telemetry collection.
- Crash/error reporting.
- Account/web-related services.

These services process operational service data rather than customer project content as part of normal product operation.

### AI integration model

Intent Architect supports AI-assisted workflows using customer-configured AI providers. In standard bring-your-own-provider configurations:

- Requests are sent from the customer's machine to the selected provider.
- Provider credentials are stored locally on the customer machine.
- Data handling for those requests is governed by the selected provider and the customer's agreement with that provider.

This architecture means Intent Architect is not, by default, a central processor or long-term store of AI prompts, files, or outputs for bring-your-own-provider use. See [](xref:ai.data-privacy) for detail.

## Data classification model

For security and governance purposes, the following distinction is important.

### Customer project content

Customer project content includes:

- Source code.
- Design models.
- Project files.
- Generated code.
- Prompts, AI inputs, and AI outputs.
- Customer business documents and development artefacts.

Customer project content generally remains within customer-controlled environments.

### Operational service data

Operational service data includes:

- Account and licensing data.
- Technical product telemetry.
- Crash and error diagnostics.
- Service-operation metadata.
- Update and module retrieval metadata.

Operational service data is separate from customer project content.

## Data flow summary

### Local processing

The following are generally processed locally on the customer's machine:

- Source code and project files.
- Design models.
- Generated solution content.
- AI configuration settings stored on the machine.
- Local context used during development workflows.

### Hosted service processing

The following may be processed by Intent Architect supporting services:

- Account and licensing records.
- Technical telemetry and usage events.
- Crash/error diagnostics.
- Service-operation metadata.

### AI provider processing

When a customer uses AI features, the following may be sent to the customer-selected AI provider depending on the requested task:

- Prompts and conversation history.
- Attached context.
- Design/model snapshots.
- Code or file content needed to complete the requested operation.

This processing path is controlled by the provider configuration selected by the customer.

## Hosting and residency

Intent Architect supporting services are hosted using:

- **Microsoft Azure** - Johannesburg, South Africa.
- **Cloudflare CDN** - Europe.

Customer project content is generally not hosted by Intent Architect. Data residency for AI requests depends on the provider and endpoint selected by the customer. See [](xref:security-privacy.hosting-and-data-residency).

## Data separation and isolation

### Separation of project content

Intent Architect's primary isolation model is architectural: customer project content remains in the customer's own environment rather than being pooled into a shared Intent-hosted development workspace.

This means:

- Customer code and project files remain under customer endpoint and repository controls.
- Project content is not co-mingled in a central Intent-hosted project store as part of normal operation.
- Customers retain control over where project content is stored and how it is secured.

### Separation of operational service data

Operational service data handled by supporting services is separate from customer project content and is limited to the categories required to operate, support, and improve the product.

Telemetry and diagnostics may be associated with a **pseudonymous identifier** such as a GUID-based account, user, or installation identifier for operational and support purposes.

## Telemetry and crash diagnostics

### Nature of telemetry

Intent Architect collects technical telemetry and crash diagnostics as part of product operation and support.

Examples include:

- User authentication/login events.
- Feature access events.
- Process execution events.
- Product usage and behaviour signals.
- Performance/reliability indicators.
- Software exceptions, errors, and crash details.

For the specific metrics collected, see [](xref:application-development.user-interface.telemetry-collection).

### Scope limitations

Telemetry and crash reporting are intended to collect **technical and operational information**, not customer project content.

They do not intentionally collect customer project content such as:

- Source code.
- Design models.
- Project files.
- Customer business documents.
- Prompts or AI outputs from standard bring-your-own-provider workflows.

### Retention

Telemetry and crash diagnostics are retained for long-term product support, reliability analysis, usage analysis, and historical troubleshooting.

This data is retained **indefinitely**, subject to deletion on request where appropriate.

### User linkage

Telemetry may include a pseudonymous identifier associated with an account, user, or installation context. This identifier is used for technical and operational purposes and is not intended to represent customer project content.

## AI security considerations

### Bring-your-own-provider control model

Intent Architect's default AI model is customer-controlled configuration. Customers select:

- The AI provider.
- The endpoint/region.
- The credentials used.
- The provider relationship and contractual posture.

This allows customers to align AI usage with their own governance, data residency, and model-usage requirements. See [](xref:ai.configuration).

### Intent Architect's role

In standard bring-your-own-provider use:

- Intent Architect does not operate a general-purpose hosted repository for prompts and outputs.
- Intent Architect does not centrally store customer project content associated with those requests as part of normal operation.
- The applicable data-handling terms are those of the selected provider.

> [!NOTE]
> Customers with strict AI governance requirements should review the selected provider's retention, training, logging, regional processing, and security terms separately.

## Credential handling

AI provider credentials configured for use within Intent Architect are stored **locally on the user's machine**.

Customers remain responsible for:

- Securing developer endpoints.
- Securing local operating-system accounts.
- Managing access to local credential stores and developer environments.
- Governing which external AI providers are approved for use.

## Encryption and transmission security

Intent Architect communicates with supporting services and configured providers over network connections appropriate to those services.

The security posture for those services should be understood as:

- Customer project content is primarily protected by remaining in customer-controlled environments.
- Communications with hosted supporting services and third-party providers are expected to use standard encrypted transport protocols.
- Data-at-rest protections for hosted supporting services are provided through the underlying hosted infrastructure and service architecture where applicable.

If a customer requires a deeper control-level breakdown of encryption or infrastructure safeguards, that information should be provided separately where available.

## Customer responsibilities

Because Intent Architect is a locally installed development tool, customers remain responsible for many of the core controls around their project content, including:

- Workstation security.
- Endpoint hardening.
- Local storage controls.
- Repository access controls.
- Network security.
- Approved AI provider selection and configuration.

This local-first architecture gives customers direct control over the most sensitive project assets.

## Trial, termination, and continued customer control

Because Intent Architect does not normally host customer project content, customer project files, code, and models remain in customer-controlled environments during and after any trial or commercial relationship.

Hosted supporting services may continue to hold operational service data such as licensing/account records, telemetry, crash diagnostics, and service-operation metadata, subject to applicable retention practices and deletion requests.

## Security inquiries

Customers conducting internal security, governance, or data-protection reviews may request additional information regarding:

- Hosting regions.
- Categories of operational service data.
- AI provider integration model.
- Retention and deletion handling for operational service data.
- Third-party supporting service providers.

See [](xref:getting-help) for contact channels.
