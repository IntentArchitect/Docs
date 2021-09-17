# Intent Architect Docs

This repository contains the Intent Architect documentation hosted at [https://intentarchitect.com/docs](https://intentarchitect.com/docs). See the Contributing Guide below and the [issues list](https://github.com/IntentSoftware/Docs/issues) if you would like to help out.

## Contributing to the Intent Architect documentation

### How to make a simple correction or suggestion

Articles in the repository are stored as Markdown files. Simple changes to the content of a Markdown file are made in the browser by selecting the _Edit_ link in the upper-right corner of the browser window. (In a narrow browser window, expand the options bar to see the _Edit_ link.) Follow the directions to create a pull request (PR). We will review the pull request and accept it or suggest changes.

### How to make a more complex submission

To make more complex submissions, contact the Intent team at support@intentarchitect.com outlining what you want to do. We will respond with steps on how you can make your submission.

### View your changes with DocFX

This folder contains the source [markdown](https://dotnet.github.io/docfx/spec/docfx_flavored_markdown.html) for Intent Architect's documentation. [DocFX](https://dotnet.github.io/docfx/) is then run against the `docfx.json` file and along with the `.md` files, our documentation is generated into the `_site` folder (which is `.gitignore`'d). The contents of the `_site` folder are then uploaded to the website at [http://intentarchitect.com/docs/](http://intentarchitect.com/docs/) by the Intent Architect team.

### Notes on presentation of the client for screenshots and videos

In the developer console, run the following first which makes the window frame-less:

```js
require("electron").ipcRenderer.send("relaunch-as-frameless");
```

After, you can run the following commands, also from the developer console:

```js
require("electron").ipcRenderer.send("set-size", { width: 1280, height: 720 }); // Sets the window to the recommended recording size of 720p
angular.element(document.querySelector("html")).injector().get("EventAggregator").publish("set-presentation-mode", true); // Hides "Update Available", hides "IPC Connected" and changes the user display name to "User".
```

### VS Code Extensions

- [Docs Authoring Pack for VS Code](https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-authoring-pack)
- [Markdown Table Formatter for VS Code](https://marketplace.visualstudio.com/items?itemName=fcrespo82.markdown-table-formatter)

#### Build and make localhost preview site available

From the command line run:

```cmd
_tools/DocFX/docfx.exe docfx.json --serve
```

Or alternatively:

```cmd
./_build_and_serve.ps1
```

#### Build only

From the command line run:

```cmd
_tools/DocFX/docfx.exe docfx.json
```

#### Troubleshooting

If there is a strange build error, try completely deleting the `obj` folder. This folder only contains build artifacts, the worst that can happen from its deletion is that the next build may take longer.

### Publishing (for Intent Software employees)

For information on publishing the docs to our website, refer to the `readme.md` in the Intent Architect private repository.
