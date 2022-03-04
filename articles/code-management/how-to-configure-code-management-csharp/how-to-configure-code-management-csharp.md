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

The first parameter of the `[IntentManaged()]` attribute will instruct Intent Architect that:

* `Fully` - It has **full** control over the file for Code Automation (like typical Code Automation).
* `Merge` - It may only make modifications and additions to this file but it's not allowed to remove anything.
* `Ignore` - It has **no** control over the file and will not generate or overwrite anything in it.

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

The first parameter of the `[IntentManaged()]` attribute will instruct Intent Architect that:

* `Fully` - It has **full** control over the class for Code Automation.
* `Merge` - It may only make modifications and additions to this class but it's not allowed to remove anything. This will still overwrite existing properties and methods in the class; however if you create a new method (or any other member) manually in the class, Intent Architect will not modify it.
* `Ignore` - It has **no** control over the class and will not generate or overwrite anything in it.

The `[IntentManaged()]` attribute allows the specification of the `Body` of the class too. It can be done like this:

```cs
[IntentManaged(Mode.Merge, Body = Mode.Ignore)]
```

Setting the class `Body` (in this context: methods, fields, properties, etc.) also instructs Intent Architect that:

> [!NOTE]
> Not setting Body will default to the value of the first parameter in that attribute.

* `Fully` - It has **full** control over the class Body for Code Automation.
* `Merge` - It may only make modifications and additions to this class Body but it's not allowed to remove anything.
* `Ignore` - It has **no** control over the class Body and will not generate or overwrite anything in it.

The `[IntentManaged()]` attribute allows the specification of the `Signature` of the class too. It can be done like this:

```cs
[IntentManaged(Mode.Merge, Body = Mode.Ignore, Signature = Mode.Fully)]
```

Setting the class `Signature` (in this context: inheritance, declarations and definitions of the class) also instructs Intent Architect that:

> [!NOTE]
> Not setting Signature will default to the value of the first parameter in that attribute.

* `Fully` - It has **full** control over the class Signature for Code Automation.
* `Merge` - It may only make modifications and additions to this class Signature but it's not allowed to remove anything. In the case of inheritance declared in this class, it will only add a class to be inherited from but it won't modify or remove it. For example, assume the following class:

    ```cs
    public class MyClass
    {
        //...
    }
    ```

    And that Code Automation wanted to add inheritance to the `BaseClass` class, then it will add it:

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

    Then the Code Automation will not change (or remove) `OtherClass` to `BaseClass`.

* `Ignore` - It has **no** control over the class Signature and will not generate or overwrite anything in it.

## Make methods managed by Intent Architect ##

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

Assume we would like to override Intent Architect's ability to manage the method `ChangeCountry`. This can be achieve by adding the `[IntentManaged()]` attribute on top of the `ChangeCountry` method:

```cs
[IntentManaged(Mode.Ignore)]
public void ChangeCountry(string country)
{
    throw new NotImplementedException();
}
```

The first parameter of the `[IntentManaged()]` attribute will instruct Intent Architect that:

* `Fully` - It has **full** control over the method for Code Automation.
* `Merge` - On this level, there is practically no difference between `Merge` and `Ignore`.
* `Ignore` - It has **no** control over the method and will not generate or overwrite anything in it.

The `[IntentManaged()]` attribute allows the specification of the `Body` of the method too. It can be done like this:

```cs
[IntentManaged(Mode.Merge, Body = Mode.Ignore)]
```

Setting the method `Body` (in this context: the actual code written in the method) also instructs Intent Architect that:

> [!NOTE]
> Not setting Body will default to the value of the first parameter in that attribute.

* `Fully` - It has **full** control over the method Body for Code Automation.
* `Merge` - On this level, there is practically no difference between `Merge` and `Ignore`.
* `Ignore` - It has **no** control over the method Body and will not generate or overwrite anything in it.

The `[IntentManaged()]` attribute allows the specification of the `Signature` of the method too. It can be done like this:

```cs
[IntentManaged(Mode.Merge, Body = Mode.Ignore, Signature = Mode.Fully)]
```

Setting the class `Signature` (in this context: method name, parameters and attributes) also instructs Intent Architect that:

> [!NOTE]
> Not setting Signature will default to the value of the first parameter in that attribute.

* `Fully` - It has **full** control over the method Signature for Code Automation.
* `Merge` - On this level, there is practically no difference between `Merge` and `Ignore`, except with _Parameters_ where it may only make modifications and additions to the parameter list but it's not allowed to remove anything. Assume for the following cases this piece of code:

    ```cs
    [IntentManaged(Mode.Ignore, Signature = Mode.Merge)]
    public void ChangeCountry(string country)
    {
        throw new NotImplementedException();
    }
    ```

    If you were to remove `string country` from the parameter list, it will get added again. In the event that you change `country` to another name, it will respect the name change. However, if you changed the `string` type to something like `int` then it will change it back to `string`. If you added another parameter to the list, it will not change or remove that parameter.

* `Ignore` - It has **no** control over the method Signature and will not generate or overwrite anything in it.

