---
title: Semantics of the Symbolic Queries
weight: 10
menuTitle: "Symbolic Queries"
---

In the following we give a pseudo-formal semantics for the requirement specification language of UPPAAL. We assume the existence of a timed transition system (_S, s<sub>0</sub>,_ →) as defined in the [semantics of UPPAAL](/language-reference/system-description/semantics/l). In the following, <tt>p</tt> and <tt>q</tt> are [state properties](#state-properties) for which we define the following temporal properties:

### Possibly

The property <tt>E<> p</tt> evaluates to true for a timed transition system if and only if there is a sequence of alternating delay transitions and action transitions _s_<sub>_0_</sub> &rarr; _s_<sub>_1_</sub> &rarr; ... &rarr; _s_<sub>_n_</sub>, where _s_<sub>_0_</sub> is the initial state and _s_<sub>_n_</sub> satisfies _p_.

### Invariantly

The property <tt>A[] p</tt> evaluates to true if (and only if) every reachable state satisfy <tt>p</tt>.

An _invariantly_ property <tt>A[] p</tt> can be expressed as the _possibly_ property <tt>not E<> not p</tt>.

### Potentially always

The property <tt>E[] p</tt> evaluates to true for a timed transition system if and only if there is a sequence of alternating delay or action transitions _s_<sub>_0_</sub> &rarr; _s_<sub>_1_</sub> &rarr; ... &rarr; _s_<sub>_i_</sub> &rarr; ... for which _p_ holds in all states _s_<sub>_i_</sub> and which either:

*   is infinite, or
*   ends in a state (_L_<sub>_n_</sub>, _v_<sub>_n_</sub>) such that either
    *   for all _d_: (_L_<sub>_n_</sub>, _v_<sub>_n_</sub>_+d_) satisfies _p_ and _Inv_(_L_<sub>_n_</sub>), or
    *   there is no outgoing transition from (_L_<sub>_n_</sub>, _v_<sub>_n_</sub>_)

### Eventually

The property <tt>A<> p</tt> evaluates to true if (and only if) all possible transition sequences eventually reaches a state satisfying <tt>p</tt>.

An _eventually_ property <tt>A<> p</tt> can be expressed as the _potentially_ property <tt>not E[] not p</tt>.

### Leads To

The syntax <tt>p --> q</tt> denotes a leads to property meaning that whenever <tt>p</tt> holds eventually <tt>q</tt> will hold as well. Since UPPAAL uses timed automata as the input model, this has to be interpreted not only over action transitions but also over delay transitions.

A _leads to_ property <tt>p --> q</tt> can be expressed as the property <tt>A[] (p imply A<> q)</tt>.



## State Properties

Any side-effect free [expression](/language-reference/expressions/) is a valid state property. In addition it is possible to test whether a process is in a particular location and whether a state is a deadlock. State proprerties are evaluated for the initial state and after each transition. This means for example that a property <tt>A[] i != 1</tt> might be satisfied even if the value of <tt>i</tt> becomes 1 momentarily during the evaluation of initializers or update-expressions on edges.

### Locations

Expressions on the form <tt>P.ℓ</tt>, where <tt>P</tt> is a process and <tt>ℓ</tt> is a location, evaluate to true in a state (_L, v_) if and only if _P.ℓ_ is in _L_.

### Deadlocks

The state property <tt>deadlock</tt> evaluates to true for a state (_L, v_) if and only if for all _d ≥ 0_ there is no action successor of (_L, v + d_).

## Property Equivalences

The UPPAAL requirement specification language supports five types of properties, which can be reduced to two types as illustrated by the following table.

| Name               | Property | Equivalent to       |
|--------------------|----------|---------------------|
| Posibly            | E<> p    |                     |
| Invariantly        | A[] p    | not E<> not p       |
| Potentially always | E[] p    |                     |
| Eventually         | A<> p    | not E[] not p       |
| Leads to           | p --> q  | A[] (p imply A<> q) |

</center>
