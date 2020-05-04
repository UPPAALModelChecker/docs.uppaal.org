---
title: View Menu
weight: 30
---

The view menu is used to modify the appearance of the system currently shown in the [system editor](../System_Editor/Introduction.html) and the [simulator](../Simulator/Introduction.html). The items are:

*   **Zoom:** shows a sub menu with fixed zoom values, zoom to fit, and itemes for zooming in, out, or to normal size. A change in the zoom value affects the templates the editor or the processes in the simulator (if one of the tools is active).
*   **Labels:** shows a sub menu from which one can select which type of labels should be shown in the drawing area. Even when hidden, all labels can be seen in the tooltip of locations and edges.
*   **Show Grid:** the drawing grid is shown when this item is checked.
*   **Snap to Grid:** makes new drawing objects (such as locations, nails, and labels) align to the snap grid. The size of the snap grid is related to the size of the drawing grid.

    **Note:** the _Snap to Grid_ option can be used even if the drawing grid is not shown.

*   **Coarser:** increases the distance between the lines in the drawing grid.
*   **Tighter:** decreases the distance between the lines in the drawing grid.
*   **Mark Visited** highlights the locations and edges traversed by a trace in the simulator [process panel](../Simulator/Process_Window).
*   **Show Coverage** shows graphs of location and edge coverage dynamics over the simulated trace in a popup window. The _Mark Visited_ option above enables this menu item.
*   **Reload Simulator:** uploads the system currently loaded in the editor, to the simulator and the verifier.
*   **Processes:** displays a dialog window for hiding and showing processes in the [process panel](../Simulator/Process_Window.html) of the simulator.
*   **Variables:** shows a dialog window for hiding and showing variables in the [variables panel](../Simulator/Variables_Window.html) of the simulator.
*   **Full DBM:** shows all constraints on the clocks in the [variables panel](../Simulator/Variables_Window.html) of the simulator. If not selected a minimal number of constraints will be shown.