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

## Troubleshooting

### Github Desktop

If even after performing the above steps, you still get a `Filename too long` error when cloning a repository using the **Github Desktop Client**, perform the following steps:

- Browse to the location of your GitHub Desktop installation (default location is `%USERPROFILE%\AppData\Local\GitHubDesktop`)
- Browse to the subfolder: `app-x.x.x >> resources >> app >> git >> etc`, so the full path would be `%USERPROFILE%\AppData\Local\GitHubDesktop\app-x.x.x\resources\app\git\etc`
- Edit the `gitconfig` file (in your text editor of choice)
- Add `longpath=true` under the `core` section

```
[core]
  symlinks = false
  autocrlf = true
  fscache = true
  longpaths = true
```

- Restart the Github Client and try the clone again.
