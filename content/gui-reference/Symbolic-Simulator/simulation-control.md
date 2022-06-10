---
title: Simulation Control
weight: 30
---

The simulation control is the left panel of the simulator. It is used to control the simulation and to select the (symbolic) state or transition to be visualized in the other two panels of the simulator. The control panel is divided in two parts:

The upper part is used for performing step-by-step simulation. A list view displays the enabled transitions, with the currently selected transition highlighted. Pressing the _Next_-button causes the simulated system to take the selected transition. The _Reset_-button is used to reset the simulated system to its initial state.

The lower part of the control panel has a view displaying the generated trace. The displayed trace is an alternating sequence of control location vectors and transitions. The simulation always progresses from the highlighted element in this view. It is possible to change the selection using the mouse.

The six buttons below the trace view have the following semantics:

*   **Prev:** highlights the element immediately preceding the current selection (if any) in the trace.
*   **Next:** highlights the element immediately following the current selection (if any) in the trace.
*   **Replay:** replays the trace starting from the currently selected element.
*   **Open:** opens a file dialog for loading a trace from file.
*   **Save:** opens a file dialog for saving the current trace on file. The valid file extension is "xtr". When no file extension is provided, it will be automatically appended.
*   **Random:** starts a random simulation where the simulator proceed automatically by randomly selecting enabled transitions.

The slider at the bottom of the control panel is used to control the speed used when traces are replayed and when random simulation is performed.

## Keyboard Shortcuts

<center>

<table border="1">

<tbody>

<tr>

<th>Key</th>

<th>Shortcut to</th>

</tr>

<tr>

<td>Z</td>

<td>Move selection up in the enabled transitions list view.</td>

</tr>

<tr>

<td>X</td>

<td>Move selection down in the enabled transitions list view.</td>

</tr>

<tr>

<td>Q</td>

<td>Correspond to the button Prev.</td>

</tr>

<tr>

<td>A</td>

<td>Correspond to the button Next.</td>

</tr>

<tr>

<td>P</td>

<td>Correspond to the button Replay.</td>

</tr>

<tr>

<td>R</td>

<td>Correspond to the button Random.</td>

</tr>

<tr>

<td>F</td>

<td>Highlights the first element in the trace.</td>

</tr>

<tr>

<td>L</td>

<td>Highlights the last element in the trace.</td>

</tr>

<tr>

<td><SPACE></td>

<td>Toggle selection of an enabled transition.</td>

</tr>

<tr>

<td width="3cm"><ENTER></td>

<td>Follow the selected enabled transition.</td>

</tr>

</tbody>

</table>

</center>