---
title: Progress Measures
weight: 20
---

A progress measure is an expression that defines progress in the model. It should be weakly monotonically increasing, although occasional decreasses are acceptable. E.g. sequence numbers used in communication protocols might be used to define a progress measure, provided that the sequence number does not overflow to often.

If progress measures are defined, UPPAAL uses the generalized sweepline method to reduce the memory usage. However to be efficient, the domain of a progress measure should not be too large - otherwise performance might degrade significantly.

Progress measures are placed after the system definition. The syntax is defined by the grammar for 
<tt>ProgressDecl</tt>:

``` EBNF
ProgressDecl  ::= 'progress' '{' ( [Expression] ';' )* '}'
```

## Examples

```c
int i, j, k;
...

progress
{
    i;
    j + k;
}
```

For the above to be a useful progress measure, `i` and `j + k` should increase weakly monotonically.
