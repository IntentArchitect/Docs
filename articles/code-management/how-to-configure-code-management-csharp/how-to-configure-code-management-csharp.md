---
uid: code-management.how-to-configure-code-management-csharp
---
# How to configure Code Management for C# #

This article will explain various use cases for [Code Management](xref:code-management.about-code-management) done in a C# context using the `Intent.OutputManager.RoslynWeaver` Module.

> [!NOTE]
> It is worth noting that for C#, Intent Architect is leveraging the Roslyn engine which has the added benefit of auto-formatting your code. It is configurable inside the `RoslynWeaver Settings` from the Settings tab in your Intent Architect application.

## Make the whole file managed by Intent Architect ##

Assume for this example that we have a file like this:

```cs
using System;
using System.Collections.Generic;
using Intent.RoslynWeaver.Attributes;

[assembly: DefaultIntentManaged(Mode.Fully)]

namespace TestApp.Domain
{
    public class Address : EntityBase
    {

        public string Line1 { get; set; }

        public string Line2 { get; set; }

        public string City { get; set; }

        public string State { get; set; }

        public string Country { get; set; }

        public void ChangeCountry(string country)
        {
            throw new NotImplementedException();
        }
    }
}
```

Notice this line:

```cs
[assembly: DefaultIntentManaged(Mode.Fully)]
```

Reserved for a file scope is the `DefaultIntentManaged` attribute. It sets the default fallback state to instruct Intent Architect as to what level of control it is allowed to have over this file.

The first parameter accepts a `Mode` which instructs Intent Architect that:

* `Fully` - It has **full** control over the file for Code Automation (like typical Code Automation).
* `Merge` - It may only make modifications and additions to this file but it's not allowed to remove anything.
* `Ignore` - It has **no** control over the file and will not generate or overwrite anything in this file.

## Make a class managed by Intent Architect ##

Assume for this example that we have a file like this:

```cs
using System;
using System.Collections.Generic;
using Intent.RoslynWeaver.Attributes;

[assembly: DefaultIntentManaged(Mode.Fully)]

namespace TestApp.Domain
{
    public class Address : EntityBase
    {

        public string Line1 { get; set; }

        public string Line2 { get; set; }

        public string City { get; set; }

        public string State { get; set; }

        public string Country { get; set; }

        public void ChangeCountry(string country)
        {
            throw new NotImplementedException();
        }
    }
}
```

Note that currently the whole file is managed by Intent Architect. Intent Architect allows you to exercise more fine control over this file by allowing you to specify the attribute `[IntentManaged()]` over a class:

```cs
[IntentManaged(Mode.Merge)]
public class Address : EntityBase
{

    public string Line1 { get; set; }

    public string Line2 { get; set; }

    public string City { get; set; }

    public string State { get; set; }

    public string Country { get; set; }

    public void ChangeCountry(string country)
    {
        throw new NotImplementedException();
    }
}
```

Similarly to the [previous](#make-the-whole-file-managed-by-intent-architect) section, the `Mode` has the following that instructs Intent Architect that:

* `Fully` - It has **full** control over the class for Code Automation. If the `[DefaultIntentManaged]` is _also_ set to `Fully` then this attribute is not needed (unless you're planning on adjusting the `Body` or `Signature` properties).
* `Merge` - It may only make modifications and additions to this class but it's not allowed to remove anything. This will still overwrite existing properties and methods in the class; however if you create a new method (or any other member) manually in the class, Intent Architect will not modify it.
* `Ignore` - It has **no** control over the class and will not generate or overwrite anything in this file.

This attribute also provides you with the ability to adjust the Code Management withing the `Body` of this class. Setting this configuration option should look like this:

```cs
[IntentManaged(Mode.Merge, Body = Mode.Ignore)]
```

Setting the class `Body` (in this context: methods, fields, properties, etc.) also instructs Intent Architect that:

> [!NOTE]
> Not setting Body will default to the value of the first parameter in this attribute.

* `Fully` - It has the whole class Body **is** under Code Management.
* `Merge` - The whole class Body may only undergo modifications and additions but nothing is allowed to be removed.
* `Ignore` - The whole class Body is **not** under Code Management and will not generate or overwrite anything in this class.

```cs
[IntentManaged(Mode.Merge, Body = Mode.Ignore, Signature = Mode.Fully)]
```

The attribute also allows you to set the `Signature` of the class. This will be all the declarations and definitions of the class itself and not its contents, i.e. inheritance. It will instruct Intent Architect that:

> [!NOTE]
> Not setting Signature will default to the value of the first parameter in this attribute.

* `Fully` - It **has** the whole class signature under Code Management.
* `Merge` - The whole class Signature may only undergo modifications and additions but nothing is allowed to be removed. For inheritance it will not modify what is already there but it will only add (if generation would add inheritance) if no inheritance was specified. For example, if you had:

    ```cs
    public class MyClass
    {
        //...
    }
    ```

    And the Code Automation wanted to add inheritance to the `BaseClass` class, then it will add it:

    ```cs
    public class MyClass : BaseClass
    {
        //...
    }
    ```

    But if you had:

    ```cs
    public class MyClass : OtherClass
    {
        //...
    }
    ```

    Then the Code Automation will not affect this class.

* `Ignore` - The whole class signature is **not** under Code Management and will not generate or overwrite anything in this class.

## Make methods managed by Intent Architect ##

```cs
[IntentManaged(Mode.Merge)]
public void ChangeCountry(string country)
{
    throw new NotImplementedException();
}
```

Similarly to the [previous](#make-a-class-managed-by-intent-architect) section, applying the `[IntentManaged()]` attribute over a method will instruct Intent Architect that:

* `Fully` - It has full control over the method for Code Automation. Again if the `[DefaultIntentManaged]` or the `[IntentManaged()]` on the class has their `Mode` set to `Fully`, then this specification is redundant (unless you're planning on adjusting the `Body` or `Signature` properties).
* `Merge` and `Ignore` will behave the same way where the method is largely not under Code Automation.

