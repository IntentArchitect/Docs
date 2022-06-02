---
uid: references.notations
---
# Notations

This section will cover the various notations that we are using in Intent Architect for specifying certain values.

## Version Ranges

You might have come across a version specification looking like this: `[3.0.0,4.0.0)`.

It is very similar to the [mathematical interval notation](https://en.wikipedia.org/wiki/Interval_(mathematics)#Notations_for_intervals) where the `[`, `]` (square bracket) characters indicate inclusivity, while the `(`, `)` (parenthesis) indicate exclusivity.

So starting with a `[` character means that the number that follows will be included in the range check and a number that exists right before the last `)` will indicate the end of the range without the number itself.

This is how Intent Architect denotes how to interpret version numbers when determining whether a given component is compatible with another component. For instance, a Module might be built for a given version of Intent Architect which is guaranteed to be compatible. A future version may have a different API exposed which might not be compatible with this Module and therefore the Module might instruct Intent Architect that if the version of Intent Architect is greater than or equal to 3.0.0 **AND** less than 4.0.0, **then** it will be deemed compatible.
