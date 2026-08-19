## Security Overview  

### 1. Executive summary

Intent Architect is a **locally installed software development tool** used by developers on customer-managed workstations. It is architecturally similar to a desktop IDE rather than a hosted SaaS application.

The core security characteristic of Intent Architect is that **customer project content remains primarily within the customer’s own environment**. Source code, design models, project files, generated code, and related development assets remain on the developer’s machine and/or in the customer’s own repositories and storage systems unless the customer deliberately transmits data to an external service they have configured, such as an AI provider.

Intent Architect does operate a limited set of supporting cloud services for product operation, including licensing, update and module services, telemetry, crash/error reporting, and account-related services. These services process **operational service data**, which is separate from customer project content.

---

### 2. Product architecture

#### 2.1 Local-first application model

Intent Architect is installed and executed locally on customer-managed devices. Normal use of the product involves:

- opening and editing local project files;
- creating and maintaining design models;
- generating code into local solutions;
- interacting with local development environments and source control chosen by the customer.

Intent Architect does **not** provide a hosted cloud workspace for customer software projects.

#### 2.2 Supporting cloud services

Intent Architect uses a limited number of hosted supporting services for product operation, including:

- licence activation and validation;
- update checks;
- public module registry/distribution;
- telemetry collection;
- crash/error reporting;
- account/web-related services.

These services process operational service data rather than customer project content as part of normal product operation.

#### 2.3 AI integration model
Intent Architect supports AI-assisted workflows using customer-configured AI providers. In standard bring-your-own-provider configurations:

- requests are sent from the customer’s machine to the selected provider;
- provider credentials are stored locally on the customer machine;
- data handling for those requests is governed by the selected provider and the customer’s agreement with that provider.

This architecture means Intent Architect is not, by default, a central processor or long-term store of AI prompts, files, or outputs for bring-your-own-provider use.

---

### 3. Data classification model

For security and governance purposes, the following distinction is important.

#### 3.1 Customer project content

Customer project content includes:

- source code;
- design models;
- project files;
- generated code;
- prompts, AI inputs, and AI outputs;
- customer business documents and development artefacts.

Customer project content generally remains within customer-controlled environments.

#### 3.2 Operational service data

Operational service data includes:

- account and licensing data;
- technical product telemetry;
- crash and error diagnostics;
- service-operation metadata;
- update and module retrieval metadata.

Operational service data is separate from customer project content.

---

### 4. Data flow summary

#### 4.1 Local processing

The following are generally processed locally on the customer’s machine:

- source code and project files;
- design models;
- generated solution content;
- AI configuration settings stored on the machine;
- local context used during development workflows.

#### 4.2 Hosted service processing

The following may be processed by Intent Architect supporting services:

- account and licensing records;
- technical telemetry and usage events;
- crash/error diagnostics;
- service-operation metadata.

#### 4.3 AI provider processing

When a customer uses AI features, the following may be sent to the customer-selected AI provider depending on the requested task:

- prompts and conversation history;
- attached context;
- design/model snapshots;
- code or file content needed to complete the requested operation.

This processing path is controlled by the provider configuration selected by the customer.

---

### 5. Hosting and residency

Intent Architect supporting services are hosted using:

- **Microsoft Azure — Johannesburg, South Africa**
- **Cloudflare CDN — Europe**

Customer project content is generally not hosted by Intent Architect. Data residency for AI requests depends on the provider and endpoint selected by the customer.

---

### 6. Data separation and isolation

#### 6.1 Separation of project content

Intent Architect’s primary isolation model is architectural: customer project content remains in the customer’s own environment rather than being pooled into a shared Intent-hosted development workspace.

This means:

- customer code and project files remain under customer endpoint and repository controls;
- project content is not co-mingled in a central Intent-hosted project store as part of normal operation;
- customers retain control over where project content is stored and how it is secured.

#### 6.2 Separation of operational service data

Operational service data handled by supporting services is separate from customer project content and is limited to the categories required to operate, support, and improve the product.

Telemetry and diagnostics may be associated with a **pseudonymous identifier** such as a GUID-based account, user, or installation identifier for operational and support purposes.

---

### 7. Telemetry and crash diagnostics

#### 7.1 Nature of telemetry

Intent Architect collects technical telemetry and crash diagnostics as part of product operation and support.

Examples include:

- user authentication/login events;
- feature access events;
- process execution events;
- product usage and behaviour signals;
- performance/reliability indicators;
- software exceptions, errors, and crash details.

#### 7.2 Scope limitations

Telemetry and crash reporting are intended to collect **technical and operational information**, not customer project content.

They do not intentionally collect customer project content such as:

- source code;
- design models;
- project files;
- customer business documents;
- prompts or AI outputs from standard bring-your-own-provider workflows.

#### 7.3 Retention

Telemetry and crash diagnostics are retained for long-term product support, reliability analysis, usage analysis, and historical troubleshooting.

This data is retained **indefinitely**, subject to deletion on request where appropriate.

#### 7.4 User linkage

Telemetry may include a pseudonymous identifier associated with an account, user, or installation context. This identifier is used for technical and operational purposes and is not intended to represent customer project content.

---

### 8. AI security considerations

#### 8.1 Bring-your-own-provider control model

Intent Architect’s default AI model is customer-controlled configuration. Customers select:

- the AI provider;
- the endpoint/region;
- the credentials used;
- the provider relationship and contractual posture.

This allows customers to align AI usage with their own governance, data residency, and model-usage requirements.

#### 8.2 Intent Architect’s role

In standard bring-your-own-provider use:

- Intent Architect does not operate a general-purpose hosted repository for prompts and outputs;
- Intent Architect does not centrally store customer project content associated with those requests as part of normal operation;
- the applicable data-handling terms are those of the selected provider.

Customers with strict AI governance requirements should review the selected provider’s retention, training, logging, regional processing, and security terms separately.

---

### 9. Credential handling

AI provider credentials configured for use within Intent Architect are stored **locally on the user’s machine**.

Customers remain responsible for:

- securing developer endpoints;
- securing local operating-system accounts;
- managing access to local credential stores and developer environments;
- governing which external AI providers are approved for use.

---

### 10. Encryption and transmission security

Intent Architect communicates with supporting services and configured providers over network connections appropriate to those services.

The security posture for those services should be understood as:

- customer project content is primarily protected by remaining in customer-controlled environments;
- communications with hosted supporting services and third-party providers are expected to use standard encrypted transport protocols;
- data-at-rest protections for hosted supporting services are provided through the underlying hosted infrastructure and service architecture where applicable.

If a customer requires a deeper control-level breakdown of encryption or infrastructure safeguards, that information should be provided separately where available.

---

### 11. Customer responsibilities

Because Intent Architect is a locally installed development tool, customers remain responsible for many of the core controls around their project content, including:

- workstation security;
- endpoint hardening;
- local storage controls;
- repository access controls;
- network security;
- approved AI provider selection and configuration.

This local-first architecture gives customers direct control over the most sensitive project assets.

---

### 12. Trial, termination, and continued customer control

Because Intent Architect does not normally host customer project content, customer project files, code, and models remain in customer-controlled environments during and after any trial or commercial relationship.

Hosted supporting services may continue to hold operational service data such as:

- licensing/account records;
- telemetry;
- crash diagnostics;
- service-operation metadata,

subject to applicable retention practices and deletion requests.

---

### 13. Security inquiries

Customers conducting internal security, governance, or data-protection reviews may request additional information regarding:

- hosting regions;
- categories of operational service data;
- AI provider integration model;
- retention and deletion handling for operational service data;
- third-party supporting service providers.

---