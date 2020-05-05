---
title: Templates
weight: 20
---

UPPAAL provides a rich language for defining templates in the form of extended timed automata. In contrast to classical timed automata, timed automata in UPPAAL can use a rich expression language to test and update clock, variables, record types, call user defined functions, etc.

The automaton of a template consist of [Locations](Locations.html) and [edges](Edges.html). A template may also have local [declarations](Declarations.html) and [parameters](Parameters.html). A template is instantiated by a [process assignment](Process_Assignments.html) (in the [system definition](System_Definition.html)).