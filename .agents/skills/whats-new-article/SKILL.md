---
name: whats-new-article
description: "Use when writing, editing, or reviewing monthly What's New in Intent Architect articles, including structure, highlight links, Update details sections, Available from version lists, and whats-new TOC updates."
---

# What's New Article Skill

Use this skill to create or refine monthly What's New articles under `articles/whats-new/`.

## Scope

This skill is for:

- New monthly What's New entries.
- Editing an existing monthly entry for consistency.
- Reviewing or fixing heading anchors, copy style, and release metadata.
- Updating `articles/whats-new/toc.yml` to include the new month.

This skill is not for:

- Deep product validation of feature claims.
- Generating release notes from source control history automatically.

## Canonical structure

Follow this structure in each month file (`articles/whats-new/YYYY/MM/index.md`):

1. H1 title:
   - `# What's new in Intent Architect (Month YYYY)`
2. Welcome line:
   - `Welcome to the Month edition of What's New in Intent Architect.`
3. `- Highlights` bullet list:
   - Each item links to a matching section anchor.
   - Use short benefit-driven summaries.
4. Optional `- More updates` list for secondary features.
5. `## Update details`
6. Repeated feature sections:
   - `### Feature name`
   - One or more short paragraphs.
   - Optional image(s).
   - `Available from:`
   - Version bullets (module/template/app version entries).
   - Keep section layout order consistent: value paragraph first, then image, then `Available from:`.

## Writing style

- Keep copy product-facing and concise.
- Lead with user value, then implementation details.
- Prefer declarative headings (not question headings).
- Keep naming consistent with product/module names.
- Keep link style consistent:
  - In-page anchors for highlights.
  - `xref:` links for internal docs references where applicable.

## Anchor and heading rules

- Every highlight link must map to an existing `###` heading.
- Use predictable heading text to avoid anchor mismatches.
- If a heading changes, update its highlight link.

## Images and media

- Store monthly images under `articles/whats-new/YYYY/MM/images/`.
- Use descriptive alt text.
- Keep screenshots relevant to the section they support.
- Do not invent image filenames or paths.
- If no approved screenshot exists yet, use an explicit placeholder marker (see examples) and require the author to either:
   - Replace it with a real image path, or
   - Remove the image line entirely.

## Version block rules

- Use this exact pattern:

```md
Available from:

- Module.Or.Product.Name x.y.z
```

- Include only versions that are known.
- Keep module names and version formatting consistent.

## TOC update rules

When adding a new month:

- Update `articles/whats-new/toc.yml`.
- Keep newest months at the top.
- Keep year groups in descending chronological order.
- Preserve existing structure and indentation.

## Quality checklist

Before finalizing:

- Structure matches canonical layout.
- Highlights and anchors are valid.
- Section order is logical.
- Spelling and grammar are clean.
- Product names and module names are accurate.
- Mandatory version verification step: verify all `Available from` versions against `.imodspec` and/or `release-notes.md` before finalizing.
- `Available from` lists are present for each feature section.
- TOC includes the month and points to the correct path.

## Starter template

```md
# What's new in Intent Architect (Month YYYY)

Welcome to the Month edition of What's New in Intent Architect.

- Highlights
  - **[Feature One](#feature-one)** - Short value statement.
  - **[Feature Two](#feature-two)** - Short value statement.

- More updates
  - **[Feature Three](#feature-three)** - Short value statement.

## Update details

### Feature One

Short description of user impact and behavior.

![TODO: Replace with approved screenshot path or remove this line](images/TODO-REPLACE-OR-REMOVE.png)

Available from:

- Module.Name 1.2.3

### Feature Two

Short description.

Available from:

- Module.Name 2.0.0

### Feature Three

Short description.

Available from:

- Product.Name 4.6.0
```

## Worked examples

### Example 1: Good Highlights to heading alignment

Use this pattern so each highlight points to an existing section heading:

```md
- Highlights
   - **[Angular Version Selection](#angular-version-selection)** - Choose the Angular version when creating a new Angular application.
   - **[Enhanced Advanced Mapping Screen](#enhanced-advanced-mapping-screen)** - Faster mapping workflows with improved filtering and performance.

## Update details

### Angular Version Selection

Feature details here.

### Enhanced Advanced Mapping Screen

Feature details here.
```

### Example 2: Feature section with image and version list

Use this section shape for each update item:

```md
### Automatic route parameter filtering in API documentation

Request body schema properties that duplicate route parameters are now filtered out automatically in generated API documentation, reducing confusion and duplicate documentation.

![TODO: Replace with approved screenshot path or remove this line](images/TODO-REPLACE-OR-REMOVE.png)

Available from:

- Intent.AspNetCore.Swashbuckle 5.2.3
- Intent.AspNetCore.Scalar 1.0.7
```

Image decision rule for the above example:

```md
<!-- Option A: real image -->
![Swagger route parameter filtering](images/swagger-route-param-filter-example.png)

<!-- Option B: no image available yet -->
<!-- Remove the image line entirely -->
```

### Example 3: Internal cross-reference to a docs article

Prefer `xref:` for internal documentation links:

```md
See the full article: [Practical Code Management Examples](xref:application-development.code-weaving-and-generation.practical-code-management-examples)
```

### Example 4: TOC insertion for a new month

When adding a new month, insert it at the top and keep chronology descending:

```yml
items:
- name: 'April 2026'
   href: '2026/04/index.md'
- name: 'March 2026'
   href: '2026/03/index.md'
- name: 'February 2026'
   href: '2026/02/index.md'
```

### Example 5: Avoid this mismatch

Do not link to anchors that do not match a heading:

```md
- **[Mapperly support](#mapperly-support)**

### Mapperly support for DTO mappings
```

Correct version:

```md
- **[Mapperly support for DTO mappings](#mapperly-support-for-dto-mappings)**

### Mapperly support for DTO mappings
```
