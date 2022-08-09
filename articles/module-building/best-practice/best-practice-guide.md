# Best Practice Guide

## Philosophical principles of pattern-reuse

When applying pattern-reuse to software development, there are a set of philosophical principles that, if followed, yield a highly effective implementation.

These philosophical principles are listed below:

### 1. Developers on in control
Changes to the codebase by the automation system should never be done without the direct consent of the developer. In addition, the developer should have a clear view on what the changes in question are.

### 2. Automate best coding standards.
The code which is automated should be clear, concise and follow best practice. It should be as if it was written by your best developer, on his best day.

### 3. Don't convolute the codebase.
Just because an automation system can make it easy to solve problems in verbose ways, this should be avoided. Code structures and implementations should ideally follow the same approach that the team would have taken if they weren't using a code-automation platform but had the time to do the ideal implementation.

### 4. The automation system should never get in the way 
The code-automation system should never get in the way, impede or prevent the developers from making a particular change or delivering on time. Where managed code needs to changed, the developer must have an easy way to tell the automation system to stop managing that code.