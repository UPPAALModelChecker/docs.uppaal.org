---
title: Semantics of the Symbolic Queries
weight: 10
menuTitle: "Symbolic Queries"
---

In the following we give a pseudo-formal semantics for the requirement specification language of UPPAAL. We assume the existence of a timed transition system (_S, s<sub>0</sub>,_ →) as defined in the [semantics of UPPAAL timed automata](/language-reference/system-description/semantics/). In the following, `p` and `q` are [state properties](#state-properties) for which we define the following temporal properties:

### Possibly

The property `E<> p` evaluates to true for a timed transition system if and only if there is a sequence of delay and action transitions _s_<sub>_0_</sub> &rarr; _s_<sub>_1_</sub> &rarr; ... &rarr; _s_<sub>_n_</sub>, where _s_<sub>_0_</sub> is the initial state and _s_<sub>_n_</sub> satisfies _p_.

### Invariantly

The property `A[] p` evaluates to true if (and only if) every reachable state satisfy `p`.

An _invariantly_ property `A[] p` can be expressed as the _possibly_ property `not E<> not p`.

### Potentially always

The property `E[] p` evaluates to true for a timed transition system if and only if there is a sequence of delay and action transitions _s_<sub>_0_</sub> &rarr; _s_<sub>_1_</sub> &rarr; ... &rarr; _s_<sub>_i_</sub> &rarr; ... for which _p_ holds in all states _s_<sub>_i_</sub> and which either:

*   is infinite, or
*   ends in a state (_L_<sub>_n_</sub>, _v_<sub>_n_</sub>) such that either
    *   for all _d_: (_L_<sub>_n_</sub>, _v_<sub>_n_</sub>_+d_) satisfies _p_ and _Inv_(_L_<sub>_n_</sub>), or
    *   there is no outgoing transition from (_L_<sub>_n_</sub>, _v_<sub>_n_</sub>)

### Eventually

The property `A<> p` evaluates to true if (and only if) all possible transition sequences eventually reaches a state satisfying `p`.

An _eventually_ property `A<> p` can be expressed as the _potentially_ property `not E[] not p`.

### Leads To

The syntax `p --> q` denotes a leads to property meaning that whenever `p` holds eventually `q` will hold as well. Since UPPAAL uses timed automata as the input model, this has to be interpreted not only over action transitions but also over delay transitions.

A _leads to_ property `p --> q` can be expressed as the property `A[] (p imply A<> q)`.



## State Properties

Any side-effect free [expression](/language-reference/expressions/) is a valid state property. In addition it is possible to test whether a process is in a particular location and whether a state is a deadlock. State proprerties are evaluated for the initial state and after each transition. This means for example that a property `A[] i != 1` might be satisfied even if the value of `i` becomes 1 momentarily during the evaluation of initializers or update-expressions on edges.

### Locations

Expressions on the form `P.ℓ`, where `P` is a process and `ℓ` is a location, evaluate to true in a state (_L, v_) if and only if _P.ℓ_ is in _L_.

### Deadlocks

The state property `deadlock` evaluates to true for a state (_L, v_) if and only if for all _d ≥ 0_ there is no action successor of (_L, v + d_).

## Property Equivalences

The UPPAAL requirement specification language supports five types of properties, which can be reduced to two types as illustrated by the following table.

| Name               | Property  | Equivalent to         |
|--------------------|-----------|-----------------------|
| Posibly            | `E<> p`   |                       |
| Invariantly        | `A[] p`   | `not E<> not p`       |
| Potentially always | `E[] p`   |                       |
| Eventually         | `A<> p`   | `not E[] not p`       |
| Leads to           | `p --> q` | `A[] (p imply A<> q)` |

</center>
