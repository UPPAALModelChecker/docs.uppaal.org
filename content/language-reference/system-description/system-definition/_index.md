---
title: System Definition
weight: 40
---

In the _system definition_, a system model is defined. Such a model consists of one or more concurrent processes, local and global variables, and channels.

Global variables, channels and functions can be defined in the system definition using the grammar for [declarations](/language-reference/system-description/declarations/). Such declarations have a global scope. However, they are not directly accessible by any template, as they are declared after the templates. They are most useful when giving actual arguments to the formal parameters of templates. The declarations in the system definition and in the top-level _declarations_ section are part of the system model.

The processes of the system model are defined in the form of a system declaration line, using the grammar for `System` given below. The system line contains a list of templates to be instantiated into processes. Processes can be prioritised as described in the section on [priorities](/language-reference/system-description/priorities/).

``` EBNF
System ::= 'system' ID ((',' | '<') ID)* ';'
```

Templates without parameters are instantiated into exactly one process with the same name as the template. Parameterised templates give rise to one process per combination of arguments, i.e., UPPAAL automatically binds any free template parameters. Any such parameter must be either a call-by-value bounded integer and or a call-by-value scalar. Individual processes can be referenced in expressions using the grammar for `Process` given below. Notice that this is already covered by the grammar for [expressions](/language-reference/expressions/).

``` EBNF
Process ::= ID '(' [Arguments] ')'
```

It is often desirable to manually bind some or all formal parameters of a template to actual arguments. This can be done by partial [instantiation of templates](/language-reference/system-description/system-definition/template-instantiation/).

Any [progress measures](progress-measures/) for the model or [Gantt chart](gantt-chart/) are defined after the system line.

## Example

_In this example we use the textual syntax for template declaration as used in the XTA format. In the GUI, these templates would be defined graphically._

``` c
process P()
{
    state s...;
    ...
}

process Q(int[0,3] a)
{
    state t...;
    ...
}

system P, Q;
```

This defines a system consisting of five processes named `P`, `Q(0)`, `Q(1)`, `Q(2)` and `Q(3)`. Automatic binding of template parameters is very useful in models in which a large number of almost identical processes must be defined, e.g., the nodes of a network in a model of a communication protocol. In order to express that, e.g., all `Q` processes must be in location `s`, an expression like `forall (i : int[0,3]) Q(i).s` suffices.
