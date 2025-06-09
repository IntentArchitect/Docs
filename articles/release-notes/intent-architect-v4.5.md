---
uid: release-notes.intent-architect-v4.5
---
# Release notes: Intent Architect version 4.5

## Version 4.5.0

Intent Architect v4.5.0 is the latest release focused on making integrated AI capabilities accessible to developers and on improving usability and disoverability of the platform's capabilities.

The 4.5 beta is available as a side-by-side install, so you can keep your current version of Intent Architect running alongside the beta. The beta can be acquired from our [downloads page](https://intentarchitect.com/#/downloads) in the `Pre-Release(s)` section.

### Highlights in 4.5.0

#### Revamped Getting Started

_(documentation coming soon)_

#### Hosted Module Tasks (AI Tasks)

_(documentation coming soon)_

#### Samples and Sample Creation

_(documentation coming soon)_

### Performance Enhancements for Module Manager

Performance when searching, inspecting and downloading modules in the Module Manager has been greatly improved. Most actions are now near instantaneous, this is particularly noticeable on the "Upgrades" tab.

Furthermore, module downloads are now served directly from our CDN's infrastructure and automatically cached in a [data center of theirs which is geographically nearest to you](https://www.cloudflare.com/network/). This improvement will have a particularly noticeable affect when installing or restoring modules on both developer machines and continuous integration servers.

> [!NOTE]
>
> These changes necessitated updates on the <https://intentarchitect.com/> and client organization deployed [Module Servers](xref:tools.module-server). Until client organization deployed Module Servers are updated to the latest available version, in Intent Architect 4.5 and newer only module restoration will work from them. Other operations such as searching for modules or application templates will show an error in Intent Architect stating that they need to be updated. Updated Module Servers will remain compatible with previous versions of Intent Architect.

### Custom User Settings

_(documentation coming soon)_

### Improvements in 4.5.0

- Enhanced "Search Everywhere" search to include Stereotype Definitions and produce better search results.
- New Application and Module screens now will remember your selected repository and whether Include Prerelease and Include Incompatible have been checked.

_(documentation coming soon)_

### Issues fixed in 4.5.0

_(documentation coming soon)_