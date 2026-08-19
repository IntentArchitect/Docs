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

This architecture means Intent Architect is not a central processor or long-term store of AI prompts, files, or outputs for bring-your-own-provider use.

The one exception is the optional **trial AI credits** offered to customers who are not yet set up with their own provider. Those requests are routed through OpenRouter with Zero Data Retention applied to supported models. Trial credits exist so the features can be evaluated; configuring your own provider is the intended configuration. See [](xref:ai.data-privacy) for detail.

## Data classification model

Two categories drive the security model: **customer project content**, which remains within customer-controlled environments, and **operational service data**, which is processed by supporting services. Both are defined in [Data categories](xref:security-privacy.overview#data-categories).

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
- **Mixpanel** - Europe (product telemetry and analytics).

Customer project content is not hosted by Intent Architect. Data residency for AI requests depends on the provider and endpoint selected by the customer. See [](xref:security-privacy.hosting-and-data-residency).

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

Intent Architect collects technical telemetry and crash diagnostics as part of product operation and support. Representative examples include authentication events, feature access events, process execution events, usage and behaviour signals, performance and reliability indicators, and software exceptions and crash details. For the metrics collected, see [](xref:application-development.user-interface.telemetry-collection).

Telemetry and crash reporting collect **technical and operational information only**. They do not collect customer project content: source code, design models, project files, customer business documents, or prompts and AI outputs.

Telemetry may include a pseudonymous identifier associated with an account, user, or installation context, used for operational and support purposes.

> [!NOTE]
> Telemetry cannot be disabled.

Retention varies by data category - see [Retention](xref:security-privacy.privacy-notice#retention) in the Privacy Notice.

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

AI provider credentials configured for use within Intent Architect are stored **locally on the user's machine**. They are never transmitted to Intent Architect's supporting services.

<!--
TODO: this section needs the specific storage mechanism filled in before it will satisfy a security review.
Reviewers consistently ask: which store, and is it encrypted at rest? Confirm and state one of:
  - the OS credential store (Windows Credential Manager / DPAPI, macOS Keychain), or
  - an encrypted file under the user profile (state the algorithm and where the key comes from), or
  - a plaintext configuration file (state it plainly, and note the file location so customers can apply their own controls).
Left as a comment rather than a published note - a visible "we can't say how we store your API keys"
reads worse to a reviewer than any of the honest answers above.
-->

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

## Network endpoints

Intent Architect contacts a small number of endpoints during normal operation. Customers running locked-down or proxied developer environments can use the following for firewall and proxy allow-listing.

<!-- TODO: confirm the endpoints and purposes below and replace the placeholders. This table is one of the
     most frequently requested items for a desktop tool in an enterprise environment, and it also
     demonstrates the local-first claim concretely - the list is short, and none of it carries project content. -->

| Endpoint                    | Purpose                                | Required                          |
| --------------------------- | -------------------------------------- | --------------------------------- |
| `TODO`                      | Licence activation and validation       | Yes                               |
| `TODO`                      | Update checks and product downloads     | Yes                               |
| `TODO`                      | Module registry and module downloads    | Yes                               |
| `TODO`                      | Telemetry and crash diagnostics         | Yes                               |
| Your configured AI provider | AI features                             | Only if AI features are used      |

AI provider endpoints depend entirely on the provider the customer configures, and are not fixed by Intent Architect.

## Offline use

Intent Architect can be used offline for a limited period. Licence validation requires periodic connectivity, and after that window elapses a successful revalidation is needed before use can continue.

<!-- TODO: state the actual offline grace period (e.g. "up to N days between successful licence validations")
     and what the user sees when it expires. -->

Module downloads, update checks, and AI features require connectivity at the time they are used. Local modelling, code generation, and editing do not.

## Compliance certifications

Intent Architect does **not** currently hold ISO 27001, SOC 2, or equivalent third-party security certifications.

Our assurance position rests on the product's architecture rather than on certification of a hosted platform: because Intent Architect does not host customer project content, the assets that a certification of our environment would cover are limited to operational service data, and the certifications of the underlying infrastructure providers apply to that hosting. Microsoft Azure and Cloudflare each maintain their own certifications for the infrastructure they provide - see [](xref:security-privacy.third-party-services-and-sub-processors).

Customers whose procurement process requires a completed security questionnaire can request one - see [Security inquiries](#security-inquiries).

## Security contact and vulnerability reporting

Security researchers and customers who believe they have found a vulnerability in Intent Architect should report it to <support@intentarchitect.com> rather than disclosing it publicly, so that it can be investigated and addressed.

Please include enough detail to reproduce the issue. We will acknowledge reports and keep the reporter informed of progress toward a fix.

<!-- TODO: confirm whether a dedicated security@intentarchitect.com alias should be used instead of support@,
     and whether a target acknowledgement window (e.g. 3 business days) can be committed to. -->

## Incident notification

Where Intent Architect becomes aware of a security incident affecting operational service data, we will investigate, take steps to contain and remediate the issue, and notify affected customers without undue delay, together with the information needed for them to assess their own obligations.

<!-- TODO: sample wording - confirm and adjust. Points typically expected by reviewers:
       - the notification window you are willing to commit to (e.g. "within 72 hours of becoming aware"),
       - who is notified (account/licence contact, technical contact),
       - the channel used (email to the account contact),
       - whether a post-incident report is provided on request.
     Note that because customer project content is not hosted by Intent Architect, an incident in our
     services cannot expose customer source code or models - worth stating explicitly once confirmed. -->

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
