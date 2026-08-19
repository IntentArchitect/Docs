---
uid: security-privacy.third-party-services-and-sub-processors
description: "The third-party providers Intent Architect uses - Azure, Cloudflare, Mixpanel, Google Analytics, Monday.com, Stripe, and Xero - what data each processes, and how customer-selected AI providers differ from default sub-processors."
---
# Third-Party Services and Sub-processors

Intent Architect is a **locally installed software development tool**. As part of delivering, operating, and supporting the product and related commercial processes, we use a limited number of third-party service providers.

This document identifies third parties that may process **operational service data**, **commercial/account data**, or related service information in connection with Intent Architect.

For clarity:

- **Customer project content** means source code, design models, project files, prompts, AI inputs/outputs, generated code, and other materials belonging to a customer's software project.
- **Operational service data** means account data, licensing records, technical product telemetry, and crash diagnostics.
- **Commercial and billing data** means customer contact details, company details, billing records, invoices, and payment-related information associated with the commercial relationship.

None of these providers receive customer project content. It stays on customer-managed machines and repositories, unless the customer configures an AI provider and sends data to it.

## Third-party providers used by Intent Architect

| Provider            | Service                                                                                                                                                                       | Data categories involved                                                                                                                    | Hosting / processing region                                | Role                        |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | --------------------------- |
| **Microsoft Azure** | Hosting of Intent Architect supporting services, including licensing, validation, service APIs, telemetry/crash-related services, update-related services, and account services | Account data, licensing records, technical telemetry, crash/error diagnostics                                     | Johannesburg, South Africa                                 | Cloud infrastructure provider |
| **Cloudflare**      | Content delivery and network edge services for public-facing delivery and distribution                                                                                        | Request metadata, delivery logs, network/edge service data, content delivery metadata                                                        | Europe                                                     | CDN and network services provider |
| **Mixpanel**        | Product telemetry and analytics                                                                                                                                               | Technical product usage events, feature access events, process execution events, product metrics, pseudonymous identifiers, operational analytics data | Europe                                                     | Analytics provider          |
| **Google Analytics** | Usage analytics for the Intent Architect public website and documentation site                                                                                                 | Page and article views, referrer, browser and device metadata, approximate location derived from IP address, cookie/measurement identifiers                    | Subject to Google service configuration and contractual terms | Website analytics provider  |
| **Monday.com**      | Customer success and support case management                                                                                                                                   | Customer and contact names, business email addresses, company details, and the content of support and customer success interactions             | United States                                              | Support case management provider |
| **Stripe**          | Payment processing, where customers elect to use card-based payment                                                                                                           | Billing/contact/payment transaction data, payment-related metadata, commercial transaction information                                        | Subject to Stripe service configuration and contractual terms | Payment processor           |
| **Xero**            | Billing, invoicing, and accounting administration associated with customer relationships                                                                                       | Customer/company contact details, billing details, invoice records, transaction records, commercial/accounting information                    | Subject to Xero service configuration and contractual terms | Accounting and invoicing provider |

## Provider categories

### Infrastructure and service delivery providers

These providers support the operation and delivery of Intent Architect services:

- Microsoft Azure
- Cloudflare

These providers may process operational service data required to host, deliver, and support Intent Architect-related services.

### Product analytics and diagnostics providers

These providers support analysis of product usage and behaviour:

- Mixpanel

Mixpanel is used for technical product telemetry and analytics relating to product usage, feature access, process execution, and operational behaviour. This telemetry is separate from customer project content.

### Website analytics providers

- Google Analytics

Google Analytics is used to measure visitor activity on the public Intent Architect website and this documentation site. It relates to **website visitors**, not to use of the installed product, and does not process customer project content or product telemetry. Cookie handling for these sites is described in the privacy and cookie notices published on the [Intent Architect website](https://intentarchitect.com).

### Customer success and support providers

- Monday.com

Monday.com is used to manage support and customer success cases, and is hosted in the United States. It processes contact details and the content of the interactions customers have with us, which is separate from product telemetry and from customer project content.

### Commercial and billing providers

These providers support payment, invoicing, and accounting administration:

- Stripe
- Xero

Stripe is used where customers elect to use card-based payment processing. Xero is used for invoicing and accounting administration associated with the commercial customer relationship. It is not part of the Intent Architect application runtime, but may process customer billing and contact information.

## AI providers

Intent Architect supports **bring-your-own-provider** AI integrations. In these cases, prompts, inputs, outputs, and contextual data are sent from the customer's machine to the AI provider the customer selects and configures.

Because these providers are chosen by the customer, they are generally best understood as **customer-selected third parties**, rather than default Intent Architect sub-processors for standard product operation.

Providers include, depending on customer configuration:

- OpenAI
- Anthropic
- Microsoft Azure OpenAI
- Google Gemini
- OpenRouter
- Ollama
- Other OpenAI-compatible or customer-specified providers

In these configurations:

- Intent Architect does not host or route customer AI traffic. Requests go from the customer's machine directly to the configured provider.
- Data handling, retention, residency, and model-use terms for AI requests are governed by the selected provider and the customer's agreement with that provider.

### Free AI credits

For customers who are not yet set up with their own AI provider, Intent Architect offers a small allocation of **free AI credits** so the AI features can be evaluated. This is entirely optional and is not the intended long-term configuration - customers are expected to configure their own provider.

**Zero Data Retention** is applied to all supported models on this path, meaning request and response content is not stored by the model provider. Models for which zero retention is not available fall under the underlying provider's standard data policy, and the distinction is shown in the model selection list. See [](xref:ai.data-privacy) for the detail.

Customers whose governance policies do not permit third-party AI routing can request to have this feature disabled for their account and configure their own provider instead.

## Categories of data not processed by default supporting services

Intent Architect's supporting services do not host customer project content - see [Customer project content](xref:security-privacy.overview#data-categories). That content stays under customer control in customer-managed environments unless the customer deliberately transmits it to a third-party provider.

## Telemetry and crash diagnostics

The operational data processed by Intent Architect supporting services and analytics providers is technical in nature - product usage and feature access events, process execution events, performance indicators, exceptions and crash diagnostics, and a pseudonymous identifier used to associate events with an account or installation.

These are representative examples rather than an exhaustive inventory. For the metrics collected, see [](xref:application-development.user-interface.telemetry-collection).

## Commercial and billing data

Commercial and billing providers may process information such as:

- Customer and company names.
- Billing contact information.
- Invoice records.
- Payment transaction information.
- Accounting and financial administration records.

This data relates to the commercial relationship and is separate from customer project content and technical product telemetry.

## Changes to providers

Intent Architect may update its third-party providers from time to time as operational needs evolve. Updated provider information can be made available on request or through updated trust/privacy documentation, as applicable.

## Contact

For questions regarding third-party processing, hosting, analytics, billing, or data categories, see [Contact us](xref:security-privacy.overview#contact-us).
