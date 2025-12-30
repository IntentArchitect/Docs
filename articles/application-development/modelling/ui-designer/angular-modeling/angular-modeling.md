---
title: Angular UI Modeling with AI
description: Use Intent Architect to build professional Angular UIs rapidly with deterministic and AI-driven code generation.
keywords: angular, intent architect, material, ai, software factory, llm, code generation
---

## Angular UI Modeling with AI

This article will show you how you can use Intent Architect to rapidly build professional-looking UIs, using a combination of both deterministic (pattern reuse) and non-deterministic (LLMs driven by Intent Architect) code generation techniques.

How this works at a high level is as follows:

- Design and generate your **View Model**s. This includes aspects like which Services to interact with and where UI navigations are going.  
  ![Model View Model](./images/basic-viewmodel-design.png)

- Use our "Implement with AI" accelerator to get the LLM of your choice to build the **View** in a "prompt-less" fashion. Intent Architect handles the context engineering and manages the LLM interactions on your behalf. The results can be reviewed as a code diff of what the LLM proposes, similar to a regular **Software Factory** execution.  
  ![AI Generates View](./images/ai-review.png)

- Review and validate the code. As always when dealing with LLMs, you will want to review and validate the code. By their nature LLMs are non-deterministic, but with a little bit of luck you should end up with a screen similar to this:  
  ![Generated Front ends](./images/genarate-search.png)

> [!NOTE]  
> While the samples here use Material Components, there is nothing inherently Material-specific about the implementation, and you can adjust the configuration for other component libraries.

