---
title: Drawing
weight: 20
---

The rightmost panel of the system editor is used for drawing automata. There are currently four drawing tools named _Select_, _Location_, _Edge_, and _Nail_ represented by the buttons in the tool bar.

*   **Select tool:** The select tool is used to select, move, modify and delete elements. Elements can be selected by clicking on them or by dragging a rubber band arround one or more elements. Elements can be added or removed from a selection by holding down the control key while clicking on the element. The current selection can be moved by dragging them with the mouse. Double clicking an element brings up the editor for that element. Right clicking an element brings up a pop-up menu from which properties of the element can be changed. It is possible to change the source and target of an edge by moving the mouse to the beginning or end of an edge until a small circle appears. Drag this circle to a new location in order to change the source or target of the edge.
*   **Location tool:** The location tool is used to add new locations. Simply click with the left mouse button in order to add a new location.
*   **Branch tool:** The branch tool is used to create probabilistic branches. Simply click with the left mouse button in order to add a new branch point, then choose edge tool to create connecting edges.
*   **Edge tool:** The edge tool is used to add new edges between locations. Start the edge by clicking on the source location, then click in order to place nails and finally click the target location. The operation can be cancelled by pressing the right mouse button.
*   **Nail tool:** The nail tool is used to add new nails to an edge. Simply click and drag anywhere on an edge to add and place a new nail.

For users with a three button mouse, the middle mouse button can be used to create new elements. The editor automatically chooses the correct tool: Clicking on an empty spot creates a new location, clicking on a location creates a new edge and clicking on an edge creates a new nail. With this feature it is possible to use the functionallity of all four tools without having to select the tools directly.

## Colors

The display color of individual locations and edges can be changed from the pop-up menu for these elements. UPPAAL does not assign any semantic meaning to the colors of locations and edges.

## Comments

Comments can be added to locations and edges. Double click the location or edge to bring up the editor for that element. The editor has a _Comments_ tab for adding comments. UPPAAL does not assign any semantic meaning to the comments.

When shown in the tooltip of an element, comments are interpreted as HTML, i.e. tags like &lt;p> and &lt;b> may be used for formating.

## Tooltips

A tooltip is shown when hovering the mouse over an automaton element. The tooltip contains useful information such as syntax errors.