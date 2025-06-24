---
title: Semantics of the Symbolic Queries
weight: 10
menuTitle: "Symbolic Queries"
---

In the following we give a pseudo-formal semantics for the requirement specification language of UPPAAL. We assume the existence of a timed transition system (_S, s<sub>0</sub>,_ →) as defined in the [semantics of UPPAAL timed automata](/language-reference/system-description/semantics/). In the following, `p` and `q` are [state properties](#state-properties) for which we define the following temporal properties:

**See also** [Syntax of Symbolic Queries]({{<ref "language-reference/query-syntax/symbolic_queries">}}).

### Possibly

The property `E<> p` evaluates to true for a timed transition system if and only if there is a sequence of delay and action transitions _s_<sub>_0_</sub> &rarr; _s_<sub>_1_</sub> &rarr; ... &rarr; _s_<sub>_n_</sub>, where _s_<sub>_0_</sub> is the initial state and _s_<sub>_n_</sub> satisfies _p_.

Consider automaton `P` below:
![Possibly Example](/images/Possibly.svg "Possibly: E<> P.Possible3")
The property `E<> P.Possibly3` is satisfied because there exists (`E`) a path (along green edges) and there exists (`<>`) a state within that path satisfying the state predicate `P.Possible3` (green location). Finding a state satisfying the state predicate is enough to terminate the search.

The property `E<> P.Error` is *not* satisfied, because there does *not* exist a path, which would contain a state satisfying the predicate `Error` (the location `Error` is not reachable). An entire state space needs to be inspected in order to disprove the possibly query.

### Potentially Always

The property `E[] p` evaluates to true for a timed transition system if and only if there is a sequence of delay and action transitions _s_<sub>_0_</sub> &rarr; _s_<sub>_1_</sub> &rarr; ... &rarr; _s_<sub>_i_</sub> &rarr; ... for which _p_ holds in all states _s_<sub>_i_</sub> and which either:

*   is infinite, or
*   ends in a state (_L_<sub>_n_</sub>, _v_<sub>_n_</sub>) such that either
    *   for all _d_: (_L_<sub>_n_</sub>, _v_<sub>_n_</sub>_+d_) satisfies _p_ and _Inv_(_L_<sub>_n_</sub>), or
    *   there is no outgoing transition from (_L_<sub>_n_</sub>, _v_<sub>_n_</sub>)

Consider automaton `P` below:
![Possibly Example](/images/PotentiallyAlways.svg "Potentially Always: E[] P.Busy")
The property `E[] P.Busy` is satisfied because there exists (`E`) a path (trivially, without executing any edges) and where all (`[]`) states within that path (green location) satisfy the state predicate `P.Busy`, because the automaton *may* stay in location `P.Busy` indefinitely.

The property `E[] P.Busy or P.Future2 or P.Possible3` is satisfied because there exists (`E`) a path (along green edges) where all (`[]`) states within that path (green locations) satisfy the state predicate `P.Busy or P.Future2 or P.Possible3`, because the automaton *may* be in location `Busy` or location `Future2` or location `Possible3`.

The property `E[] P.Future1 or P.Future2` is *not* satisfied, because even though `Future1` or `Future2` can be reached by some paths, the predicate `P.Future1 or P.Future2` is not satisfied in the initial location `Busy` of those paths that reach either `Future1` or `Future2`.

### Eventually

The property `A<> p` evaluates to true if (and only if) all possible transition sequences eventually reaches a state satisfying `p`.

An _eventually_ property `A<> p` can be expressed as the _potentially_ property `not E[] not p`.

Consider automaton `P` below:
![Possibly Example](/images/Eventually.svg "Eventually: A<> good==1")
The property `A<> good==1` is satisfied because in all (`A`) paths (green edges) there exists (`<>`) a state (green locations) which satisfy the state predicate `good==1`.

The property `A<> P.Possible3` is *not* satisfied by the automaton, because *not* *all* paths lead to location `Possible3`. For example, there is a transition from `Busy` location to location `Future1` and from there none of the successor states can satisfy predicate `P.Possible3`, regardless of what edges are traversed afterwards.


### Invariantly

The property `A[] p` evaluates to true if (and only if) every reachable state satisfy `p`.

An _invariantly_ property `A[] p` can be expressed as the _possibly_ property `not E<> not p`.

Consider automaton `P` below:
![Possibly Example](/images/Invariantly.svg "Invariantly: A[] not P.Error")
The property `A[] not P.Error` is satisfied because in all (`A`) paths all (`[]`) states satisfy the state predicate `not Error`, because the location `Error` is not reachable by any path.

The property `A[] P.Busy` is *not* satisfied, because *not* *all* paths traversed states satisfy `P.Busy`. For example, a path leading to `Future1` contains a location `Future1` which does not satisfy predicate `P.Busy`. A single reachable but unsatisfying state is enough to disprove the invariantly property.

### Leads To

The syntax `p --> q` denotes a leads to property meaning that whenever `p` holds eventually `q` will hold as well. Since UPPAAL uses timed automata as the input model, this has to be interpreted not only over action transitions but also over delay transitions.

A _leads to_ property `p --> q` can be expressed as the property `A[] (p imply A<> q)` (note that the leads-to property is a special case and in general nested quantifiers are not supported).

Consider automaton `P` below:
![Leads-to Example](/images/LeadsTo.svg "Leads-to: P.Fault --> P.Recover")
The property `P.Fault --> P.Recover` is equivalent to `A[] (P.Fault --> A<> P.Recover)`, which is satisfied because in all (`A`) paths all (`[]`) states either *never* satisfy the predicate `P.Fault` (location in red), *or* satisfy the state predicate `P.Fault` and then in all (`A`) proceeding paths there exists (`<>`) a state satisfying `P.Recover` predicate (green location). On one hand, the path consisting of just staying in `Busy` location indefinitely satisfies the query trivially. On the other hand, if location `Fault` is in the path, then `Recover` should also be within the finite future of all proceeding paths, meaning that the automaton cannot get stuck anywhere in between (location `Fault` has an invariant which forces it to take the transition to `Recover` location).
Then the automaton may loop from `Recover` to `Busy` location and thus the `Fault` can be reached again.
The leads-to formula requires that any (re)occurring `Fault` should be matched by `Recover` in all future path continuations.

Consider an extended example below:
![Leads-to unsatisfied Example](/images/LeadsToBad.svg "Unsatisfied leads-to: P.Fault --> P.Recover")
The leads-to query `P.Fault --> P.Recover` is no longer satisfied for the following reasons.
Even though location `Recover` is still reachable from `Fault`, the automaton has a non-deterministic transition to `Workaround` location and thus may loop indefinitely between `Fault` and `Workaround` locations, without ever reaching `Recover`.
Interestingly, the edge to `Workaround` is guarded by boolean variable `repaired` which initially is `false`, hence the transition to `Workaround` is *not* available, the automaton is forced to move to `Recover` and thus such path still satisfies the property.

However, the state of boolean variable `repaired` is changed to `true` after `Recover` location is left, hence the next time `Fault` is visited the automaton will have a non-deterministic choice between edges leading to `Recover` and `Workaround`, where the option to `Workaround` enables an infinite loop preventing the automaton from ever reaching the location `Recover`.

The fact that `Recover` has been visited earlier in the path does not help if `Fault` is found again: another matching `Recover` state needs to appear in all paths to satisfy the leads-to property.

Below is an unfolded automaton for the automaton above:
![Leads-to unsatisfied Example Unfolded](/images/LeadsToBadUnfolded.svg "Unsatisfied leads-to unfolded")
When the automaton reaches `Fault1` the transition to `Workaround0` is disabled and the automaton surely reaches location `Recover1` in green, but when automaton arrives at location `Fault2` the extra transition to `Workaround` is available, where an infinite loop (edges in red) *may* prevent from reaching `Recover2`, and thus the automaton is *not* guaranteed to reach `Recover2` after `Fault2`.

##  Witness and Counter Examples

UPPAAL can be instructed to produce a witness or counter example path showing how the property is satisfied or disproved by enabling [Diagnostic Trace](/gui-reference/menu-bar/options/#diagnostic-trace) in [Options](/gui-reference/menu-bar/options) menu, or using [`-t` command line key](/toolsandapi/verifyta/).

The generated trace can then be loaded into [Symbolic Simulator](/gui-reference/symbolic-simulator/).
If diagnostic trace involves infinite loop, then [Symbolic Simulator](/gui-reference/symbolic-simulator/) highlights the looping steps in red, where the last red state in the trace can take a transition to a state included in the first red state by taking the same edge-transition as the first red edge.

## State Properties

Any side-effect free [expression](/language-reference/expressions/) is a valid state property: boolean variables, expressions over variables and boolean functions, also non-boolean variables and non-boolean functions whose value can be converted into boolean values using C type conversion rules (zero is `false` and non-zero is `true`), provided that the expressions do not modify the system state (all forms of assignment or increment/decrement of any state variable are disallowed).

In addition, it is possible to test whether a process is in a particular location and whether a state is a deadlock.

State properties are evaluated for the initial state and each state after a *complete* transition successor is computed.
For example, a property `A[] i != 1` might still be satisfied even if the value of `i` becomes `1` momentarily during the evaluation of initialize rs or update-expressions on edges, like sending process updating `i` to `1` and at the same transition the receiving process resets `i` to a different value than `1`.

### Locations

Expressions on the form `P.ℓ`, where `P` is a process and `ℓ` is a location, evaluate to true in a state (_L, v_) if and only if _P.ℓ_ is in _L_.

### Deadlocks

The state property `deadlock` evaluates to true for a state (_L, v_) if and only if for all _d ≥ 0_ there is no action successor of (_L, v + d_).

## Property Equivalences

The UPPAAL requirement specification language supports five types of properties, which can be reduced to two types as illustrated by the following table.

| Name               | Property  | Equivalent to         |
|--------------------|-----------|-----------------------|
| Possibly           | `E<> p`   |                       |
| Invariantly        | `A[] p`   | `not E<> not p`       |
| Potentially always | `E[] p`   |                       |
| Eventually         | `A<> p`   | `not E[] not p`       |
| Leads to           | `p --> q` | `A[] (p imply A<> q)` |
