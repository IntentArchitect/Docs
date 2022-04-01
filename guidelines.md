# Contribution Guidelines

## Getting Started and tutorials

Tutorials are step-by-step instructions on how to get users up and running with no decision making in order to learn the tool they're using.

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

## Formatting markdown tables

Select the text in the editor representing the Markdown table. Press `CTRL+SHIFT+P` and select `Evenly distribute selected table`. This will format markdown tables in a human readable manner.

## Headings

Headings should be short and concise and should refrain from being written in a question form. Rather write it in a declarative form. For instance: `Why isn't Intent Architect not using Package Managers?` should be written as `Why Intent Architect isn't using Package Managers`.
