# Contribution Guidelines

## Getting Started and tutorials

Tutorials are step-by-step instructions on how to get users up and running with no decision making in order to learn the tool they're using.

## Screenshots and videos

In the developer console, run the following first which makes the window frame-less:

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
