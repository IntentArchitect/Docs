---
uid: release-notes.intent-architect-v4.3
---
# Release notes: Intent Architect version 4.3

## Version 4.3.0

### Highlights in 4.3.0

### Other Improvements in 4.3.0

- Intent Architect has much better handling of unreachable HTTP(S) module server(s) when searching/restoring/installing/updating Modules and Application Templates. Previously, any request would take 60 seconds to timeout which could result in very slow restorations if a single custom HTTP(S) module repository was inaccessible for any reason. Now the timeout is just 3 seconds and if a failure occurs it will be instantly presumed to still be offline for at least 30 seconds making checks against other servers faster.

### Issues fixed in 4.3.0
