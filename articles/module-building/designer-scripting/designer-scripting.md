---
uid: module-building.designer-scripting
---

# Designer Scripting

In the coding editor, documentation for code constructs is readily available, along with powerful scripting capabilities that allow developers to automate certain front-end related concerns.

![Code Docs in Code Completion Screenshot](images/code-complete-code-docs.png)

You can access the documentation by simply clicking on the small arrow beside each code construct to expand the respective documentation and learn more about the available functions for automation.

## Execute Script Dialog

Intent Architect includes a scripting editor, which can be launched by clicking the on the Execute Script Dialog button (`</>`) located in the toolbar. This editor allows you to execute scripts directly within your designer environment.

```typescript
let mainPackage = getPackages()[0];
for (let classIndex = 1; classIndex <= 10; classIndex++) {
    let newClass = createElement("Class", `Class${classIndex}`, mainPackage.id);
    for (let attrIndex = 1; attrIndex <= 5; attrIndex++) {
        let attr = createElement("Attribute", `Attribute${attrIndex}`, newClass.id);
        const stringTypeId = "d384db9c-a279-45e1-801e-e4e8099625f2";
        attr.typeReference.setType(stringTypeId);
    }
}
```

The example script provided will locate the main package in the current designer and create 10 Classes with 5 Attributes each and setting each Attribute's type to a `string`.

The following TypeScript declarations serve as a reference guide for understanding the scripting capabilities within the Intent Architect environment. By examining these declarations, users can determine the functions available for execution and gain insight into their intended purposes, allowing the automation of various operations directly within their design workspace.

```typescript
/**
 * Returns information about the application and it's settings.
 */
declare const application: IApplication;

/**
 * Creates an element of specialization type with the specified name, as a child of the specified parent.
 */
declare function createElement(specialization: string, name: string, parentId: string): IElementApi;

/**
 * Creates an association of specialization type with from a sourceElementId and optionally to a targetElementId.
 */
declare function createAssociation(specialization: string, sourceElementId: string, targetElementId?: string): IAssociationApi;

/**
 * Returns the packages currently loaded into the designer.
 */
declare function getPackages(): IPackageApi[];

/**
 * Present a popup dialog for user feedback or intervention.
 */
declare const dialogService: IDialogService;

/**
 * Finds the element with the specified id across all loaded packages.
 */
declare function lookup(id: string): IElementApi;

/**
 * Finds the elements of the specified type(s) across all loaded packages.
 */
declare function lookupTypesOf(types: string | string[]): IElementApi[];

/**
 * Removes specified prefixes from the provided string.
 * @param string The string from which the prefixes should be removed.
 * @param prefixes An array of prefix strings to remove.
 */
declare function removePrefix(string: string, ...prefixes: string[]): string;

/**
 * Removes specified suffixes from the provided string.
 * @param string The string from which the suffixes should be removed.
 * @param suffixes An array of suffix strings to remove.
 */
declare function removeSuffix(string: string, ...suffixes: string[]): string;

/**
* Returns the plural form of the specified word.
*/
declare function pluralize(word: string): string;

/**
* Returns the singular form of the specified word.
*/
declare function singularize(word: string): string;

interface IDiagramApi {
    /**
     * The mouse position of the last user activated event.
     */
    mousePosition: IPoint;
    /**
     * Returns true if a visual with the specified element identifier is in the diagram.
     */
    isVisual: (elementId: string | any) => boolean;
    /**
     * Returns the visual API for the visual with the specified element identifier in the diagram.
     */
    getVisual: (elementId: string | any) => IElementVisualApi;

    /**
     * Automatically lays out the specified elements and associations using the Dagre algorithm around the provided position.
     */
    layoutVisuals: (elementIds: string | string[] | any, position: { x: number, y: number }) => void;

    /**
     * Adds an element visual to the diagram.
     *
     * @param elementId The element's id.
     * @param position The position to place the element visual.
     * @param size The size of the element visual.
     */
    addElement: (elementId: string | any, position: { x: number, y: number }, size?: { width: number, height: number }) => void;

    /**
     * Adds an association visual to the diagram.
     *
     * @param associationId The association's id.
     * @param targetPrefPoint (optional) The relative point within the target element's visual to align the association.
     * @param fixedPoints (optional) The absolute fixed points that the association must follow.
     */
    addAssociation: (associationId: string | any, targetPrefPoint?: { x: number, y: number }, fixedPoints?: { x: number, y: number }[]) => void;

    /**
     * Hides the visual with the specified visual identifier.
     */
    hideVisual: (visualId: string | any) => void;
}
```

