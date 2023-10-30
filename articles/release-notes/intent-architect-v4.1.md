---
uid: release-notes.intent-architect-v4.1
---

## Version 4.1.0

Intent Architect V4.1 is promising to be a pivotal release for the platform, with a set of incredibly versatile and powerful new features and capabilities. The Intent Architect team is very  proud to finally make this release available to our community after the many months of effort. We are looking forward to getting your feedback.

### Watch the webinar

> [!NOTE]
> The webinar recording will be posted here soon in case you missed it.

### Backward Compatibility

This release of Intent Architect is fully backward compatible with V4.0.x. It does simultaneously come with functionality that is not available in V4.0.x that, if used, would require other team members working on that application to upgrade to V4.1.x or higher.

The installation of this version will replace V4.0.x. If you need to downgrade back to V4.0.x, simply redownload the installer from our website [downloads page](https://intentarchitect.com/#/downloads) and install.

### Highlights in 4.1.0

#### Advanced Mapping System

The new Advanced Mapping System in Intent Architect is the flagship new feature of V4.1. This feature offers powerful and versatile new capabilities to the platform's designing systems, which serve to further increase the percentage of predictable and repetitive code that developers can now automate.

![Advanced Mapping System Example](images/4.1.0/mapping-system-example.png)
Above: Example mapping between a Command and an Entity constructor.

#### Enhanced Diagram Capabilities

In our continous effort to support explicit "living" blueprints of our community's software systems, several new features have been added to the diagram capabilities in V4.1. In conjunction with the new Advanced Mapping System, these features allow developers to accurately visualize the flow of data through their system in a way that was previously not possible. These new features and improvements are listed below.

![Advanced Mapping System Example](images/4.1.0/new-diagram-capabilities.png)

- New diagram toolbar, which includes:
    - Buttons for creating new roots element types on the diagram.
    - A dropdown to quickly switch between diagrams within the designer.
- Diagrams can now visualize elements from referenced packages.
- Curved Association lines, which help make connecting elements together simpler, more efficient, and neat.
- Anchor points on visual elements which associations "snap to". This improvement is limited to curved association lines at the moment.
- Auto-resizing of element visuals to fit / hide content. This option is available on all root elements in the diagrams.
- Drag & drop functionality includes all child elements when holding down `ctrl`. This can be very useful to quickly visualize associated elements, and all types in folders or packages.

#### Error Management Enhancements
As part of V4.1, the Intent Architect team has rearchtiected the way that errors work within the designers. This brings better robustness, predictability as well as performance improvements. As part of this initiative, `Intent.Exceptions.ElementException` errors produced by modules during the Software Factory Execution are able to provide a link to the metadata element that backs the failing logic. Users can click this link which will navigate them to the element in it's owning designer.

![Advanced Mapping System Example](images/4.1.0/element-exception-example.png)

#### Apple Silicon support

macOS releases are now published as "universal" packages which will run code natively for both Intel and Apple Silicon based Macs.

#### Other quality-of-life enhancements
- Navigating through the 'Go to Definition' context menu options (`F12` shortcut), will open the relevant designer and select they type.
- Internals of reference packages can now be explored from within the designer.
- Diagrams will delay loading while a module restoration is in progress. Afterward, it will automatically load. This enhancement prevents errors caused by loading designers before the required modules have been restored.
- Associations now only require their type-reference to be specified if the name is configured to be Hidden.
- And a whole list of bug fixes :)


