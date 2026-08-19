---
uid: security-privacy.hosting-and-data-residency
description: "Where Intent Architect data is processed and stored: customer project content stays local, supporting services are hosted in Azure Johannesburg and Cloudflare Europe, and AI residency follows the provider you configure."
---
# Hosting & Data Residency

## Overview

Intent Architect is a **locally installed software development tool**. It runs on customer-managed developer workstations and is architecturally comparable to other desktop development tools/IDEs.

As a general rule, **customer project content is not hosted by Intent Architect**. Source code, design models, files, and other project materials remain on the customer's own machines, repositories, and infrastructure unless the customer deliberately sends data to a third-party service they configure, such as an AI provider.

This statement describes:

- What data is processed locally versus in supporting hosted services.
- Where hosted supporting services are located.
- When data may leave the customer's environment.
- How data residency depends on customer configuration for AI features.

## Data categories

For clarity, Intent Architect distinguishes between the following categories of data.

### Customer project content

Customer project content includes:

- Source code.
- Design models.
- Project files.
- Generated code.
- Prompts, inputs, and outputs used with AI features.
- Other materials belonging to the customer's software project.

Customer project content is generally processed and stored **locally in the customer's environment** and/or in the customer's own source control and storage systems.

### Operational service data

Intent Architect also processes limited operational service data required to operate and support the product, including:

- Account and licensing data.
- Update and module retrieval requests.
- Technical product telemetry.
- Crash and error diagnostics.
- Service-operation metadata.

Operational service data is separate from customer project content.

## Where data is processed and stored

### Customer project content

Intent Architect does **not** operate a hosted cloud workspace for customer project content.

Customer project content is generally:

- Processed on the developer's local machine.
- Stored on that machine, on customer-managed storage, and/or in customer-managed source control repositories.
- Controlled by the customer's own endpoint, storage, network, and repository security arrangements.

### Intent Architect supporting services

Intent Architect operates a limited set of supporting services for product operation, such as:

- Licence activation and validation.
- Update checks.
- Public module registry/distribution.
- Telemetry collection.
- Crash/error reporting.
- Web/account-related services.

These supporting services are hosted using:

- **Microsoft Azure** - Johannesburg, South Africa.
- **Cloudflare CDN** - Europe.

These services process **operational service data**, not customer project content, as part of normal product operation.

## AI features and data residency

Intent Architect's AI capability is **bring-your-own-provider** by default.

When a customer uses AI features, prompts and context are sent from the customer's machine to the AI provider the customer has configured. Depending on the feature and task, that data may include:

- Prompts and conversation history.
- Attached context files.
- Model/design snapshots.
- File contents read from the local codebase for the requested task.

Intent Architect does not provide a central hosted AI relay for standard bring-your-own-provider usage. Accordingly:

- AI data residency depends on the **provider, endpoint, and region selected by the customer**.
- Any transfer, processing, storage, retention, or model-use policy for AI requests is governed by the customer's agreement and configuration with that provider.

Where Intent Architect may offer provider-backed AI access or credits, the applicable provider path and retention model for that feature should be reviewed separately - see [](xref:ai.data-privacy).

## Data residency summary by category

| Data category                             | Typical location                                        | Residency control                        |
| ----------------------------------------- | ------------------------------------------------------- | ---------------------------------------- |
| Customer project content                  | Customer-managed machines, repositories, and storage     | Controlled by customer                   |
| Account and licensing data                | Intent Architect supporting services                     | Microsoft Azure Johannesburg, South Africa |
| Technical telemetry                       | Intent Architect supporting services                     | Microsoft Azure Johannesburg, South Africa |
| Crash/error diagnostics                   | Intent Architect supporting services                     | Microsoft Azure Johannesburg, South Africa |
| Update/module delivery traffic            | Intent Architect supporting services / CDN               | Azure Johannesburg and Cloudflare Europe |
| AI prompts, inputs, outputs, and context  | Customer-configured AI provider                          | Controlled by selected provider/endpoint |

## International data transfers

Operational service data processed by Intent Architect supporting services may be processed in the hosting regions used for those services, including South Africa and Europe. AI-related data may be processed in the region used by the customer's selected AI provider. Customers with region-specific residency requirements should assess both Intent Architect's supporting service locations and the location of any third-party providers they choose to use.

In summary:

- Operational service data processed by Intent Architect supporting services may be processed in **South Africa**.
- Content delivered via CDN may involve **European Cloudflare infrastructure**.
- AI-related data may be processed in whatever region is used by the **customer's selected AI provider**.

Because Intent Architect is primarily a locally installed tool, customer project content ordinarily remains in the customer's own environment unless the customer chooses to transmit it to an external provider.

## Data hosted by Intent Architect vs. not hosted by Intent Architect

### Not hosted by Intent Architect as part of normal operation

Intent Architect does **not** host customer project workspaces or repositories containing:

- Source code.
- Project files.
- Design models.
- Generated code.
- Customer business documents.

### Hosted by Intent Architect supporting services

Intent Architect supporting services may host:

- Account and licensing records.
- Technical telemetry and product usage events.
- Crash/error diagnostics.
- Service-delivery and operational metadata.

## Telemetry and crash diagnostics

Intent Architect collects technical telemetry and crash diagnostics as part of operating and supporting the product.

This data is:

- Technical and operational in nature.
- Related to product usage, feature access, process execution, product behaviour, and software errors.
- Separate from customer project content.

Telemetry and crash reporting do **not** include customer project content such as:

- Source code.
- Design models.
- Project files.
- Prompts.
- AI outputs.
- Generated solution content.

Telemetry and diagnostics may be linked to a **pseudonymous identifier** (for example, a GUID-based user or installation identifier) for service operation and support purposes.

For the specific metrics collected, see [](xref:application-development.user-interface.telemetry-collection).

## Customer control considerations

Customers who have data residency or AI governance requirements should note:

- Customer project content remains under customer control unless deliberately transmitted elsewhere.
- AI provider selection is customer-controlled in bring-your-own-provider configurations.
- Residency for AI interactions should therefore be assessed against the customer's chosen provider and endpoint.
- Operational service data processed by Intent Architect is separate from customer project content and is hosted as described above.

## Further information

Intent Architect can provide additional information on request regarding:

- Categories of operational service data processed.
- AI integration model.
- Supporting service providers involved in service delivery.
- Retention and deletion handling for operational service data.

See [](xref:getting-help) for contact channels.
