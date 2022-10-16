---
uid: application-development.code-weaving-and-generation.about-code-management-typescript
---
# TypeScript Code Management

This article explains how to control [Code Management](xref:application-development.code-management.about-code-management) (Code Weaving) behaviour for TypeScript files. The following table describes the various instructions that may be used to control which parts of the codebase Intent Architect manages, and which parts are managed by the developers, at a very fine-grained level of control.

| Instruction | Description                                                                                                                                                                    |
|------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `@IntentIgnore()`    | Instructs Intent Architect to ignore this member (i.e. do not update or remove it). |
| `@IntentIgnoreBody()`    | Instructs Intent Architect to ignore the body of the member, but allows it to manage the signature. |
| `@IntentMerge()`   | Instructs Intent Architect to manage this element, allowing adding, updating, but not removing, of its child members. |
| `@IntentManage()`   | Instructs Intent Architect to manage this element, allowing adding, updating and removing of its child members. |
| `@IntentManageClass()`   | Instructs Intent Architect to manage this class, allowing adding, updating and removing of its child members. Additional management options can be supplied to this instruction to instruct Intent Architect how to treat `methods`, `properties` and `constructors`. |

> [!NOTE]
> Instructions can be applied as decorators or comments to any of the following declarations: `class`, `interface`, `method`, `property`, `function`, or `constant`.