## Event Triggered Scripts for Elements

Event Triggered Scripts in a module building environment enable developers to execute custom logic when specified events occur for elements.

![Event Triggered Script for Elements Screenshot](images/event-triggered-script-element.png)

Inside the Module Builder designer you can add Element Event Handlers for an Element you've created or to an Element you want to extend from an existing Designer.


```typescript
const stereotypeId = "65860af3-8805-4a63-9fb9-3884b80f4380";
const boolTypeId = "e6f92b09-b2c5-4536-8270-a4d9e5bbd930";

if (element.hasStereotype(stereotypeId)) {
    let isDeleteAttr = element.getChildren("Attribute").filter(x => x.hasMetadata("soft-delete"))[0] ||
        createElement("Attribute", "IsDeleted", element.id);
    isDeleteAttr.typeReference.setType(boolTypeId);
    isDeleteAttr.setMetadata("soft-delete", true);
    return;
}

let isDeleteAttr = element.getChildren("Attribute").filter(x => x.hasMetadata("soft-delete"))[0];
if (isDeleteAttr) {
    isDeleteAttr.delete();
}
```

In the provided TypeScript example, the script will activate when a Class element is modified. It performs the following actions:

- When a Class is modified and has a Soft Delete stereotype applied, it adds an `IsDeleted` attribute of boolean type, marked with soft-delete metadata.
- When the Soft Delete stereotype is removed, it searches for any attribute with soft-delete metadata and deletes it from the Class.

The API provides several global objects and functions to interact with the application model, elements, packages, and user interface:

