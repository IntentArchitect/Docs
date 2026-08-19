---
uid: security-privacy.hosting-and-data-residency
description: "Where Intent Architect data is processed and stored: customer project content stays local, supporting services are hosted in Azure Johannesburg with CDN and analytics in Europe, and AI residency follows the provider you configure."
---
# Hosting & Data Residency

## Overview

Intent Architect is a **locally installed software development tool**. It runs on customer-managed developer workstations and is architecturally comparable to other desktop development tools and IDEs.

**Customer project content is not hosted by Intent Architect.** Source code, design models, files, and other project materials remain on the customer's own machines, repositories, and infrastructure unless the customer deliberately sends data to a third-party service they configure, such as an AI provider.

This document covers where each category of data is processed, which regions are involved, and how residency for AI features depends on customer configuration. For the definitions of *customer project content* and *operational service data* used throughout, see [Data categories](xref:security-privacy.overview#data-categories).

## Where data is processed and stored

### Customer project content

Intent Architect does **not** operate a hosted cloud workspace for customer project content. That content is:

- Processed on the developer's local machine.
- Stored on that machine, on customer-managed storage, and/or in customer-managed source control repositories.
- Controlled by the customer's own endpoint, storage, network, and repository security arrangements.

### Intent Architect supporting services

Intent Architect operates a limited set of supporting services for product operation - licence activation and validation, update checks, the public module registry, telemetry collection, crash and error reporting, and web/account services.

These services process **operational service data**, not customer project content, and are hosted using:

- **Microsoft Azure** - Johannesburg, South Africa.
- **Cloudflare CDN** - Europe.
- **Mixpanel** - Europe (product telemetry and analytics).

## AI features and data residency

Intent Architect's AI capability is **bring-your-own-provider** by default.

When a customer uses AI features, prompts and context are sent from the customer's machine to the AI provider the customer has configured. Depending on the feature and task, that data may include prompts and conversation history, attached context files, model and design snapshots, and file contents read from the local codebase for the requested task.

Intent Architect does not host or route this traffic. Accordingly:

- AI data residency depends on the **provider, endpoint, and region selected by the customer**.
- Any transfer, processing, storage, retention, or model-use policy for AI requests is governed by the customer's agreement and configuration with that provider.

### Free AI credits

Customers who are not yet set up with their own AI provider can optionally use a small allocation of **free AI credits** to evaluate the AI features. On this path Intent Architect applies **Zero Data Retention** to all supported models, so request and response content is not stored by the model provider. The feature is optional and can be disabled for customers who do not want it available. See [](xref:ai.data-privacy).

## Data residency summary by category

| Data category                            | Typical location                                     | Residency control                          |
| ---------------------------------------- | ---------------------------------------------------- | ------------------------------------------ |
| Customer project content                 | Customer-managed machines, repositories, and storage  | Controlled by customer                     |
| Account and licensing data               | Intent Architect supporting services                  | Microsoft Azure Johannesburg, South Africa |
| Crash/error diagnostics                  | Intent Architect supporting services                  | Microsoft Azure Johannesburg, South Africa |
| Product telemetry and analytics          | Intent Architect supporting services and Mixpanel     | Azure Johannesburg and Mixpanel Europe     |
| Update/module delivery traffic           | Intent Architect supporting services and CDN          | Azure Johannesburg and Cloudflare Europe   |
| AI prompts, inputs, outputs, and context | Customer-configured AI provider                       | Controlled by selected provider/endpoint   |

## International data transfers

Operational service data may be processed in **South Africa** (Azure Johannesburg) and in **Europe** (Cloudflare CDN and Mixpanel), which may be outside the customer's own country. AI-related data is processed in whatever region is used by the customer's selected AI provider.

Because Intent Architect is a locally installed tool, customer project content remains in the customer's own environment unless the customer chooses to transmit it to an external provider. The data described above is operational service data only - account and licensing records, telemetry, and diagnostics.

If you have specific data residency requirements, [get in touch](xref:getting-help) and we are happy to discuss them.

## Telemetry and crash diagnostics

Intent Architect collects technical telemetry and crash diagnostics to operate and support the product. This data is technical and operational in nature - product usage, feature access, process execution, product behaviour, and software errors - and does not include customer project content such as source code, design models, project files, prompts, AI outputs, or generated solution content.

Telemetry and diagnostics may be linked to a **pseudonymous identifier** (for example, a GUID-based user or installation identifier) for service operation and support purposes. Telemetry cannot be disabled.

For the metrics collected, see [](xref:application-development.user-interface.telemetry-collection).

## Further information

Intent Architect can provide additional information on request regarding categories of operational service data processed, the AI integration model, supporting service providers, and retention and deletion handling. See [](xref:getting-help) for contact channels.
