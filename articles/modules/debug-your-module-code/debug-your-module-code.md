---
uid: how-to-guides.debug-your-module-code
---
# How to debug your Module code

When developing Modules, it's very useful to be able to debug code inside the Module. Intent Architect supports this by pausing the Software Factory Execution process in order to allow you to connect a debugger to the running process.

For example, to debug using Visual Studio:

1. Run the Software Factory Execution in _DEBUG_ mode by clicking on the _Debug_ icon to the left of the usual _Play_ button (you'll notice it being a _bug_ icon). The Software Factory Execution will launch and pause with a `Attach Debugger` dialog awaiting for confirmation to proceed.

    ![Attach Debugger](images/attach-debugger.png)

2. Use the process ID to attach the debugger in your IDE.

    ![Attach Debugger in VS](images/visual-studio-attach-debugger.png)

3. Click the `OK` button on the `Attach Debugger` dialog.

The breakpoints in your module will now be hit:

<p><video style="max-width: 100%" muted="true" loop="true" autoplay="true" src="videos/debugging-a-module.mp4"></video></p>
