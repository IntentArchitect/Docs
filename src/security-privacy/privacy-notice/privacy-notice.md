---
uid: security-privacy.privacy-notice
description: "Intent Architect's Privacy Notice: what information is processed, how it is used, retention, international transfers, AI provider handling, and data subject rights."
---
# Privacy Notice

> [!NOTE]
> Last updated: 19 August 2026.

## Introduction

This Privacy Notice explains how Intent Architect handles information in connection with the Intent Architect product, related services, and associated commercial and support interactions.

Intent Architect is a **locally installed software development tool**. It runs on customer-managed developer machines and is not designed as a hosted cloud workspace for customer software projects. As a result, customer project content such as source code, design models, and project files generally remains within the customer's own environment.

This notice applies to:

- The Intent Architect desktop product.
- Licensing and account-related services.
- Update and module delivery services.
- Telemetry and crash/error reporting.
- Portal and support interactions, where applicable.

Cookies and visitor analytics for the Intent Architect website and this documentation site are covered by the privacy and cookie notices published on the [Intent Architect website](https://intentarchitect.com) rather than by this notice. Those sites use Google Analytics to measure visitor activity.

## Important distinction: project content vs operational service data

Intent Architect distinguishes between **customer project content**, which stays within the customer's own environment and is not hosted by us, and **operational service data**, which we process to operate and support the product. Both are defined in [Data categories](xref:security-privacy.overview#data-categories).

This notice primarily concerns **operational service data** and other information processed in connection with operating and supporting the product.

## Information we process

We may process the following categories of information.

### Account and licensing information

This may include:

- Name and contact details.
- Organisation/company name.
- Account identifiers.
- Licence/subscription information.
- Authentication-related records.
- Commercial and support records associated with an account.

### Technical telemetry and product usage data

This may include technical and behavioural product-usage information such as:

- User login or authentication events.
- Feature access events.
- Process execution events.
- Product usage and behaviour signals.
- Product version, environment, and technical usage metrics.
- Operational events needed to support, analyse, and improve the product.

These are representative of the nature of the telemetry collected rather than an exhaustive inventory. The telemetry is technical in nature and does **not include customer project content**. See [](xref:application-development.user-interface.telemetry-collection) for the metrics collected.

Telemetry cannot be disabled.

### Crash and error diagnostics

This may include:

- Exception and error information.
- Stack traces.
- Failure events.
- Technical diagnostic context required to investigate and resolve product issues.

### Update, module, and service-delivery metadata

This may include:

- Requests for updates or modules.
- Download/delivery metadata.
- Service access logs and operational request information.

### AI configuration and AI-related usage

Intent Architect supports customer-configured AI providers. Provider credentials configured for AI use are stored **locally on the customer's machine**.

Where customers use AI features, prompts and related context are generally sent from the customer's machine to the configured AI provider. Intent Architect does not normally operate a hosted cloud repository for this content as part of standard bring-your-own-provider usage. See [](xref:ai.data-privacy).

### Support and communications

Where customers contact us, we may process:

- Support requests.
- Email correspondence.
- Commercial and procurement communications.
- Other information voluntarily provided in the course of the relationship.

## Information we do not collect through product telemetry

Intent Architect's telemetry and crash reporting do **not** collect customer project content - source code, design models, project files, generated code, customer business documents, or prompts and AI outputs.

Customer project content remains under customer control in customer-managed environments unless the customer deliberately transmits it to a third-party provider.

## How we use information

We use information for the following purposes:

- To provide, activate, validate, and support product licences.
- To operate product-related services and delivery mechanisms.
- To maintain, monitor, troubleshoot, and improve product quality, stability, and performance.
- To diagnose crashes, faults, and service issues.
- To analyse feature usage and long-term product behaviour.
- To communicate with customers and respond to support or commercial requests.
- To maintain security, prevent abuse, and protect the integrity of our services.
- To meet legal, regulatory, accounting, and contractual obligations.

## Legal/processing basis

To the extent applicable, we process information where necessary for one or more of the following reasons:

- To perform a contract or take steps related to a contract.
- To operate and support the product and related services.
- For legitimate business interests, including product security, reliability, support, and improvement.
- To comply with legal obligations.
- On the basis of consent where consent is specifically required.

Where local law applies additional requirements, those requirements will govern.

## AI features and third-party AI providers

Intent Architect supports **bring-your-own-provider** AI usage. When a customer configures and uses an AI provider:

- Prompts, inputs, outputs, and context may be sent directly from the customer's machine to that provider.
- The provider selected by the customer determines where that information is processed and what retention or model-use terms apply.
- Those interactions are governed by the customer's relationship with the chosen provider.

Intent Architect itself does not store or host that AI interaction content in bring-your-own-provider operation.

Customers who are not yet set up with their own AI provider can optionally use a small allocation of **free AI credits** to evaluate the AI features. Intent Architect applies **Zero Data Retention** to all supported models on this path, so request and response content is not stored by the model provider. The feature is optional and can be disabled for customers who do not want it available. See [](xref:ai.data-privacy).

> [!NOTE]
> Customers should independently assess any AI provider they choose to use.

## Sharing and third parties

We may share or make information available to third-party providers involved in operating and delivering Intent Architect-related services.

These may include:

- Infrastructure hosting providers.
- Content delivery/network service providers.
- Service providers involved in licensing, delivery, diagnostics, or account-related operations.
- Professional advisers, regulators, or authorities where required.

For Intent Architect supporting services, relevant providers may include:

- **Microsoft Azure** for hosted supporting services.
- **Cloudflare** for content delivery/network services.
- **Mixpanel** for product usage analytics/telemetry.
- **Google Analytics** for website and documentation site visitor analytics.

Where a customer uses a separately configured AI provider, that provider processes the data the customer chooses to send to it. See [](xref:security-privacy.third-party-services-and-sub-processors) for the full list.

## International processing and transfers

Intent Architect supporting services are hosted using:

- **Microsoft Azure** - Johannesburg, South Africa.
- **Cloudflare CDN** - Europe.
- **Mixpanel** - Europe.

As a result, some operational service data may be processed outside the customer's country.

South Africa is not the subject of an EU adequacy decision. Where operational service data relating to individuals in the EU or UK is processed in South Africa, appropriate transfer safeguards are applied through the subscription agreement customers enter into. Customers who require confirmation of the specific transfer terms that apply to them, or a separate data processing agreement, can request this - see [Contact](#contact). The data protection agreements we hold with our own infrastructure providers likewise incorporate the Standard Contractual Clauses.

The volume of personal information involved is limited: the data crossing borders is operational service data - account and licensing records, telemetry, and diagnostics - not customer project content, which never leaves the customer's environment.

AI-related processing may also occur outside the customer's country depending on the provider and endpoint chosen by the customer.

Because Intent Architect is a locally installed application, customer project content remains within the customer's own environment unless deliberately transmitted elsewhere.

## Retention

Different categories of information are retained for different periods.

| Category                                           | Retention                                                                                                                                                                                                                    |
| -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Customer project content                           | Not retained by Intent Architect - it stays in customer-managed environments.                                                                                                                                                 |
| Product usage analytics held in Mixpanel            | Retained in accordance with Mixpanel's standard data retention policy for our plan, after which events age out. The current period can be confirmed on request.                                                                |
| Account, licensing, and commercial records           | Retained for the duration of the customer relationship, and afterwards where needed for legal, accounting, and record-keeping purposes. Deleted on request where no such obligation applies.                                    |
| Aggregate product metrics held in our own services | Retained indefinitely. These are product-level metrics with no personal information attached - for example counts, durations, and volumes used for long-term reliability and performance analysis.                              |
| Crash and error diagnostics                        | Retained indefinitely for troubleshooting and long-term reliability analysis. These are technical records - exception details, stack traces, and environment information. They do not contain usernames or other personal information, and are associated only with the pseudonymous identifier described above. |

The distinction that matters for most reviews is that indefinite retention applies only to technical and aggregate records. Information that identifies a person or an account is tied to the customer relationship or ages out.

## Data subject rights and requests

Depending on applicable law, individuals may have rights to request access, correction, deletion, restriction, objection, or portability in relation to personal information processed about them.

Requests may be submitted by email to <support@intentarchitect.com>, or through Intent Architect's other support and commercial contact channels - see [](xref:getting-help). We may request reasonable information to verify identity and assess the scope of the request before actioning it.

Where information is retained for legal, security, accounting, or legitimate operational reasons, we may retain certain records as permitted or required by applicable law.

Individuals who are not satisfied with how we have handled a request also have the right to lodge a complaint with their local data protection supervisory authority.

## Security

Intent Architect's security model is shaped by its local-first architecture:

- Customer project content generally remains under customer control on customer-managed machines and repositories.
- Hosted supporting services process limited operational service data.
- Provider credentials for AI integrations are stored locally on the customer's machine.
- Supporting services and third-party providers are used to operate, secure, and support the product.

Customers remain responsible for securing their own endpoints, repositories, storage environments, and approved third-party integrations. See [](xref:security-privacy.security-overview).

## Termination and continued customer control

Because Intent Architect does not host customer project content, customer project files, code, and models remain under the customer's control during and after the commercial relationship.

Following termination or expiry of a service relationship, operational service data continues to be retained in accordance with the [Retention](#retention) table above unless deletion is requested and actioned where appropriate.

## Changes to this notice

We may update this Privacy Notice from time to time to reflect changes in the product, supporting services, legal requirements, or operational practices. The date at the top of this notice indicates when it was last changed, and the latest version should be treated as the current statement of our practices unless otherwise agreed in writing.

## Contact

Intent Architect is provided, sold, and supported by **Intent Architect Holdings Ltd**, which is responsible for the information described in this notice.

For questions about this Privacy Notice, data handling, or privacy-related requests, email <support@intentarchitect.com>, or use any of the channels listed in [](xref:getting-help).
