---
title: Simulation Control
weight: 10
---

The simulation control is the left panel of the simulator. It is used to control the simulation and to select the state or transition to be visualized in the others panels of the simulator. The control panel is divided in two parts:

The upper part is used for performing step-by-step simulation. The _Transition chooser_ area is a clickable area where vertical axis displays the active transitions at this location and horizontal axis displays the time at which the transition will be ﬁred. The time interval where a transition is enabled and the time interval where a transition is selectable are colored in different way. The time interval in which a transition can be fired (where the transition is selectable) is delimited by markers: one small circle at the beginning and one at the end of the interval (full if it is close, empty if it is open). When the mouse move to a selectable area, the color of the interval become brighter. By clicking one can select a specific transition and a specific time for firing the transition. The selected transition will be highlighted. The time selected is displayed in the _Delay_-combo box. One can also specified directly the time in the _Delay_-combo, once the transition has been selected. If one click in a non-selectable zone of a transition, the tool chooses the closest valid time. The _Reset Delay_-button is used to reset the delay to zero. Pressing the _Take transition_-button causes the simulated system to fire the selected transition at the specified time. The _Reset_-button is used to reset the simulated system to its initial state.

The lower part of the control panel, the _Simulation Trace_ area, has a view displaying the generated trace. The displayed trace is an alternating sequence of control location vectors and transitions. The simulation always progresses from the highlighted element in this view. It is possible to change the selection using the mouse.

The _Simulation Trace_ area contains a combo box that displays the current time (according to the hightlighted state in the trace) and the following buttons:

*   **First:** highlights the first element in the trace.
*   **Last:** highlights the last element in the trace.
*   **Prev:** highlights the element immediately preceding the current selection (if any) in the trace.
*   **Next:** highlights the element immediately following the current selection (if any) in the trace.
*   **Play:** replays the trace starting from the currently selected element.
*   **Open:** opens a file dialog for loading a trace from file.
*   **Save:** opens a file dialog for saving the current trace on file. The valid file extension is "uctr". When no file extension is provided, it will be automatically appended.
*   **Random:** starts a random simulation where the simulator proceed automatically by randomly selecting enabled transitions at random time.

The slider is used to control the speed used when traces are replayed and when random simulation is performed.

## Keyboard Shortcuts

<center>

<table border="1">

<tbody>

<tr>

<th>Key</th>

<th>Shortcut to</th>

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

<td>Correspond to the button First.</td>

</tr>

<tr>

<td>L</td>

<td>Correspond to the button Last.</td>

</tr>

</tbody>

</table>

</center>