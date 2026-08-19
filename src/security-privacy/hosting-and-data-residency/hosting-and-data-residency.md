## Hosting & Data Residency Statement  

### 1. Overview
Intent Architect is a **locally installed software development tool**. It runs on customer-managed developer workstations and is architecturally comparable to other desktop development tools/IDEs.

As a general rule, **customer project content is not hosted by Intent Architect**. Source code, design models, files, and other project materials remain on the customer’s own machines, repositories, and infrastructure unless the customer deliberately sends data to a third-party service they configure, such as an AI provider.

This statement describes:

- what data is processed locally versus in supporting hosted services;
- where hosted supporting services are located;
- when data may leave the customer’s environment;
- how data residency depends on customer configuration for AI features.

---

### 2. Data categories

For clarity, Intent Architect distinguishes between the following categories of data:

#### 2.1 Customer project content
Customer project content includes:
- source code;
- design models;
- project files;
- generated code;
- prompts, inputs, and outputs used with AI features;
- other materials belonging to the customer’s software project.

Customer project content is generally processed and stored **locally in the customer’s environment** and/or in the customer’s own source control and storage systems.

#### 2.2 Operational service data

Intent Architect also processes limited operational service data required to operate and support the product, including:
- account and licensing data;
- update and module retrieval requests;
- technical product telemetry;
- crash and error diagnostics;
- service-operation metadata.

Operational service data is separate from customer project content.

---

### 3. Where data is processed and stored

#### 3.1 Customer project content
Intent Architect does **not** operate a hosted cloud workspace for customer project content.

Customer project content is generally:
- processed on the developer’s local machine;
- stored on that machine, on customer-managed storage, and/or in customer-managed source control repositories;
- controlled by the customer’s own endpoint, storage, network, and repository security arrangements.

#### 3.2 Intent Architect supporting services
Intent Architect operates a limited set of supporting services for product operation, such as:
- licence activation and validation;
- update checks;
- public module registry/distribution;
- telemetry collection;
- crash/error reporting;
- web/account-related services.

These supporting services are hosted using:
- **Microsoft Azure — Johannesburg, South Africa**
- **Cloudflare CDN — Europe**

These services process **operational service data**, not customer project content as part of normal product operation.

---

### 4. AI features and data residency
Intent Architect’s AI capability is **bring-your-own-provider** by default.

When a customer uses AI features, prompts and context are sent from the customer’s machine to the AI provider the customer has configured. Depending on the feature and task, that data may include:
- prompts and conversation history;
- attached context files;
- model/design snapshots;
- file contents read from the local codebase for the requested task.

Intent Architect does not provide a central hosted AI relay for standard bring-your-own-provider usage. Accordingly:

- AI data residency depends on the **provider, endpoint, and region selected by the customer**;
- any transfer, processing, storage, retention, or model-use policy for AI requests is governed by the customer’s agreement and configuration with that provider.

Where Intent Architect may offer provider-backed AI access or credits, the applicable provider path and retention model for that feature should be reviewed separately.

---

### 5. Data residency summary by category

| Data category | Typical location | Residency control |
|---|---|---|
| Customer project content | Customer-managed machines, repositories, and storage | Controlled by customer |
| Account and licensing data | Intent Architect supporting services | Microsoft Azure Johannesburg, South Africa |
| Technical telemetry | Intent Architect supporting services | Microsoft Azure Johannesburg, South Africa |
| Crash/error diagnostics | Intent Architect supporting services | Microsoft Azure Johannesburg, South Africa |
| Update/module delivery traffic | Intent Architect supporting services / CDN | Azure Johannesburg and Cloudflare Europe |
| AI prompts, inputs, outputs, and context | Customer-configured AI provider | Controlled by selected provider/endpoint |

---

### 6. International data transfers

Operational service data processed by Intent Architect supporting services may be processed in the hosting regions used for those services, including South Africa and Europe. AI-related data may be processed in the region used by the customer’s selected AI provider. Customers with region-specific residency requirements should assess both Intent Architect’s supporting service locations and the location of any third-party providers they choose to use.

- operational service data processed by Intent Architect supporting services may be processed in **South Africa**;
- content delivered via CDN may involve **European Cloudflare infrastructure**;
- AI-related data may be processed in whatever region is used by the **customer’s selected AI provider**.

Because Intent Architect is primarily a locally installed tool, customer project content ordinarily remains in the customer’s own environment unless the customer chooses to transmit it to an external provider.

---

### 7. Data hosted by Intent Architect vs. not hosted by Intent Architect

#### 7.1 Not hosted by Intent Architect as part of normal operation

Intent Architect does **not** host customer project workspaces or repositories containing:

- source code;
- project files;
- design models;
- generated code;
- customer business documents.

#### 7.2 Hosted by Intent Architect supporting services

Intent Architect supporting services may host:

- account and licensing records;
- technical telemetry and product usage events;
- crash/error diagnostics;
- service-delivery and operational metadata.

---

### 8. Telemetry and crash diagnostics

Intent Architect collects technical telemetry and crash diagnostics as part of operating and supporting the product.

This data is:
- technical and operational in nature;
- related to product usage, feature access, process execution, product behaviour, and software errors;
- separate from customer project content.

Telemetry and crash reporting do **not** include customer project content such as:
- source code;
- design models;
- project files;
- prompts;
- AI outputs;
- generated solution content.

Telemetry and diagnostics may be linked to a **pseudonymous identifier** (for example, a GUID-based user or installation identifier) for service operation and support purposes.

---

### 9. Customer control considerations

Customers who have data residency or AI governance requirements should note:

- customer project content remains under customer control unless deliberately transmitted elsewhere;
- AI provider selection is customer-controlled in bring-your-own-provider configurations;
- residency for AI interactions should therefore be assessed against the customer’s chosen provider and endpoint;
- operational service data processed by Intent Architect is separate from customer project content and is hosted as described above.

---

### 10. Further information

Intent Architect can provide additional information on request regarding:

- categories of operational service data processed;
- AI integration model;
- supporting service providers involved in service delivery;
- retention and deletion handling for operational service data.

---

