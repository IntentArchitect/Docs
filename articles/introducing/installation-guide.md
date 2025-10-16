---
uid: introducing.installation-guide
---

# Installation Guide

## Windows

Simply run the digitally signed `.exe` file which is a one-click installer that will install Intent Architect and then run it immediately afterward.

> [!TIP]
> To avoid issues with long paths we strongly recommend [enabling long path support](xref:application-development.getting-started.long-path-support-windows-only).
>
> [!TIP]
> To ensure Intent Architect can run the Software Factory as quickly as possible, we highly recommend reviewing [](xref:application-development.software-factory.environmental-factors-which-can-slow-down-software-factory-execution).

## MacOS

Simply open the `.dmg` file and drag Intent Architect into the Applications folder.

## Linux

For Linux, we recommend downloading the [AppImage](https://appimage.org/) package format option which is able to run on any common Linux-based operating system (Ubuntu, Debian, openSUSE, RHEL, CentOS, Fedora, etc.).

Although not essential, the easiest way to use AppImages is to first install [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher) which makes using AppImages seamless and also enables integration with your desktop environment, for example, it will "install" AppImages such that they appear in your desktop environment's list of Applications.

If you just want to run Intent Architect without "installing" it, you can just set the downloaded file to be executable by running `chmod a+x intent-architect*.AppImage` after which you can then run it.

### I'm getting an "The configured user limit (128) on the number of inotify instances has been reached" error

On some Linux distributions, the Software Factory may show the following error:

```text
System.IO.IOException: The configured user limit (128) on the number of inotify instances has been reached, or the per-process limit on the number of open file descriptors has been reached.
   at System.IO.FileSystemWatcher.StartRaisingEvents()
```

You can get your current inotify file watch limit by executing:

```bash
$ cat /proc/sys/fs/inotify/max_user_watches
```

You can set a temporary new limit with:

```bash
$ sudo sysctl -w fs.inotify.max_user_watches=16384
```

To make your limit permanent use:

```bash
$ echo fs.inotify.max_user_watches=16384 | sudo tee -a /etc/sysctl.conf
$ sudo sysctl -p
```

[(Source)](https://github.com/dotnet/aspnetcore/issues/7531#issuecomment-484364033)
