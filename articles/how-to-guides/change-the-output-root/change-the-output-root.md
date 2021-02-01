---
uid: how-to-guides.change-the-output-root
---
# Change the output root

Applications in Intent Architect have a _Root Output Location_ which is stored as a relative path to the location of the Application's `.application.config` file. To change this location, open the Application's `Settings` tab.

![application-settings](images/application-settings.png)

In the image above we can see that the path of the `TestApp.application.config` file is in the `C:\Dev\TestApp\TestApp` directory. The `Relative Output Location` is `src`. Therefore the _Root Output Location_ of this Application is `C:\Dev\TestApp\TestApp\src`.

>[!TIP]
>You can move up a directory in the `Relative Output Location` by using `../`. For example if you wanted to output our code into the `C:\Dev\TestApp\src` folder, we could set the `Relative Output Location` to `../src`.

>[!NOTE]
>Intent Architect is fully supported on Mac OS and will automatically convert backslashes to forward slashes. However, we still recommend setting the `Relative Output Location` using forward slashes to avoid confusion.
