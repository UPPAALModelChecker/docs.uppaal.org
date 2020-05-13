---
title: Gantt Chart Panel
weight: 50
---

The Gantt Chart panel is the middle rightmost panel of the simulator. It displays another view of the generated trace according to the Gantt Chart specification given in [system definition](/language-reference/system-description/system-definition/).

In the Gantt Chart view, the horizontal axis represents the time span, and in the vertical axis the list of activities (usually some of the system processes) defined in the Gantt chart specification are listed. A vertical line is used to represent the current time (which corresponds to the one displayed in the _Simulation Trace_-combo box). Horizontal bars of varying lengths and colors represent when the different expressions in the Gantt chart specification are satisfied according to the current state of the trace.

If the mouse is placed over a Gantt bar, information about the intervals when the corresponding expressions are satisfied are shown.