---
uid: module-building.apis.backwards compatibility
---
# Backwards compatibility for module building APIs

Ensuring backwards compatibility in our module building related APIs is a fundamental principle that guides our development process. We take a meticulous approach to prevent breaking changes, minimizing disruption for our users and ensuring a stable ecosystem. This article outlines our approach to handling breaking changes, our internal processes to mitigate risks, and the policies we have in place to communicate these changes effectively.

## Types of breaking changes

We categorize breaking changes into two primary areas:

### Changes in Intent Architect

If breaking changes occur in Intent Architect, they are only introduced during major version upgrades. Our approach includes:

- **Highlighting breaking changes in release notes** - Each major release includes detailed notes explaining the changes and their impact.
- **Providing migration guidance** - Our documentation outlines clear steps for upgrading and adapting to the changes.
- **Using the [Obsolete attribute](https://learn.microsoft.com/dotnet/api/system.obsoleteattribute) and XML documentation** - Previous versions of the SDK include these markers to help developers transition smoothly.
- **Creating transition SDK versions** - If necessary, we release a minor or patch SDK version on the previous major version that maintains compatibility while offering migration documentation.
- **Hands-on assistance** - Our support team makes itself available to assist with module updates required for transitioning from obsolete and/or removed APIs.
- **Allowing side-by-side installation of major versions** - Each major version of Intent Architect is installed as an independent application meaning that major versions can be run side-by-side with each other on the same computer. This prevents users from accidentally upgrading to an incompatible version and for custom module upgrades to happen within your own timelines.
- **Version compatibility enforcement** - Modules and application templates define their compatible Intent Architect versions, ensuring they are hidden by default from incompatible versions.

### Changes in Modules

Modules may depend on each other, so breaking changes are managed with caution. Our approach includes:

- **Major version increments** - Any breaking change in a module triggers a major version bump.
- **Release notes and migration documentation** - We highlight necessary upgrade steps and provide thorough documentation in module release notes.
- **Hands-on assistance** - Our support team makes itself available to assist with module updates required for transitioning from obsolete and/or removed APIs.
- **Interoperability dependency management** - Modules can use an "interoperability" module dependency type which can be used to detect and upgrade other installed modules which have become incompatible with a module change. As automatic of upgrading of other modules may not always be appropriate, this option should be carefully considered before being employed.

## Frequency of creaking changes

### Intent Architect

- Breaking changes only occur in major version updates.
- The last breaking changes occurred in versions 2 and 3, with version 4 remaining fully backwards compatible.
- While the Intent Architect tool itself does not strictly follow semantic versioning, our general approach is:
  - **Patch updates** focus on bug fixes and minor improvements.
  - **Minor version updates** introduction of note-worthy features.
  - **Major version updates** occur when breaking changes are necessary or significant new features are introduced.

### Modules

- Breaking changes result in major version updates.
- It has been rare that module major version bumps have occurred for compatibility reasons in the past and they have been mostly due to major versions bumps of Intent Architect itself.

## Risk mitigation and change control measures

To ensure a stable ecosystem, we implement rigorous internal processes:

- **Breaking changes in non-major versions are prohibited**.
- **Major version updates require internal discussion and justification** - We carefully evaluate whether a breaking change is truly necessary and that associated improvements justify the potential inconvenience to module authors.
- **Comprehensive testing in CI environments**:
  - We create test cases for new and updated modules.
  - Our CI server runs integration tests using the [Software Factory CLI](xref:tools.software-factory-cli).
  - For existing modules our CI server downloads the original immutable module artifacts to detect binary compatibility issues between the .NET assemblies inside of them.
- **Major Intent Architect updates require module version alignment**:
  - If Intent Architect undergoes a major version update, all dependent modules receive version bumps with updated compatibility ranges.

## Conclusion

Our API’s backwards compatibility strategy is built on a foundation of strict change management, thorough testing, and transparent communication. By proactively avoiding breaking changes and carefully managing necessary updates, we provide a reliable platform that allows users to build with confidence while minimizing upgrade risks. Our commitment to compatibility ensures that developers can depend on a stable, well-documented, and actively supported ecosystem.
