---
uid: application-development.getting-started.long-path-support-windows-only
comment: This is not in TOC.
---
# Enable Long Path Support (Windows only)

Depending on the number of parent folders for the root path of your Intent Application, it can be quite easy to hit Windows' [maximum file path length limitation](https://docs.microsoft.com/windows/win32/fileio/maximum-file-path-limitation#enable-long-paths-in-windows-10-version-1607-and-later), this can cause various problems to manifest, such as:

- Errors when extracting/compressing files into / out from .zip files.
- Errors checking files in or out of source control management (such as Git).

As of Windows 10 1607 it is possible to disable this limitation for all applications.

## Configuring Windows to support long paths

# [PowerShell](#tab/powershell)

```powershell
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force
```

# [Registry (.reg) file](#tab/regedit)

```text
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001
```

---

## Configuring Git to support long paths

```bash
git config --system core.longpaths true
```
