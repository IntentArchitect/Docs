# Intent Architect Docs

This repository contains the Intent Architect documentation hosted at [https://docs.intentarchitect.com/docs](https://docs.intentarchitect.com/). See the Contributing Guide below and the [issues list](https://github.com/IntentArchitect/Docs/issues) if you would like to help out.

## Contributing to the Intent Architect documentation

### How to make a simple correction or suggestion

Articles in the repository are stored as Markdown files. Simple changes to the content of a Markdown file are made in the browser by selecting the _Edit_ link in the upper-right corner of the browser window. (In a narrow browser window, expand the options bar to see the _Edit_ link.) Follow the directions to create a pull request (PR). We will review the pull request and accept it or suggest changes.

### How to make a more complex submission

To make more complex submissions, contact the Intent team at [support@intentarchitect.com](mailto:support@intentarchitect.com) outlining what you want to do. We will respond with steps on how you can make your submission.

### Contribution guidelines

This [article](guidelines.md) outlines the way that content needs to be supplied before any Pull Requests are accepted.

### View your changes with DocFX

This folder contains the source [markdown](https://dotnet.github.io/docfx/spec/docfx_flavored_markdown.html) for Intent Architect's documentation. [DocFX](https://dotnet.github.io/docfx/) is then run against the `docfx.json` file and along with the `.md` files, our documentation is generated into the `_site` folder (which is `.gitignore`'d). The contents of the `_site` folder are then uploaded to the website at [http://intentarchitect.com/docs/](http://intentarchitect.com/docs/) by the Intent Architect team.

### VS Code Extensions

Visual Studio Code has some good extensions to aid in writing documentation:

- [Docs Authoring Pack for VS Code](https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-authoring-pack)

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

If there is a strange build error, try completely deleting the `obj` folder. This folder only contains build artifacts, the worst that can happen from its deletion is that the next build may take a little longer.
