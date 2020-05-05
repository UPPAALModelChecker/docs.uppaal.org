---
title: Symbolic Traces
weight: 60
---

Since clocks range over the non-negative reals, timed automata can have infinitely many states (not to be confused with locations) and infinitely many traces. The simulator cannot visualize all these concrete traces. Instead it shows an infinite set of traces - a so called symbolic trace. Each symbolic state of a symbolic trace is a set of states and their delay successors described by a number of [constraints on the clocks](Variables_Window.html). In a given symbolic state, the active locations and the values of discrete variables are the same for all states.

Symbolic traces shown in the simulator are backward stable, but not forward stable:

<dl>

<dt>**Forward stable**</dt>

<dd>Given two symbolic states A and B on a symbolic trace such that A is before B, every state in A can reach a state in B.</dd>

<dt>**Backward stable**</dt>

<dd>Given two symbolic states A and B on a symbolic trace such that A is before B, every state in B can be reached by a state in A.</dd>

</dl>

In particular, care must be taken when interpreting a counter example produced by the model checker: Not every state in the symbolic states along a symbolic trace will necessarily lead to an error state, although all states in the last symbolic state are indeed reachable from the initial state.

**Note:** `verifyta` can be used to produce forward stable traces.