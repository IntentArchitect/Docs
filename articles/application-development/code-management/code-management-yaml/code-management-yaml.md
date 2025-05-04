---
uid: application-development.code-weaving-and-generation.about-code-management-yaml
---
# YAML Code Management

This article explains how to control [Code Management / Merging](xref:application-development.code-management.about-code-management) behaviour for `.yaml` files when using the `Intent.Code.Weaving.Yaml` module.

## Overview

The YAML merger parses `.yaml` files into a graph of nodes and recursively applies code management logic to each node.

It compares the generated content from templates with the existing file (if present) on a node-by-node basis. Special instructions guide the merger on whether to ignore, merge, replace, or remove specific nodes.

## Code Management Instructions

Instructions are embedded directly in the YAML as comments (e.g., `# IntentIgnore`) above the relevant node. These tell the merger how to treat that node during the merge process.

## Node-Level Management Modes

- **`# IntentFully`** - Intent Architect has full control over the node. Any manual changes in the existing file will be overwritten. Child nodes can override this by using a different instruction.
- **`# IntentMerge`** - Intent Architect will add and remove *generated* nodes, but will not delete manually added content.
- **`# IntentIgnore`** - Intent Architect will skip the node entirely, leaving it untouched. All child nodes are ignored as well, and cannot override this behavior.

## File-Level Management Modes

Due to YAML’s structure, placing `# IntentIgnore` at the top of a file creates ambiguity — does it apply to the whole file or just the first node?

To resolve this, **file-level** instructions have been introduced:

- **`# IntentFullyFile`** - Intent Architect has full control over the entire file. Any changes will be overwritten by the template, unless overridden on specific nodes.
- **`# IntentMergeFile`** - Intent Architect adds and removes generated nodes, but preserves manually added content.
- **`# IntentIgnoreFile`** - The entire file is ignored by the merger.

### Example Comparison

``` yaml
# IntentFully
name: John Smith
age: 33
```

In this example, only the name field is controlled by Intent Architect.

``` yaml
# IntentFullyFile
name: John Smith
age: 33
```

Here, the entire file is managed by Intent Architect.

## Default behaviour

By default, templates operate in `Merge` mode. This default can be changed in the [settings](xref:module-building.application-settings) for your application:

![Yaml Merger Settings](images/yaml-merger-settings.png)

## Node Matching

The merger correlates nodes in the existing file with nodes in the generated content using:

- Field names for object properties.
- Order or scalar value for array items.

### Matching Scalar Values in arrays

For cases where you want to replace a particular value in an array, use the `(Match = "<starts with value>")` parameter to the above instructions, e.g. `# IntentIgnore(Match = "SomeValue")`.

``` yaml
names:
  - Alice
  - Bob
  - Charles
```

If you wanted to replace `Bob` with a value, you can do the following:

``` yaml
names:
  - Alice
  # IntentIgnore(Match = "Bo")
  - John
  - Charles
```

As `Bob` in the generated value starts with the string of `Bo` the items correlate.

### Matching Objects in Arrays by Field Value

Use `# IntentMatchBy` above an array to specify how array items should be matched.

Consider the following *generated* file:

``` yaml
customers:
  - customer:
      customerNumber: 00001
      name: Generated Name 1
  - customer:
      customerNumber: 00002
      name: Generated Name 2
```

And you want to override just the generated name to have a different value, so you ignore the field:

``` yaml
customers:
  - customer:
      customerNumber: 00001
      # IntentIgnore
      name: Modified Name
  - customer:
      customerNumber: 00002
      name: Generated Name 2
```

The above won't work reliably as the merger also needs to be instructed that it should match items by the `customerNumber` field, which can be done as follows:

```yaml
# IntentMatchBy("customerNumber")
customers:
  - customer:
      customerNumber: 00001
      # IntentIgnore
      name: Modified Name
  - customer:
      customerNumber: 00002
      name: Generated Name 2
```

You can also match on **multiple fields**. In the example below both `regionCode` and `customerNumber` fields must be the same for the objects to be considered a match.

```yaml
# IntentMatchBy("regionCode", "customerNumber")
customers:
  - customer:
      regionCode": 01
      customerNumber: 00001
      # IntentIgnore
      name: Modified Name
  - customer:
      regionCode": 02
      customerNumber: 00002
      name: Generated name for customer in region code 2
```

> [!NOTE]
> If a template includes `# IntentMatchBy` in the generated content, it may not be output in the generated YAML file, but the merger will still apply the matching logic internally.
