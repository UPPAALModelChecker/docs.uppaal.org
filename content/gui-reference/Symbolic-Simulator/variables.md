---
title: Variables Panel
weight: 30
---

The variables panel is the middle panel of the simulator. It displays the values of the data and clock variables in the current state or transition selected in the trace of the [simulation control](./Simulation_Control.html) panel.

The data variable values are always shown as integers. The clock values are shown symbolically as a conjunction of clock guards of lower and upper bounds on individual clocks or differences between pairs of clocks (see [Expressions](../System_Descriptions/Expressions.html) section for more information on clock guards). The possible clock values of the associated state (or transition) are all possible solutions to the conjunction of all clock constraints. The symbols "[" and "]" are used for closed intervals and "(" and ")" for open intervals in the usual way.

If the selected element in the [simulation control](./Simulation_Control.html) panel is a state, the variables panel shows the symbolic values of the state (in normal black color). If the selected element is a transition, the shown symbolic values are those of the immediately preceding state satisfying the guard(s) of the transition (shown in <font color="#000099">**blue**</font> color).

**Note:** variables can be hidden and displayed using the "Variables..." item in the [View menu](../Menu_Bar/View.html). The representation of the clock constraints can also be changed from this menu, using the "Full DBM" item. When "Full DBM" is checked a constraint is shown for each pair of clocks, otherwise a minimum set of constraints is shown. The minimum set of constraints is such that all constraints that are in the full DBM but not in the minimum set can be derived from constraints in the minimum set.