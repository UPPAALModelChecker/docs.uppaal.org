---
title: Navigation Tree
weight: 10
---

The navigation tree is shown in the left panel of the system editor. It is used for accessing the various components of a system description. A node in the tree can be double clicked to view (or hide) the sub tree of the node. The root of the navigation tree is named _Project_.

The sub node _Declarations_ is used for [declarations](/language-reference/system-description/declarations/) of global scope. They can be referred to directly in template declarations.

Each process [template](/language-reference/system-description/templates/) of the system description is represented by a node placed under the root node of the navigation tree. When this node is selected (i.e. clicked) the automaton becomes available for editing in the right panel of the system editor. Each template has a sub node named _Declarations_ that is used for typing in local [declarations](/language-reference/system-description/declarations/) and documentation comments.

The remaining sub node of the root, named _System declarations_ is used for further [declarations](/language-reference/system-description/declarations/), [process assignments](/language-reference/system-description/system-definition/template-instantiation/), and the [system declaration](/language-reference/system-description/system-definition/).

**Note:** the navigation tree can be opened in a separate window using the "Drag out" button. The window returns to its original position when it is closed.
