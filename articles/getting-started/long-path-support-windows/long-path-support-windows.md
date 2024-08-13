---
uid: application-development.getting-started.long-path-support-windows
comment: This is not in TOC.
---
# Long Path Support (Windows)

Excerpt from Microsoft:

> Starting in Windows 10, version 1607, MAX_PATH limitations have been removed from many common Win32 file and directory functions. However, your app must opt-in to the new behavior.

## Ensure long paths support is enabled (Windows only)

### For Git

Run the following command in Git bash:

```bash
git config --system core.longpaths true
```

### For Windows (copied from [here](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation#enable-long-paths-in-windows-10-version-1607-and-later)):

1. Run `gpedit.msc`.
2. In the pane on the left, drill down to `Computer Configuration` > `Administrative Templates` > `System` > `Filesystem`.
3. Double-click the `Enable win32 long paths` item in the pane on the right.
4. Select `Enabled`.
5. Press `OK`.
