## Third-Party Services and Sub-processors  
**Intent Architect**

### 1. Overview

Intent Architect is a **locally installed software development tool**. As part of delivering, operating, and supporting the product and related commercial processes, we use a limited number of third-party service providers.

This document identifies third parties that may process **operational service data**, **commercial/account data**, or related service information in connection with Intent Architect.

For clarity:

- **Customer project content** means source code, design models, project files, prompts, AI inputs/outputs, generated code, and other materials belonging to a customer’s software project.
- **Operational service data** means account data, licensing records, technical product telemetry, crash diagnostics, update/module delivery metadata, and related service-operation information.
- **Commercial and billing data** means customer contact details, company details, billing records, invoices, and payment-related information associated with the commercial relationship.

Intent Architect does **not** use a hosted multi-tenant workspace for customer project content as part of normal product operation. Customer project content generally remains on customer-managed machines and repositories unless the customer elects to send data to a separately configured third-party service, such as an AI provider.

---

### 2. Third-party providers used by Intent Architect

| Provider | Service | Data categories involved | Hosting / processing region | Role |
|---|---|---|---|---|
| **Microsoft Azure** | Hosting of Intent Architect supporting services, including licensing, validation, service APIs, telemetry/crash-related services, update-related services, and account-related services | Account data, licensing records, technical telemetry, crash/error diagnostics, service-operation metadata | Johannesburg, South Africa | Cloud infrastructure provider |
| **Cloudflare** | Content delivery and network edge services for public-facing delivery and distribution | Request metadata, delivery logs, network/edge service data, content delivery metadata | Europe | CDN and network services provider |
| **Mixpanel** | Product telemetry and analytics | Technical product usage events, feature access events, process execution events, product metrics, pseudonymous identifiers, operational analytics data | Subject to Mixpanel service configuration and contractual terms | Analytics provider |
| **Stripe** | Payment processing, where customers elect to use card-based payment | Billing/contact/payment transaction data, payment-related metadata, commercial transaction information | Subject to Stripe service configuration and contractual terms | Payment processor |
| **Xero** | Billing, invoicing, and accounting administration associated with customer relationships | Customer/company contact details, billing details, invoice records, transaction records, commercial/accounting information | Subject to Xero service configuration and contractual terms | Accounting and invoicing provider |

---

### 3. Provider categories

#### 3.1 Infrastructure and service delivery providers

These providers support the operation and delivery of Intent Architect services:

- Microsoft Azure
- Cloudflare

These providers may process operational service data required to host, deliver, and support Intent Architect-related services.

#### 3.2 Product analytics and diagnostics providers

These providers support analysis of product usage and behaviour:

- Mixpanel

Mixpanel is used for technical product telemetry and analytics relating to product usage, feature access, process execution, and operational behaviour. This telemetry is separate from customer project content.

#### 3.3 Commercial and billing providers

These providers support payment, invoicing, and accounting administration:

- Stripe
- Xero

Stripe is used where customers elect to use card-based payment processing.  
Xero is used for invoicing and accounting administration associated with the commercial customer relationship. It is not part of the Intent Architect application runtime, but may process customer billing and contact information.

---

### 4. AI providers

Intent Architect supports **bring-your-own-provider** AI integrations. In these cases, prompts, inputs, outputs, and contextual data are sent from the customer’s machine to the AI provider the customer selects and configures.

Because these providers are chosen by the customer, they are generally best understood as **customer-selected third parties**, rather than default Intent Architect sub-processors for standard product operation.

Potential providers may include, depending on customer configuration:

- OpenAI
- Anthropic
- Microsoft Azure OpenAI
- Google Gemini
- OpenRouter
- Ollama
- Other OpenAI-compatible or customer-specified providers

In these configurations:

- Intent Architect does not centrally host customer AI traffic as part of normal bring-your-own-provider operation;
- data handling, retention, residency, and model-use terms for AI requests are governed by the selected provider and the customer’s agreement with that provider.

If Intent Architect offers any provider-backed AI access, credits, or managed routing as part of a separate service feature, the applicable provider path for that feature should be assessed separately.

---

### 5. Categories of data not processed by default supporting services

Intent Architect’s default supporting services are **not intended to host customer project content** such as:

- source code;
- design models;
- project files;
- generated code;
- customer business documents;
- prompts and AI outputs from bring-your-own-provider usage.

Such content ordinarily remains under customer control in customer-managed environments unless the customer deliberately transmits it to a third-party provider.

---

### 6. Telemetry and crash diagnostics

The operational data processed by Intent Architect supporting services and analytics providers may include:

- user login/authentication events;
- feature access events;
- product process execution events;
- technical usage and behaviour events;
- exception, error, and crash diagnostics;
- pseudonymous identifiers used to associate operational events with an account, installation, or user context.

This operational data is technical in nature and is separate from customer project content.

---

### 7. Commercial and billing data

Commercial and billing providers may process information such as:

- customer and company names;
- billing contact information;
- invoice records;
- payment transaction information;
- accounting and financial administration records.

This data relates to the commercial relationship and is separate from customer project content and technical product telemetry.

---

### 8. Changes to providers

Intent Architect may update its third-party providers from time to time as operational needs evolve. Updated provider information can be made available on request or through updated trust/privacy documentation, as applicable.

---

### 9. Contact

For questions regarding third-party processing, hosting, analytics, billing, or data categories, customers may request additional information through Intent Architect’s commercial or support contact channels.