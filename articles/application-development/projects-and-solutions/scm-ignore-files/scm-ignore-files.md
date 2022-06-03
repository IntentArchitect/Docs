---
uid: references.scm-ignore-files
---
# SCM ignore files

This article is a reference for how SCM (source-control management) "ignore rules" should be configured for Intent Architect folders and files.

## Folders which should always be ignored

`.intent` folders should always be ignored, they contain data like downloaded/restored modules and other cached data.

## Files which should not be ignored

`*.application.output.log` files should never be ignored. Intent Architect uses this log to track files under management so that it can determine when files might need to be deleted or renamed.

## Configuring Git (`.gitignore` files)

As of version [3.1.8](xref:release-notes.version-3-1#new-features-added-in-318), Intent Architect has an option during creation of a new Solution or Application to add or update the appropriate `.gitignore` files.

If your application or solution was created in a version of Intent Architect less than 3.1.8, you can manually add the following to your `.gitignore` file:

```text
# Intent Architect

**/.intent/*
!*.application.output.log
```