> [!NOTE]  
> The Angular modules and application template are currently in **beta**. While we make every effort to make sure the code is bug free, unexpected issues still might occur. If you do encounter any issues, please do let us know so we can address them.  
> Please refer to the [Known Issues and Snags](#known-issues-and-snags) for known issues and limitations which we are actively working at resolving.

---

## Design and Generate Your View Model

To start, create a Angular Web Application in Intent Architect.

  ![Angular Web Application](./images/angular-template.png)

> [!NOTE]  
> The Angular modules and architecture template are currently in beta. Make sure `Include prerelease` is ticked to see the architecture templates and modules.

> [!NOTE]  
> There is a comprehensive Angular Sample application available if preferred. When creating a new application, instead of selecting the `Angular Web Application` template, select the **Explore Samples** on the left hand side, and select `Angular Web Application` here.

When creating the application make sure the `Angular AI`, `Material` and `Http Clients` components are all selected (they will be ticked by default):

  ![Angular Web Application](./images/angular-components.png)

### Initial Code Gen and Module Installation

Run the **Software Factory** to generate the initial application structure and infrastructure code.

Before the application can be run, the referenced modules need to be installed. Open a Console window to the output location of your application (a shortcut to the path can be found at the bottom of the Software Factory execution windows)

Execute the following command to install the modules:

``` cmd
npm i
```

Once finished, you can run the following to run the application:

``` cmd
ng serve
```

### How to Model Pages

1. Add a `Page` to a diagram in the **UI Designer**.  
2. Name the `Page`, typically describing its function (e.g., `CustomerSearch` or `CustomerAdd`).  
3. *Optional*: Adjust the route in the property pane.  

![Page Added](./images/add-page.png)

### Adding Route parameters to your page

If your page requires **Route Parameters** (e.g., `customers/edit/{customerId}`), you can model these as follows:

1. Right-click on the `Page` → **Add Property**.  
2. Name the property (e.g., `CustomerId`) and set its type (e.g., `Guid`).  
3. Apply the `Route Parameter` stereotype to the property using **F3**.  

![Page with Route Parameters Added](./images/add-page-with-route.png)

The page route will automatically update based on the route parameters.

---

### How to Model a Dialog

1. Add a `Page` to a diagram in the **UI Designer**.  
2. Name the `Page`, suffixed with the word **Dialog** (e.g., `CustomerAddDialog`).  

![Dialog Added](./images/add-dialog.png)

If your dialog requires parameterization, you can model that as follows:

1. Right-click on the **Dialog** → **Add Property**.  
2. Name the property (e.g., `CustomerId`) and set its type (e.g., `Guid`).  
3. Apply the `Route Parameter` (or `Bindable`) stereotype using **F3**.  

![Dialog with Route Parameters Added](./images/add-dialog-with-parameters.png)

---

FROM HERE

### How to Model UI Navigation

#### Navigation to a Page

1. Right-click on the `Page` (Page, Dialog) → **Add Navigation**.  
2. Connect the navigation arrow to the destination by left-clicking the destination.

#### Navigation to a Dialog

1. Right-click on the `Component` (Page, Dialog) → **Add Operation**.  
2. Name your operation (e.g., `AddNewCustomer`).  
3. Right-click on the operation → **Show Dialog**.  
4. Connect the navigation to the destination by left-clicking the **Dialog** destination.

![Navigation Modeled](./images/navigation.png)

If your `Component` has `Route Parameters`, a mapping dialog will open for you to bind those parameters. Typically you would simply add these parameters to your navigation `Operation`.  

![Map Route Parameters](./images/map-route-parameters.png)

---

### Modeling Service Interactions

UI `Component`s interact with services to retrieve data and to affect change on the system. This is how we model this behaviour.

1. On the `Component`'s suggestions, click the `Call Backend Service` suggestion.  
2. On the **Call Backend Service** dialog select the service endpoint you want to call.  

> [!NOTE]  
> If you are not seeing the Services you want to call, [add a package reference to the `Service Package` which contains those Services in the UI Designer](#connecting-your-ui-components-to-services-in-other-applications).

![Call Backend Service to Fetch Data](./images/call-backend-service-fetch.png)

Depending on the nature of the service being invoked, the default setup is slightly different:

- For `Query`s: the result is added to the `Component` as a property, and request parameters are modeled as `Operation` parameters.  
- For `Command`s: a corresponding `Model Definition` is created, based on the command, and added to the `Component`. This model is mapped to the command for invocation. Typically for `Command`s you want a separate model which may have additional view concerns.

---

### Connecting Your UI Components to Services in Other Applications

When modeling service invocations, you may want to connect to Services defined in applications beyond your UI application.

To use these services in your UI application:

1. In the `User Interface Designer`, under the `User Interface Package`, right-click `References` → **Add a Package Reference**.  
2. In the `Package Reference Manager` dialog, select the package containing the Services (e.g., `OtherApplication.Services`).  

![Add Package Reference](./images/add-package-reference.png)

You can now use these external services in the diagrams of the UI application.

> [!NOTE]  
> You will also need the appropriate integration module installed to make the remote communication work - currently the only integration client available is `Intent.Angular.HttpClients` (this module is selected by default when creating a new Angular application)

---

## Implement Your View with AI

> [!TIP]  
> You will need to install the `Intent.AI.Angular` module and connect Intent Architect to an LLM API of your choice. Ensure that the required [User Settings](https://docs.intentarchitect.com/articles/modules-common/intent-common-ai/intent-common-ai.html#user-settings) have been completed — including a valid API key for your selected AI provider. The time and accuracy of the AI prompt results will vary depending on your provider and model. Try a few and find the combination which works best for your preferred workflow.

Once you are satisfied with your **View Model** design, you can use the Angular AI accelerator to have AI generate the remaining implementation details.

> [!NOTE]  
> Don't forget to apply your **Software Factory** before running AI prompts, as the generated code is input/context for the AI.

### Generate Your View with AI

1. Make sure you have run and applied the **Software Factory**.  
2. Right-click on the `Component` → **Implement with AI**.  
3. *(Optional)* Adjust the settings in the AI Prompt dialog.  
4. Click **Done** — IA will generate and submit a prompt to the LLM (this may take a little while).  
5. Review the AI's proposed changes as a code diff.  
6. Click **Apply** to accept the changes.  

![Implement with AI](./images/implement-ai-dialog.png)

> [!NOTE]  
> AI by its nature is non-deterministic. While we put a lot of effort into making this interaction as predictable as possible, results will vary. Test the results and make changes as desired.

---

### Implement Your Layout with AI

1. Make sure you have run and applied the **Software Factory**.  
2. Right-click on the `Layout` → **Implement with AI**.  
3. *(Optional)* Adjust the settings in the AI Prompt dialog.  
4. Click **Done** — IA will generate and submit a prompt to the LLM (this may take a little while).  
5. Review the AI's proposed changes as a code diff.  
6. Click **Apply** to accept the changes.  

On a `Layout` the `Implement with AI` will generate a menu structure based on the navigation items added to the layout. Menu items can manually be added if required, as well manually adjusted (e.g. menu item ordering) when required.

---

### Application Styling

Out of the box, the application will be styled by two stylesheets, `styles.scss` and `theme.scss`, which use the Material themes. These two files (along with the components specific style sheets) can manually be updated or modified to suite your styling.

If you use the implementation out the box, the color themes (Primary and Accent colors) can be adjusted in the `Application Settings`:

![Color Theme](./images/color-theme.png)

---

### Improving the Results of AI

Hopefully you are getting good consistent results "out of the box" with the AI Prompt, but there are several things you can do to tweak/improve the results even further.

#### Additional User Prompt Context

You typically don't have to provide additional context to the LLM, but if you find it frequently making the same mistakes or you need to give it more guidance (e.g., how to refactor code it previously generated), you can provide extra instructions in the AI dialog. Examples:

- "Ensure buttons/actions exist for the new navigations I added."  
- "Refresh the grid if the add customer dialog closes successfully."  
- "Ensure you have controls for adding and removing addresses."  

#### Using a Template

You can select a template to further guide the AI. These templates contain:  

- Additional rules and guidance for the AI  
- Sample implementations  

![Select a Template](./images/select-a-template.png)

There are several pre-configured MudBlazor templates for various types of Pages and Dialogs. These templates are also designed to automatically select the correct template based on your `Component` naming convention (this can be adjusted as required).

| Template                | Keywords                             |
|-------------------------|--------------------------------------|
| Page - Search Entity    | search, find, list, lookup           |
| Page - Add Entity       | add, create, new, insert, register   |
| Page - Edit Entity      | edit, update, modify, change         |
| Page - View Entity      | view, details, detail, show          |
| Dialog - Add Entity     | dialog, add, create, new, insert     |
| Dialog - Edit Entity    | dialog, edit, update, modify, change |

> [!NOTE]  
> [These templates can easily be customized, extended or replaced](#angular-ai-prompt-augment-and-customization-through-templates). They could even be changed to work for a completely different component library.

#### Giving It an Example

If you already have an example of a similar screen to the one you are trying to create, you can simply select it in the **Example Components**. This will submit code associated with that `Component` to guide the AI.

Occasionally, the LLM might generate the layout of the **Add Entity** and **Edit Entity** pages differently - the *Example Component* in conjunction with additional context ("*ensure the layout of the edit page is the same as the add page*") can prove helpful in aligning the layout of the screens.

---

## Try to Keep Your ViewModel Managed

In this approach you have used both deterministic and non-deterministic code generation.  

- Everything you modeled will be generated deterministically through the **Software Factory** in the **ViewModel** (e.g., `customer-add.component.ts`).  
- The AI/LLM will generate the code in the **View** (e.g., `customer-add.component.html` and `customer-add.component.scss`), and may augment or change some code in the **ViewModel**.  

Implications/considerations:  

- The **ViewModel** runs in *Merge* mode by default. This means both systems can operate there smoothly.  
- If the AI changes deterministic code in the **ViewModel**, the Software Factory may not be able to automatically merge the changes and may attempt to undo or duplicate code blocks.  
- Ideally, you can refactor the code and/or add explicit [**Code Management**](xref:application-development.code-management.about-code-management) instructions to the point where Intent Architect can merge code automatically.  
- If not possible, you may need to add the `@IntentIgnore()` decorator.

---

## Known Issues and Snags

Below are a list of known issues and limitations which we are actively working on addressing:

- **Multiple AI agent execution**: Currently the `Implement with AI` functionality is per page/component. As such, if you make a change which effects multiple pages (e.g. adding an "Add Entity" navigation to a "Search" page) then the `Implement with AI` functionality is required to be run on both pages to get the full end to end implementation to be functional.
- **Import removal**: When page A references page B, an `import` statement is automatically added to page A which references page B. However, if page B is deleted or the reference is no longer required, the `import` statement is not automatically removed. This could result in non-compiling code if the page no longer exists. To resolve, manually remove any offending `import` statements.
- **Traditional Services Support**: Currently only CQRS Services are officially supported. Traditional Services may partially work, but has not been explicitly tested. We are working on fully supporting Traditional Services.
- **Limited Weaving Capabilities** (especially compared to C#): The weaving capabilities of Typescript are not as mature as that of C#, so there are some use cases where an *IntentMerge* might not operate the same way as the C# *IntentMerge* does. In these cases, it is best to *IntentIgnore* the method.

---

## Angular AI Prompt Augment and Customization Through Templates

The Angular AI prompting can be further extended through **AI Prompt Templates**. Out of the box these come pre-configured for Material, but the system is simple and extensible. Embrace it, extend it, or completely re-configure it — the choice is yours.

Look in the following folder within your Intent Architect Solution:

```cmd
.\intent\AI.Prompt.Templates\{application name}\Intent.Modules.AI.Angular.Generate
```

You will find:  

- `prompt.md` (generic prompt rules, limitations and instructions)
- `prompt-config.json` (prompt configuration)
- Folders containing sample code files for the various templates  
- Template specific markdown (template specific rules, limitations or instructions

![AI Prompt Config Folder](./images/ai-prompt-folder.png)

---

### Prompt Overview

The main prompt (`prompt.md`) is a readable markdown file, which can be adjusted to suite your specific rules and requirements.

This file contains the generic rules, limitations and instructions for the prompt, including:

- Component Libraries (including versions)
- Styling guides and rules (using Material)
- Rules for when and how to modify existing code
- Rules for navigation between components

#### Template Specific Prompt

Each template also has its own markdown file (e.g. `add-entity.md`) which contain any additional template specific rules to be passed to the LLM.

### JSON Schema Overview

The `prompt-config.json` file defines templates which define **reusable AI prompt blueprints** for common scenarios (e.g., Search Page, Add Dialog). They include:  

- **id** → Unique identifier  
- **name** → Human-friendly label  
- **description** → What the template does  
- **applicability** → Keywords that help Intent Architect pick the most appropriate template  
- **template-folder** → The folder containing sample files  
- **metadata** → Template-specific context  
- **rules** → Additional template-specific rules  

#### Example Template: *Search Entity Page*

```json
{
  "id": "SearchEntity",
  "name": "Page - Search Entity",
  "description": "Search Entity",
  "applicability": {
    "key-words": [
      { "word": "search", "weight": 3 },
      { "word": "list", "weight": 3 }
    ]
  },
  "template-folder": "SearchEntity"
}
```

---

### Example Template Types

The schema already defines several templates:

- **Page Templates**  
  - `SearchEntity` → Generates search/listing pages  
  - `AddEntity` → Generates entity creation pages  
  - `EditEntity` → Generates entity update pages  
  - `ViewEntity` → Generates read-only entity views  

- **Dialog Templates**  
  - `AddEntityDialog` → Generates dialogs for adding entities  
  - `EditEntityDialog` → Generates dialogs for editing entities  

Each template includes its **own rules** to ensure compliance with Material and project conventions.

---

### Extending Configuration

To extend the configuration:  

1. **Add new rules** in `prompt.md` (global) or under a specific `template` markdown.  
2. **Create a new template** in `prompt-config.json` by adding an object under `templates`.  
   - Define keywords under `applicability`.  
   - Specify a `template-folder` with an example implementation.  

#### Example A: Bulk Import Entities

```json
{
  "id": "BulkImportEntities",
  "name": "Page - Bulk Import Entities",
  "description": "Upload a CSV/Excel file, preview parsed rows, validate, and commit in bulk.",
  "applicability": {
    "key-words": [
      { "word": "import", "weight": 3 },
      { "word": "upload", "weight": 3 },
      { "word": "bulk", "weight": 3 },
      { "word": "csv", "weight": 2 },
      { "word": "excel", "weight": 2 },
      { "word": "batch", "weight": 2 }
    ]
  },
  "template-folder": "BulkImportEntities",
  "metadata": {},
  "rules": [
    
  ]
}
```

Rules in the template specific markdown file:
> Provide a file input and a server-side parse action; reuse existing parse/validate/commit methods if available.  
> Render a preview table with paging and basic filtering using mat-table or mat-grid-list.  
> Use official enum values for component parameters (no raw strings).  
> Show success/error toasts/dialogs using existing notification services if present.  

##### Example B: Upsert Template

```json
{
  "id": "AddOrUpdateEntity",
  "name": "Page - AddOrUpdate Entity",
  "description": "Create a new entity or update an existing one, using a single page flow (upsert).",
  "applicability": {
    "key-words": [
      { "word": "add", "weight": 3 },
      { "word": "create", "weight": 3 },
      { "word": "new", "weight": 2 },
      { "word": "insert", "weight": 2 },
      { "word": "register", "weight": 2 },
      { "word": "update", "weight": 3 },
      { "word": "edit", "weight": 3 },
      { "word": "modify", "weight": 2 },
      { "word": "change", "weight": 2 },
      { "word": "upsert", "weight": 3 },
      { "word": "save", "weight": 2 }
    ]
  },
  "template-folder": "AddOrUpdateEntity"
}
```

Rules in the template specific markdown file:
> Reuse existing backing methods if present (e.g., save, updateEntity, loadEntityById). Do not invent new ones if appropriate methods already exist.  
> If an Id or key is present in the model or route, treat the page as Update; otherwise treat as Add.  
> Always use official enum values for component parameters (no raw strings).  

---

✅ With this setup, you can tailor AI prompt behavior, enforce conventions, and event using a different Angular component library


