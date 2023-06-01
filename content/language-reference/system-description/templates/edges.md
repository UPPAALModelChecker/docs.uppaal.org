---
title: Edges
weight: 20
---

Locations are connected by _edges_. Edges are annotated with _selections_, _guards_, _synchronisations_ and _updates_. Edges may also have branches of possible destinations with their own updates and probabilistic _weights_.

Selections
: Selections non-deterministically bind a given identifier to a value in a given range. The other three labels of an edge are within the scope of this binding.

Guards
: An edge is enabled in a state if and only if the guard evaluates to true.

Synchronisation
: Processes can synchronize over channels. Edges labelled with complementary actions over a common channel synchronise.

Updates
: When executed, the update expression of the edge is evaluated. The side effect of this expression changes the state of the system.

Weights
: Edges emanating from a branchpoint can be assigned a probabilistic weight. The probability such edge-transition is proportional to the edge weight and inversely proportional to the sum of weights over all edges leaving that branchpoint.</dd>

</dl>

## Selections

``` EBNF
SelectList ::= ID ':' Type
             | SelectList ',' ID ':' Type
```

For each `ID` in `SelectList`, bind `ID` non-deterministically to a value of type `Type` domain.
The identifiers are available as variables within the other labels of this edge (guard, synchronization, or update). The supported types are bounded integers and scalar sets.
**Note:** The identifiers will shadow any variables with the same name.

### Example

**Select:** `i : int[0,3]`<br>
**Synchronization:** `a[i]?`<br>
**Update:** `receive_a(i)`

This edge will non-deterministically bind `i` to an integer in the range `0` to `3`, inclusive. The value `i` is then used both as an array index when deciding what channel to synchronize on, and as an argument in the subsequent call to the function `receive_a`.

## Guards

Guards follow the abstract syntax of [expressions](/language-reference/expressions/). However, the type checker restricts the set of possible expressions allowed in guards: A guard must be a conjunction of simple conditions on clocks, differences between clocks, and boolean expressions not involving clocks. The bound must be given by an integer expression.

### Examples

`x >= 1 && x <= 2`
: `x` is in the interval `[1,2]`.

`x < y`
: `x` is (strictly) less than `y`.

`(i[0]+1) != (i[1]*10)`
: Value at position `0` in an integer array `i` plus one is not equal to value at position `1` times `10` (`i` must be an integer array since we use arithmetic operations on its elements).

<a name="sync"></a>

## Synchronisations

Channels are used to synchronise processes. This is done by annotating edges in the model with _synchronisation labels_. Synchronisation labels are syntactically very simple. They are of the form `e?` or `e!`, where `e` is a side effect free expression evaluating to a channel.

The intuition is that two processes can synchronise on enabled edges annotated with complementary synchronisation labels, _i.e._ two edges in different processes can synchronise if the guards of both edges are satisfied, and they have synchronisation labels `e1?` and `e2!` respectively, where `e1` and `e2` evaluate to the same channel.

When two processes synchronise, both edges are fired at the same time, _i.e._ the current location of both processes is changed. The update expression on an edge synchronizing on `e1!` is executed before the update expression on an edge synchronizing on `e2?`. This is similar to the kind of synchronisation used in CCS or to rendezvous synchronisation in SPIN.

Urgent channels are similar to regular channels, except that it is not possible to delay in the source state if it is possible to trigger a synchronisation over an urgent channel. Notice that clock guards are not allowed on edges synchronising over urgent channels.

Broadcast channels allow 1-to-many synchronisations. The intuition is that an edge with synchronisation label `e!` emits a broadcast on the channel `e` and that any enabled edge with synchronisation label `e?` will synchronise with the emitting process. _I.e._ an edge with an emit-synchronisation on a broadcast channel can always fire (provided that the guard is satisfied), no matter if any receiving edges are enabled. But those receiving edges, which are enabled _will_ synchronise. Notice that clock guards are not allowed on edges receiving on a broadcast channel. The update on the emitting edge is executed first. The update on the receiving edges are executed left-to-right in the order the processes are given in the [system definition](/language-reference/system-description/system-definition/).

Notice that for both urgent and broadcast channels it is important to understand when an edge is enabled. An edge is enabled if the guard is satisfied. **Depending on the invariants, the target state might be undefined.** This does not change the fact that the edges are enabled! _E.g._ when two edges in two different processes synchronise via a broadcast channel, and the invariant of the target location of the receiving edge is violated, then this state is not defined. It is **not** the case that the emitting edge can be fired by itself since the receiving edge is enabled and thus must synchronise. Please see the section about the [semantics](/language-reference/system-description/semantics/) for further details.

## Updates

An _update_ is a comma separated list of [expressions](/language-reference/expressions/). These expressions will typically have side effects. Assignments to clocks are limited to the regular `=` assignment operator and only integer expressions are allowed on the right hand side of such assignments. The syntax of updates is defined by the grammar for **Update**:

``` EBNF
Update ::= [Expression (',' Expression)*]
```

**Note:** Assignments are evaluated sequentially (not concurrently). On synchronizing edges, the assignments on the !-side (the emitting side) are evaluated before the ?-side (the receiving side).

The regular assignment operator, `=`, can be used for assigning values to integer, boolean, record and clock variables. The other assignment operators are limitted to integer and boolean variables and work as in C, _e.g._ `i += 2` is equivalent to `i = i + 2` except that any side effect of evaluating `i` is only executed once in the first case whereas it is executed twice in the latter case.

Please remember that any integers are bounded. Any attempt to assign a value outside the declared range to an integer, will cause an error and the verification will be aborted.

### Examples

`x = 0`
: clock (or integer variable) `x` is reset.

`j = ( i[1]>i[2] ? i[1] : i[2] )`
: integer `j` is assigned the maximum value of array elements `i[1]` and `i[2]`. This is equivalent to `j = i[1] >? i[2]`, except that one of the sub-expressions is evaluated twice in the example (once in the condition, and again in either the true case or the false case).

`x = 1, y = 2 * x`
: integer variable `x` is set to `1` and `y` to `2` (as assignments are interpreted sequentially).

## Weights

The weight over branch is a constant non-negative integer expressions denoting the probabilistic likely-hood of the branch being executed. The probability of a particular branch is determined as a ratio of its weight over the sum of weights of all branches emanating from the same branch node.

The weights are used in probabilistic and [statistical model checking](/gui-reference/verifier/verifying/).

### Example

**Select:** `i : int[0,3]`<br>
**Update:** `gen_data(i)`<br>
**Weight:** `w[i]`