```typescript
declare let element: IElementApi;

/**
 * Returns information about the application and it's settings.
 */
declare const application: MacroApi.Context.IApplication;

/**
 * Obsolete. Use {@link getCurrentDiagram} instead. This would only return the diagram which was open at the time the script execution began.
 */
declare const currentDiagram: MacroApi.Context.IDiagramApi;

/**
 * Returns the currently opened and displayed diagram.
 */
declare const getCurrentDiagram: () => MacroApi.Context.IDiagramApi;

/**
 * Creates an element of specialization type with the specified name, as a child of the specified parent.
 */
declare function createElement(specialization: string, name: string, parentId: string): IElementApi;

/**
 * Creates an association of specialization type with from a sourceElementId and optionally to a targetElementId.
 */
declare function createAssociation(specialization: string, sourceElementId: string, targetElementId?: string): IAssociationApi;

/**
 * Returns the packages currently loaded into the designer.
 */
declare function getPackages(): IPackageApi[];

/**
 * Present a popup dialog for user feedback or intervention.
 */
declare const dialogService: IDialogService;

/**
 * Finds the element with the specified id across all loaded packages.
 */
declare function lookup(id: string): IElementApi;

/**
 * Finds the elements of the specified type(s) across all loaded packages.
 */
declare function lookupTypesOf(type: string | string[]): IElementApi[];

/**
 * Removes specified suffixes from the provided string.
 * @param string The string from which the suffixes should be removed.
 * @param suffixes An array of suffix strings to remove.
 */
declare function removeSuffix(string: string, ...suffixes: string[]): string;

/**
* Returns the plural form of the specified word.
*/
declare function pluralize(word: string): string;

/**
* Returns the singular form of the specified word.
*/
declare function singularize(word: string): string;

interface IElementApi {
    /**
     * The human-readable specialization type (e.g. "Class", "Attribute", etc.)
     */
    specialization: string;
    /**
     * The unique identifier for the element.
     */
    id: string;
    /**
     * Returns the name of the element.
     */
    getName(): string;
    /**
     * Sets the name of the element.
     */
    setName(value: string): void;
    /**
     * Returns the comment of the element.
     */
    getComment(): string;
    /**
     * Sets the comment of the element.
     */
    setComment(value: string): void;
    /**
     * Returns the value of the element.
     */
    getValue(): string;
    /**
     * Sets the name of the element.
     */
    setValue(value: string): void;
    /**
     * Returns the value of the element.
     */
    getExternalReference(): string;
    /**
     * Sets the external reference of the element.
     */
    setExternalReference(value: string): void;
    /**
     * Returns the comment of the element.
     */
    getGenericTypesDisplay(): string;
    /**
     * Returns true if the element is configured to have a typeReference.
     */
    hasType: boolean;
    /**
     * The typeReference property of the element
     */
    typeReference?: ITypeReference;
    /**
     * Returns all the child elements of this element. If a type argument is provided, the children will
     * be filtered to those that match on specialization. 
     */
    getChildren(type?: string): IElementApi[];
    /**
     * Opens the diagram that this element represents, if it configured to support a diagram.
     */
    loadDiagram(): void;
    /**
     * Returns this element's parent
     */
    getParent(type?: string): IElementApi;
    /**
     * Sets this element's parent.
     */
    setParent(parentId: string): void;
    /**
     * Returns the owning package for this element.
     */
    getPackage(): IPackageApi;
    /**
     * Returns true if this element is mapped.
     */
    isMapped(): boolean;
    /**
     * Clears the mapping model of this element.
     */
    clearMapping(): void;
    /**
     * Returns the mapping model for this element.
     */
    getMapping(): IElementMappingApi;
    /**
     * Sets the mapping for this element.
     * @param elementId The unique identifier of the target element. If the mapping traverses more than one element in a hierarchy,
     * an array of element identifiers must be provided.
     * @param mappingSettingsId The specific mapping settings to use. The first mapping settings available will be used if no
     * value is provided.
     */
    setMapping(elementId: string | string[], mappingSettingsId?: string): void;
    /**
     * Launches the mapping dialog for the element for the provided mappingSettingsId.
     *
     * Must be called with await.
     * @param mappingSettingsId The specific mapping settings to use. The first mapping settings available will be used if no
     * value is provided.
     */
    launchMappingDialog(mappingSettingsId?: string): Promise<void>
    /**
     * Returns true if a stereotype that matches the specified name or definition identifier is applied to the element.
     */
    hasStereotype(nameOrDefinitionId: string): boolean;
    /**
     * Returns all stereotypes currently applied to the element.
     */
    getStereotypes(): IStereotypeApi[];
    /**
     * Returns the stereotype that matches the specified name or definition identifier
     */
    getStereotype(nameOrDefinitionId: string): IStereotypeApi;
    /**
     * Applies the stereotype with definition id of stereotypeDefinitionId to this element.
     */
    addStereotype(stereotypeDefinitionId: string): IStereotypeApi;
    /**
     * Removes the stereotype that matches the specified name or definition identifier from this element.
     */
    removeStereotype(nameOrDefinitionId: string): void;
    /**
     * Expands this element in the designer model.
     */
    expand(): void;
    /**
     * Collapses this element in the designer model.
     */
    collapse(): void;

    /**
     * Activates the editing mode for this element.
     */
    enableEditing(): void;
    /**
     * Deletes this element.
     */
    delete(): void;
    /**
     * Returns all the association connected to this element. If a type argument is provided, the associations will
     * be filtered to those that match on specialization. 
     */
    getAssociations(type?: string): IAssociationApi[];
    /**
     * Sets the order index of this element within it's parent.
     */
    setOrder(index: number): void;
    /**
     * Notifies that this element has been changed, which would lead to a refresh of display text and errors. 
     * This can be useful when you want to force a refresh of the elements state within the designer.
     */
    notifyChanged(): void;
    /**
     * Gets the metadata value for the specified key.
     */
    getMetadata(key: string): string;
    /**
     * Returns true if a metadata value exists for the specified key.
     */
    hasMetadata(key: string): boolean;
    /**
     * Add the metadata value for the specified key. Throws an error if metadata already exists for the specified key.
     */
    addMetadata(key: string, value: string): void;
    /**
     * Sets the metadata value for the specified key. Adds the metadata if it does not exist.
     */
    setMetadata(key: string, value: string): void;
    /**
     * Removes the metadata value for the specified key.
     */
    removeMetadata(key: string): void;
}
```

## Event Triggered Scripts for Associations

Event Triggered Scripts in a module building environment enable developers to execute custom logic when specified events occur for associations. Below is an example of an event triggered script and an overview of the available APIs to interact with elements in an event-driven manner.

