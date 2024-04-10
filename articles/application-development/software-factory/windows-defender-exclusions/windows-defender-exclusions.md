---
uid: application-development.software-factory.windows-defender-exclusions
---
# Windows Defender Exclusions

## Overview

Intent Architect's Software Factory is fast however, it's not uncommon to experience slow startup times, especially during the initial run. This performance hit is often attributed to the antivirus (A/V) software scanning the assemblies, which can significantly delay the startup process. This article aims to address this issue by guiding you through adding necessary exclusions in order to significantly improve the Software Factory's startup times.

## Adding Exclusions to Windows Defender

* Open Windows Security by clicking on the Start menu and selecting the shield icon to open Windows Security. Alternatively, you can search for "Windows Security" in the search bar.
  ![Search Windows Security](images/search-windows-secutiry.png)
* In the Windows Security window, click on "Virus & threat protection" on the left sidebar.
  ![Virus and threat protection](images/virus-and-threat-protection.png)
* Scroll down to the "Virus & threat protection settings" section and click on "Manage settings."
  ![Manage Settings](images/manage-settings.png)
* In the settings window, scroll down to the "Exclusions" section. Here, you will find options to add exclusions for files, folders, file types, and process exclusions.
  ![Add or Remove exclusions](images/add-or-remove-exclusions.png)
* Add Exclusions:
  * For Folders: Click on "Add or remove exclusions" under the "Folders" section. In the window that opens, click on "Add an exclusion," then browse to the folder you want to exclude (e.g., C:\Program Files or your Dev folder) and select it. Click "Select Folder" and then "OK."
  * For Files: Click on "Add an exclusion" under the "Files" section. Browse to the file you want to exclude (e.g., Intent.SoftwareFactory.Host.exe or dotnet.exe), select it, and click "Open."
  * For Processes: Click on "Add an exclusion" under the "Processes" section. Type the name of the process you want to exclude (e.g., Intent.SoftwareFactory.Host.exe or dotnet.exe) and click "Add."
* After adding the exclusions, you will be prompted to confirm. Click "OK" to save your changes.

By following these steps, you can effectively manage Windows Defender's behavior and ensure that it does not interfere with your system's performance or your development work.

> [!NOTE]
> You may need to consult your IT department in providing access in order to perform these exclusions. You are also opening up areas of vulnerability so caution should be exercised.

## Using the Dev Drive with Windows 11

For further optimization, consider using a dedicated [Dev drive with Windows 11](https://learn.microsoft.com/en-us/windows/dev-drive/). This approach not only helps in protecting against antivirus scans but also enhances the overall performance of your development environment.
