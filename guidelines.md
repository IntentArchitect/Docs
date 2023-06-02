# Contribution Guidelines

## Getting Started and tutorials

Tutorials are step-by-step instructions on how to get users up and running with no decision making in order to learn the tool they're using.

## Running Intent Architect
Run it from the command line using the following argument
--docs-mode

This correctly sizes the application, removes the OS specific title base and squares the corners for easier screen captures.

## Navigation Panel TOC

Everything should be alphabetically ordered (in ascending order). There is the exception where we would like to have the Getting started section be at the top of the list so that people can see that tht tutorials are there and to access it easily (especially for newcomers). The Release Notes are at the bottom of the list to distinguish itself from the other topic sections.

Topics will be the high-level TOC nodes and nested within each topic there will be different articles that addresses different aspects of that topic in the form of what the different related concepts are about, how to do certain things with this topic and also any related frequently asked questions.

### Example

High-level toc.yml:

```yaml
- name: Modules
  href: modules/toc.yml
```

Inside the `modules` folder's toc.yml:

```yaml
items:
- name: About Modules
  href: about-modules/about-modules.md

- name: How to debug your Module code
  href: how-to-debug-your-module-code/how-to-debug-your-module-code.md
```

## Screenshots and videos

In the developer console (Profile button > Debug), run the following first which makes the window frame-less:

```js
require("electron").ipcRenderer.send("relaunch-as-frameless");
```

After, you can run the following commands, also from the developer console:

```js
require("electron").ipcRenderer.send("set-size", { width: 1280, height: 720 }); // Sets the window to the recommended recording size of 720p
angular.element(document.querySelector("html")).injector().get("EventAggregator").publish("set-presentation-mode", true); // Hides "Update Available", hides "IPC Connected" and changes the user display name to "User".
```

## Image markup colours

For image markup colours use "Azure Blue" (`#06C4FF`) from our [brand guidelines](https://intentarchitect.sharepoint.com/sites/IntentArchitectTeam/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FIntentArchitectTeam%2FShared%20Documents%2FMarketing%2FCollateral%2FIA%2DMini%20Brand%20Guidelinesl%5FFA%2Epdf&parent=%2Fsites%2FIntentArchitectTeam%2FShared%20Documents%2FMarketing%2FCollateral).

## Formatting markdown tables

Select the text in the editor representing the Markdown table. Press `CTRL+SHIFT+P` and select `Evenly distribute selected table`. This will format markdown tables in a human readable manner.

## Headings

Headings should be short and concise and should refrain from being written in a question form. Rather write it in a declarative form. For instance: `Why isn't Intent Architect not using Package Managers?` should be written as `Why Intent Architect isn't using Package Managers`.

## How-to articles

Don't make how-to depend on previous articles to get started. It should be self-contained with regards to step-by-step instructions. Don't make them complete a tutorial first just to get to the point of starting with the how-to. Of course a how-to may make assumptions that the reader should need to know how certain concepts and actions before the how-to can be started (just as you would have to know arithmetic before you can start algebra) and it may have references to other how-to's or reference articles to help explain or to point to "next" kind of articles.

## Changing/moving article paths

So that old links carry on working, keep just the `.md` files for moved/renamed articles and make their content as follows to have them redirect to the new location:

```markdown
# Content moved

Content has moved to <span id="redirect_container">[here](xref:document_xref)</span>.

<script>
  window.location.href = document.querySelector("#redirect_container a").href;
</script>
```

Replace `document_xref` with the `xref` of the document you will point to, and then DocFX's build process will resolve the URL path which the JavaScript will use to redirect automatically to the correct place.
