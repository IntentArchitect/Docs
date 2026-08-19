## Overview
Intent Architect is primarily a **locally installed software development tool / IDE**, architecturally comparable to tools such as Visual Studio Code, JetBrains Rider, or Cursor, rather than a hosted SaaS platform.

That distinction matters for security, privacy, and data governance.

Customer project content — including source code, design models, project files, generated code, prompts, inputs, and outputs — generally remains on the developer’s machine and in the customer’s own source control and storage systems. Intent Architect does **not** operate a hosted cloud workspace that ingests or stores customer project content as part of normal product use.

Intent Architect does operate a limited set of supporting services for product operation, including licensing, update checks, module distribution, telemetry, crash/error reporting, analytics, and account-related services. These services process **operational service data**, which is separate from customer project content.

AI usage in Intent Architect is **bring-your-own-provider** by default. When AI features are used, requests go from the developer’s machine directly to the AI provider configured by the customer. This allows customers to align AI use with their own governance, security, residency, and provider approval requirements.

---

## Core principles

### 1. Local-first by design
Intent Architect is designed as a locally installed development tool. Customer project content remains primarily within customer-controlled environments rather than being stored in a shared hosted Intent platform.

### 2. Separation of project content and operational data
We distinguish between:
- **customer project content** — such as code, models, files, prompts, and outputs; and
- **operational service data** — such as licensing records, telemetry, crash diagnostics, and service-operation metadata.

This distinction is central to how Intent Architect is operated and assessed.

### 3. Customer-controlled AI provider selection
Intent Architect does not require a single mandated AI provider. Customers choose which provider, endpoint, and credentials to use, which means AI processing can be aligned to internal security and governance policies.

### 4. Limited supporting services
We use a limited number of supporting services for product operation and delivery, separate from customer project content. These services support functions such as licensing, updates, diagnostics, analytics, billing, and account administration.

---

## What Intent Architect does not normally host
As part of normal product operation, Intent Architect does **not** operate a hosted repository for customer project content such as:
- source code;
- project files;
- design models;
- generated code;
- customer business documents;
- AI prompts, inputs, or outputs from standard bring-your-own-provider use.

These materials ordinarily remain within the customer’s own environment unless the customer deliberately transmits them to a third-party service.

---

## What Intent Architect does process
Intent Architect supporting services may process:
- account and licensing data;
- technical product telemetry;
- crash and error diagnostics;
- update/module delivery metadata;
- billing and invoicing information, where applicable;
- support and commercial correspondence.

Telemetry and diagnostics are technical in nature and are intended to support product operation, troubleshooting, reliability analysis, and product improvement. They are separate from customer project content.

---

## Hosting and regional considerations
Intent Architect supporting services are hosted using:

- **Microsoft Azure — Johannesburg, South Africa**
- **Cloudflare CDN — Europe**
- **Mixpanel EU** for telemetry/analytics services

Because AI usage is customer-configured, AI-related data residency depends on the provider and region selected by the customer.

---

## Available trust documentation

Customers conducting internal security, privacy, AI governance, or procurement reviews may request or review the following documentation:

- **Hosting & Data Residency**
- **Security Overview**
- **Privacy Notice**
- **Third-Party Services and Sub-processors**
- **AI Data Privacy**
- **Telemetry collection**

These documents describe our operating model, data categories, supporting service providers, AI integration model, and regional considerations in more detail.

