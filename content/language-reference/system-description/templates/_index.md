---
title: Templates
weight: 20
---

UPPAAL provides a rich language for defining templates in the form of extended timed automata. In contrast to classical timed automata, timed automata in UPPAAL can use a rich expression language to test and update clock, variables, record types, call user defined functions, etc.

The automaton of a template consist of [Locations](locations/) and [edges](edges/). A template may also have local [declarations](/language-reference/system-description/declarations/) and [parameters](/language-reference/system-description/parameters/). A template is instantiated by a [process assignment](/language-reference/system-description/system-definition/template-instantiation/) (in the [system definition](/language-reference/system-description/system-definition/)).