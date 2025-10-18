---
uid: tutorials.fundamentals-2-intro-to-domain-modeling
---
# Fundamentals #2: Introduction to Domain Modeling

Learn to model domain entity data and define relationships in your domain.{: .lead }

<div class="video-16x9"><iframe name="lessonVideo" src="https://intentarchitect.com/#/redirect/?category=docs-embedded&subCategory=fundamentals-two" title="Video" allowfullscreen></iframe></div>

## Summary

This video builds on the previous lesson and focuses on modeling **entity attributes** and **relationships** — including one-to-many, one-to-one, and many-to-many. It also demonstrates defining **enums** for use as attribute types.

## Chapters

- [Introduction to Domain Modeling (0:00)](https://www.youtube.com/embed/Q4HDH95VAY4?rel=0&start=0&autoplay=1){target="lessonVideo"}
- [One-to-Many Relationship Explained (1:57)](https://www.youtube.com/embed/Q4HDH95VAY4?rel=0&start=117&autoplay=1){target="lessonVideo"}
- [Customer-Order Relationship (6:30)](https://www.youtube.com/embed/Q4HDH95VAY4?rel=0&start=390&autoplay=1){target="lessonVideo"}
- [Adding Address Entity (8:39)](https://www.youtube.com/embed/Q4HDH95VAY4?rel=0&start=519&autoplay=1){target="lessonVideo"}
- [Delivery and Billing Addresses (10:30)](https://www.youtube.com/embed/Q4HDH95VAY4?rel=0&start=630&autoplay=1){target="lessonVideo"}
- [Product Category Relationship (13:16)](https://www.youtube.com/embed/Q4HDH95VAY4?rel=0&start=796&autoplay=1){target="lessonVideo"}

## Useful Tips

- Navigation:
  - **Pan on Diagrams**: Hold **middle mouse button** *or* **Ctrl + left-drag**.
  - **Navigate to element**: **Ctrl + left-click** a reference to jump to its definition (e.g., clicking an enum attribute or a query response DTO jumps to that enum/DTO in the tree view).
  - **Rename an element**: Use **Right-click → Rename**, press **F2**, or edit **Name** in the **Properties** window.

- Shortcuts:
  - **Duplicate current element**: C**trl + Enter** duplicates the selected element.
  - **Add child element**: **Ctrl + Shift + A** adds a child where applicable (e.g., Attributes → Entities, Members → Enums, Parameters → Commands).
  - **Mark element as nullable**: **Alt + N** toggles nullable (where supported).

- Domain Design:
  - **Compositional relationship (black diamond)**: A child entity is owned by the parent entity; deleted the parent **also deletes** the child.
  - **Aggregation relationship (white diamond)**: A child entity isn’t owned by the parent; deleting the parent **does not** usually delete the child.

- Recommendations:
  - **Enum member values**: Avoid assigning a meaningful value to 0. Reserve 0 for Unknown/Unspecified and start real values at 1 to prevent unset/default enums from being mistaken for valid values during serialization or mapping.

## Related Resources

- [Modeling the Domain](xref:application-development.modelling.domain-designer.modeling-the-domain)

---

| [← #1 Building Your First Application with Intent Architect](xref:tutorials.fundamentals-1-building-an-application) | [#3 Creating CRUD Services →](xref:tutorials.fundamentals-3-create-crud-service) |
|:--|--:|
