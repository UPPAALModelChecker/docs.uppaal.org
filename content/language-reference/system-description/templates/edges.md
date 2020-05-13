---
title: Edges
weight: 20
---

Locations are connected by _edges_. Edges are annotated with _selections_, _guards_, _synchronisations_ and _updates_. Edges may also have branches of possible destinations with their own updates and probabilistic _weights_.

<dl>

<dt>Selections</dt>

<dd>Selections non-deterministically bind a given identifier to a value in a given range. The other three labels of an edge are within the scope of this binding.</dd>

<dt>Guards</dt>

<dd>An edge is enabled in a state if and only if the guard evaluates to true.</dd>

<dt>Synchronisation</dt>

<dd>Processes can synchronize over channels. Edges labelled with complementary actions over a common channel synchronise.</dd>

<dt>Updates</dt>

<dd>When executed, the update expression of the edge is evaluated. The side effect of this expression changes the state of the system.</dd>

<dt>Weights</dt>

<dd>Probabilistic branches .</dd>

</dl>

## Selections

<pre>SelectList ::= ID ':' Type
             | SelectList ',' ID ':' Type
</pre>

For each <tt>ID</tt> in <tt>SelectList</tt>, bind <tt>ID</tt> non-deterministically to a value of type <tt>Type</tt>. The identifiers are available as variables within the other labels of this edge (guard, synchronization, or update). The supported types are bounded integers and scalar sets.  
**Note:** The identifiers will shadow any variables with the same names.

### Example

**select:** <tt>i : int[0,3]</tt>  
**synchronization:** <tt>a[i]?</tt>  
**update expression:** <tt>receive_a(i)</tt>

This edge will non-deterministically bind <tt>i</tt> to an integer in the range 0 to 3, inclusive. The value <tt>i</tt> is then used both as an array index when deciding what channel to synchronize on, and as an argument in the subsequent call to the function <tt>receive_a</tt>.

## Guards

Guards follow the abstract syntax of [expressions](/language-reference/expressions/). However, the type checker restricts the set of possible expressions allowed in guards: A guard must be a conjunction of simple conditions on clocks, differences between clocks, and boolean expressions not involving clocks. The bound must be given by an integer expression.

### Examples

*   <tt>x >= 1 && x <= 2</tt>  
    <tt>x</tt> is in the interval [1,2].
*   <tt>x < y</tt>  
    <tt>x</tt> is (strictly) less than <tt>y</tt>.
*   <tt>(i[0]+1) != (i[1]*10)</tt>  
    Value at position 0 in an integer array <tt>i</tt> plus one is not equal to value at position 1 times 10 (<tt>i</tt> must be an integer array since we use arithmetic operations on its elements).

<a name="sync"></a>

## Synchronisations

Channels are used to synchronise processes. This is done by annotating edges in the model with _synchronisation labels_. Synchronisation labels are syntactically very simple. They are of the form <tt>e?</tt> or <tt>e!</tt>, where <tt>e</tt> is a side effect free expression evaluating to a channel.

The intuition is that two processes can synchronise on enabled edges annotated with complementary synchronisation labels, _i.e._ two edges in different processes can synchronise if the guards of both edges are satisfied, and they have synchronisation labels <tt>e1?</tt> and <tt>e2!</tt> respectively, where <tt>e1</tt> and <tt>e2</tt> evaluate to the same channel.

When two processes synchronise, both edges are fired at the same time, _i.e._ the current location of both processes is changed. The update expression on an edge synchronizing on <tt>e1!</tt> is executed before the update expression on an edge synchronizing on <tt>e2?</tt>. This is similar to the kind of synchronisation used in CCS or to rendezvous synchronisation in SPIN.

Urgent channels are similar to regular channels, except that it is not possible to delay in the source state if it is possible to trigger a synchronisation over an urgent channel. Notice that clock guards are not allowed on edges synchronising over urgent channels.

Broadcast channels allow 1-to-many synchronisations. The intuition is that an edge with synchronisation label <tt>e!</tt> emits a broadcast on the channel <tt>e</tt> and that any enabled edge with synchronisation label <tt>e?</tt> will synchronise with the emitting process. _I.e._ an edge with an emit-synchronisation on a broadcast channel can always fire (provided that the guard is satisfied), no matter if any receiving edges are enabled. But those receiving edges, which are enabled _will_ synchronise. Notice that clock guards are not allowed on edges receiving on a broadcast channel. The update on the emitting edge is executed first. The update on the receiving edges are executed left-to-right in the order the processes are given in the [system definition](/language-reference/system-description/system-definition/).

Notice that for both urgent and broadcast channels it is important to understand when an edge is enabled. An edge is enabled if the guard is satisfied. **Depending on the invariants, the target state might be undefined.** This does not change the fact that the edges are enabled! _E.g._ when two edges in two different processes synchronise via a broadcast channel, and the invariant of the target location of the receiving edge is violated, then this state is not defined. It is **not** the case that the emitting edge can be fired by itself since the receiving edge is enabled and thus must synchronise. Please see the section about the [semantics](/language-reference/system-description/semantics/) for further details.

## Updates

An _update_ is a comma separated list of [expressions](/language-reference/expressions/). These expressions will typically have side effects. Assignments to clocks are limited to the regular <tt>=</tt> assignment operator and only integer expressions are allowed on the right hand side of such assignments. The syntax of updates is defined by the grammar for <tt>Update</tt>:

<pre>Update ::= [Expression (',' Expression)*]
</pre>

**Note:** Assignments are evaluated sequentially (not concurrently). On synchronizing edges, the assignments on the !-side (the emitting side) are evaluated before the ?-side (the receiving side).

The regular assignment operator, <tt>=</tt>, can be used for assigning values to integer, boolean, record and clock variables. The other assignment operators are limitted to integer and boolean variables and work as in C, _e.g._ <tt>i += 2</tt> is equivalent to <tt>i = i + 2</tt> except that any side effect of evaluating <tt>i</tt> is only executed once in the first case whereas it is executed twice in the latter case.

Please remember that any integers are bounded. Any attempt to assign a value outside the declared range to an integer, will cause an error and the verification will be aborted.

### Examples

*   <tt>x = 0</tt>  
    clock (or integer variable) <tt>x</tt> is reset.
*   <tt>j = ( i[1]>i[2] ? i[1] : i[2] )</tt>  
    integer <tt>j</tt> is assigned the maximum value of array elements <tt>i[1]</tt> and <tt>i[2]</tt>. This is equivalent to <tt>j = i[1] >? i[2]</tt>, except that one of the sub-expressions is evaluated twice in the example (once in the condition, and again in either the true case or the false case).
*   <tt>x = 1, y=2*x</tt>  
    integer variable <tt>x</tt> is set to <tt>1</tt> and <tt>y</tt> to <tt>2</tt> (as assignments are interpreted sequentially).

## Weights

The weight over branch is a constant non-negative integer expressions denoting the probabilistic likely-hood of the branch being executed. The probability of a particular branch is determined as a ratio of its weight over the sum of weights of all branches emanating from the same branch node.

The weights are used in probabilistic and [statistical model checking](/gui-reference/verifier/verifying/).

### Example

**select:** <tt>i : int[0,3]</tt>  
**update expression:** <tt>gen_data(i)</tt>  
**weight:** <tt>w[i]</tt>