![Event Triggered Script for Associations Screenshot](images/event-triggered-script-association.png)

Inside the Module Builder designer you can add Association Event Handlers for an Association you've created or to an Association you want to extend from an existing Designer.

```typescript
if (!association) {
    return;
}
let sourceEnd = association.getOtherEnd().typeReference;
sourceEnd.setIsCollection(false);
sourceEnd.setIsNullable(false);
```

The example above gets executed when an associated is created which then turns the association into a 1 -> 1 composite relationship by disabling `Is Collection` and `Is Nullable` on the source end of the association.

The API provides several global objects and functions to interact with the application model, elements, packages, and user interface:

```typescript
/**
 * Returns the association that triggered this script's execution.
 */
declare const association: IAssociationApi;

/**
 * Returns information about the application and it's settings.
 */
declare const application: MacroApi.Context.IApplication;

/**
 * Returns the currently opened and displayed diagram.
 */
declare const currentDiagram: MacroApi.Context.IDiagramApi;

/**
 * Creates an element of specialization type with the specified name, as a child of the specified parent.
 */
declare function createElement(specialization: string, name: string, parentId: string): IElementApi;

/**
 * Creates an association of specialization type with from a sourceElementId and optionally to a targetElementId.
 */
declare function createAssociation(specialization: string, sourceElementId: string, targetElementId?: string): IAssociationApi;

/**
 * Returns the packages currently loaded into the designer.
 */
declare function getPackages(): IPackageApi[];

/**
 * Present a popup dialog for user feedback or intervention.
 */
declare const dialogService: IDialogService;

/**
 * Finds the element with the specified id across all loaded packages.
 */
declare function lookup(id: string): IElementApi;

/**
 * Finds the elements of the specified type across all loaded packages.
 */
declare function lookupTypesOf(type: string): IElementApi[];

/**
 * Removes specified suffixes from the provided string.
 * @param string The string from which the suffixes should be removed.
 * @param suffixes An array of suffix strings to remove.
 */
declare function removeSuffix(string: string, ...suffixes: string[]): string;

/**
* Returns the plural form of the specified word.
*/
declare function pluralize(word: string): string;

/**
* Returns the singular form of the specified word.
*/
declare function singularize(word: string): string;

interface IAssociationApi {
    /**
     * The human-readable specialization type (e.g. "Class", "Attribute", etc.)
     */
    specialization: string;
    /**
     * The unique identifier for the element.
     */
    id: string;
    /**
     * Returns the name of the element.
     */
    getName(): string;
    /**
     * Sets the name of the element.
     */
    setName(value: string): void;
    /**
     * The typeReference property of the element
     */
    typeReference: ITypeReference;
    /**
     * Returns true if this association end is the source-end of the association.
     */
    isSourceEnd(): boolean;
    /**
     * Returns true if this association end is the target-end of the association.
     */
    isTargetEnd(): boolean;
    /**
     * Returns the other-end of the association.
     */
    getOtherEnd(): IAssociationApi;
    /**
     * Returns the owning package for this element.
     */
    getPackage(): IPackageApi;
    /**
     * Returns all stereotypes currently applied to the element.
     */
    getStereotypes(): IStereotypeApi[];
    /**
     * Returns the stereotype that matches the specified name or definition identifier
     */
    getStereotype(nameOrDefinitionId: string): IStereotypeApi;
    /**
     * Returns all the child elements of this element. If a type argument is provided, the children will
     * be filtered to those that match on specialization. 
     */
    getChildren(type: string): IElementApi[];
    /**
    * Gets the metadata value for the specified key.
    */
    getMetadata(key: string): string;
    /**
     * Returns true if a metadata value exists for the specified key.
     */
    hasMetadata(key: string): boolean;
    /**
     * Add the metadata value for the specified key. Throws an error if metadata already exists for the specified key.
     */
    addMetadata(key: string, value: string): void;
    /**
     * Sets the metadata value for the specified key. Adds the metadata if it does not exist.
     */
    setMetadata(key: string, value: string): void;
    /**
     * Removes the metadata value for the specified key.
     */
    removeMetadata(key: string): void;
    /**
     * Deletes this association.
     */
    delete(): void;
}
```
