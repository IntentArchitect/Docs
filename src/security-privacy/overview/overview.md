---
uid: security-privacy.overview
description: "How Intent Architect's local-first architecture shapes security and privacy: customer project content stays in your environment, while limited supporting services process operational data."
---
# Security & Privacy Overview

Intent Architect is primarily a **locally installed software development tool / IDE**, architecturally comparable to tools such as Visual Studio Code, JetBrains Rider, or Cursor, rather than a hosted SaaS platform.

That distinction matters for security, privacy, and data governance.

Customer project content - including source code, design models, project files, generated code, prompts, inputs, and outputs - generally remains on the developer's machine and in the customer's own source control and storage systems. Intent Architect does **not** operate a hosted cloud workspace that ingests or stores customer project content as part of normal product use.

Intent Architect does operate a limited set of supporting services for product operation, including licensing, update checks, module distribution, telemetry, crash/error reporting, analytics, and account-related services. These services process **operational service data**, which is separate from customer project content.

AI usage in Intent Architect is **bring-your-own-provider** by default. When AI features are used, requests go from the developer's machine directly to the AI provider configured by the customer. This allows customers to align AI use with their own governance, security, residency, and provider approval requirements.

## Quick answers

| Question                                            | Short answer                                                                                                                                 | Detail                                                       |
| --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------ |
| Does my source code leave my machine?               | Not to Intent Architect. Only to an AI provider you configure, for the AI requests you make.                                                  | [](xref:security-privacy.hosting-and-data-residency)         |
| Where is my data stored?                             | Project content: your machines and repositories. Operational data: Azure Johannesburg, with CDN and analytics in Europe.                      | [](xref:security-privacy.hosting-and-data-residency)         |
| Do you train AI models on my code?                   | No. Intent Architect does not train models on customer content. Your chosen AI provider's terms govern their own use of requests you send it.  | [](xref:ai.data-privacy)                                     |
| Who are your sub-processors?                          | Microsoft Azure, Cloudflare, Mixpanel, Stripe, Xero.                                            | [](xref:security-privacy.third-party-services-and-sub-processors) |
| Can I turn telemetry off?                             | No. Telemetry is technical and operational only, and cannot be disabled.                                                                      | [](xref:application-development.user-interface.telemetry-collection) |
| How do I request deletion of my data?                 | Email <support@intentarchitect.com>.                                                                                                          | [](xref:security-privacy.privacy-notice#data-subject-rights-and-requests) |
| Do you hold ISO 27001 or SOC 2 certification?         | No. Our assurance position rests on the local-first architecture rather than certification of a hosted platform.                              | [](xref:security-privacy.security-overview#compliance-certifications) |
| Can developers work offline?                          | Yes, for a limited period before a licence revalidation is required.                                                                          | [](xref:security-privacy.security-overview#offline-use)      |

## Data categories

Two categories run through all of these documents, and the distinction is central to how Intent Architect is operated and assessed.

**Customer project content** - source code, design models, project files, generated code, customer business documents, and the prompts, inputs, and outputs used with AI features. This stays in your environment: on developer machines, in your storage, and in your source control. Intent Architect does not host it.

**Operational service data** - account and licensing records, technical product telemetry, crash and error diagnostics, update and module retrieval metadata, service-operation metadata, and billing and support records. This is processed by Intent Architect supporting services and the providers listed in [](xref:security-privacy.third-party-services-and-sub-processors).

## Core principles

### Local-first by design

Intent Architect is designed as a locally installed development tool. Customer project content remains primarily within customer-controlled environments rather than being stored in a shared hosted Intent platform.

### Separation of project content and operational data

Customer project content and operational service data are handled differently and are described separately throughout this section - see [Data categories](#data-categories) above.

### Customer-controlled AI provider selection

Intent Architect does not require a single mandated AI provider. Customers choose which provider, endpoint, and credentials to use, which means AI processing can be aligned to internal security and governance policies. See [](xref:ai.configuration) for how providers are configured.

For customers who are not yet AI-enabled, a small allocation of optional **trial AI credits** is available so the features can be evaluated before committing to a provider. This is not the intended long-term configuration; see [](xref:ai.data-privacy).

### Limited supporting services

We use a limited number of supporting services for product operation and delivery, separate from customer project content. These services support functions such as licensing, updates, diagnostics, analytics, billing, and account administration.

## Hosting and regional considerations

Intent Architect supporting services are hosted using:

- **Microsoft Azure** - Johannesburg, South Africa.
- **Cloudflare CDN** - Europe.
- **Mixpanel** - Europe.

Because AI usage is customer-configured, AI-related data residency depends on the provider and region selected by the customer. See [](xref:security-privacy.hosting-and-data-residency) for the full breakdown.

## Available trust documentation

Customers conducting internal security, privacy, AI governance, or procurement reviews can review the following:

- [](xref:security-privacy.hosting-and-data-residency)
- [](xref:security-privacy.security-overview)
- [](xref:security-privacy.privacy-notice)
- [](xref:security-privacy.third-party-services-and-sub-processors)
- [](xref:ai.data-privacy)
- [](xref:application-development.user-interface.telemetry-collection)

These documents describe our operating model, data categories, supporting service providers, AI integration model, and regional considerations in more detail.
