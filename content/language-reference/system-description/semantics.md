---
title: Semantics
weight: 60
---

In the following we give a pseudo-formal semantics for UPPAAL. The semantics defines a timed transition system (_S, s<sub>0</sub>,_ →) describing the behaviour of a network of extended timed automata. The set of states _S_ is defined as {(_L, v_) | _v ⊨ Inv_(_L_)}, where _L_ is a location vector, _v_ is a function (called a _valuation_) mapping integer variables and clocks to their values, and _Inv_ is a function mapping locations and location vectors to invariants. The initial state _s<sub>0</sub>_ is the state where all processes are in the initial location, all variables have their initial value, and all clocks are zero. The transition relation, →, contains two kinds of transitions: delay transitions and action transitions. We will describe each type below.

Given a valuation _v_ and an expression _e_, we say that _v_ satisfies _e_ if _e_ evaluates to non-zero for the given valuation _v_.

## Invalid Evaluations

If during a successor computation any expression evaluation is invalid (consult the section on [expressions](Expressions.html) for further details about invalid evaluations), the verification is aborted.

## Delay Transitions

Delay transitions model the passing of time without changing the current location. We have a delay transition (_L, v_) −<sup>d</sup>→ (_L, v'_), where _d_ is a non-negative real, if and only if:

*   _v' = v+d_, where _v+d_ is obtained by incrementing all clocks with _d_.
*   for all _0 ≤ d' ≤ d: v+d' ⊨ Inv_(_L_)
*   _L_ contains neither committed nor urgent locations
*   for all locations _ℓ_ in _L_ and for all locations _ℓ'_ (not necessarily in _L_), if there is an edge from _ℓ_ to _ℓ'_ then either:
    *   this edge does not synchronise over an urgent channel, or
    *   this edge does synchronise over an urgent channel, but for all _0 ≤ d' ≤ d_ we have that _v+d'_ does not satisfy the guard of the edge.

## Action Transitions

For action transtions, the synchronisation label of edges is important. Since UPPAAL supports arrays of channels, we have that the label contains an expression evaluating to a channel. The concrete channel depends on the current valuation. To avoid cluttering the semantics we make the simplifying assumption that each synchronisation label refers to a channel directly.

[Priorities](Priorities.html) increase the determinism of a system by letting a high priority action transition block a lower priority action transition. Note that delay transitions can never be blocked, and no action transition can be blocked by a delay transition.

For action transitions, there are three cases: Internal transitions, binary synchronisations and broadcast synchronisations. Each will be described in the following.

### Internal Transitions

We have a transition (_L, v_) −<sup>*</sup>→ (_L', v'_) if there is an edge _e=_(_ℓ,ℓ'_) such that:

*   there is no synchronisation label on _e_
*   _v_ satisfies the guard of _e_
*   _L' = L_[_ℓ'/ℓ_]
*   _v'_ is obtained from _v_ by executing the update label given on _e_
*   _v'_ satisfies _Inv_(_L'_)
*   Either _ℓ_ is committed or no other location in _L_ is committed.
*   There is no action transition from (_L, v_) with a strictly higher [priority](Priorities.html).

### Binary Synchronisations

We have a transition (_L, v_) −<sup>*</sup>→ (_L', v'_) if there are two edges _e<sub>1</sub>=_(_ℓ<sub>1</sub>,ℓ<sub>1</sub>'_) and _e<sub>2</sub>=_(_ℓ<sub>2</sub>,ℓ<sub>2</sub>'_) in two different processes such that:

*   _e<sub>1</sub>_ has a synchronisation label _c!_ and _e<sub>2</sub>_ has a synchronisation label _c?_, where _c_ is a binary channel.
*   _v_ satisfies the guards of _e<sub>1</sub>_ and _e<sub>2</sub>_.
*   _L' = L_[_ℓ<sub>1</sub>'/ℓ<sub>1</sub>, ℓ<sub>2</sub>'/ℓ<sub>2</sub>_]
*   _v'_ is obtained from _v_ by first executing the update label given on _e<sub>1</sub>_ and then the update label given on _e<sub>2</sub>_.
*   _v'_ satisfies _Inv_(_L'_)
*   Either
    *   _ℓ<sub>1</sub>_ or _ℓ<sub>2</sub>_ or both locations are committed, or
    *   no other location in _L_ is committed.
*   There is no action transition from (_L, v_) with a strictly higher [priority](Priorities.html).

### Broadcast Synchronisations

Assume an order _p<sub>1</sub>, p<sub>2</sub>, … p<sub>n</sub>_ of processes given by the order of the processes in the system declaration statement. We have a transition (_L, v_) −<sup>*</sup>→ (_L', v'_) if there is an edge _e=_(_ℓ,ℓ'_) and _m_ edges _e<sub>i</sub>=_(_ℓ<sub>i</sub>,ℓ<sub>i</sub>'_) for _1≤i≤m_ such that:

*   Edges _e, e<sub>1</sub>, e<sub>2</sub>, …, e<sub>m</sub>_ are in different processes.
*   _e<sub>1</sub>, e<sub>2</sub>, …, e<sub>m</sub>_ are ordered according to the process ordering _p<sub>1</sub>, p<sub>2</sub>,… p<sub>n</sub>_.
*   _e_ has a synchronisation label _c!_ and _e<sub>1</sub>, e<sub>2</sub>, …, e<sub>m</sub>_ have synchronisation labels _c?_, where _c_ is a broadcast channel.
*   _v_ satisfies the guards of _e, e<sub>1</sub>, e<sub>2</sub>, … e<sub>m</sub>_.
*   For all locations _ℓ_ in _L_ not a source of one of the edges _e, e<sub>1</sub>, e<sub>2</sub>, … e<sub>m</sub>_, all edges from _ℓ_ either do not have a synchronisation label _c?_ or _v_ does not satisfy the guard on the edge.
*   _L' = L_[_ℓ'/ℓ, ℓ<sub>1</sub>'/ℓ<sub>1</sub>, ℓ<sub>2</sub>'/ℓ<sub>2</sub>, … ℓ<sub>m</sub>'/ℓ<sub>m</sub>_]
*   _v'_ is obtained from _v_ by first executing the update label given on _e_ and then the update labels given on _e<sub>i</sub>_ for increasing order of _i_.
*   _v'_ satisfies _Inv_(_L'_)
*   Either
    *   one or more of the locations _ℓ, ℓ<sub>1</sub>, ℓ<sub>2</sub>, … ℓ<sub>m</sub>_ are committed, or
    *   no other location in _L_ is committed.
*   There is no action transition from (_L, v_) with a strictly higher [priority](Priorities.html).

<a name="prob">

### Probabilistic Transitions

</a>

In [statistical model checking](../Verifier/Verifying.html) the concrete delay and transition are determined as follows:

1.  Each process chooses a delay based on its current location:
    *   If the current location invariant has a time bound, then the concrete delay is taken according uniform distribution up to that bound.
    *   Otherwise (the time invariant is absent) the delay is chosen by exponential distribution using the rate λ specified on the current location. The probability density function of delay d∈[0;∞) is F(d)=λe<sup>−λd</sup>, where e=2.718281828… and the concrete delay is generated by <sup>−ln(u)</sup>/<sub>λ</sub> where u is a uniform random number from (0;1] interval.
2.  The process with the shortest delay is chosen. If there are several such processes then a random one of these is chosen (according to uniform distribution).
3.  The shortest delay is executed and continuous variables are updated.
4.  The chosen process attempts to take a transition:
    *   Compute all enabled internal and sending edge-transitions.
    *   Pick the concrete edge according to uniform distribution.
    *   If the edge has probabilistic branches, then the probability of taking a branch _i_ is determined by the ratio _<sup>w<sub>i</sub></sup>/<sub>W</sub>_, where _w<sub>i</sub>_ is the weight of the branch _i_ and _W_ is the sum of all branch weights: _W=Σ<sub>j</sub>w<sub>j</sub>_.

[Statistical model checking](../Verifier/Verifying.html) has the following assumptions about the model:

<dl>

<dt>Input enableness (non-blocking inputs):</dt>

<dd>Sending cannot be blocked, i.e. the channel is either broadcast or there is always one process with an enabled receiving edge-transition.</dd>

<dt>Input determinism:</dt>

<dd>There is exactly one enabled receiving edge-transition at a time. For binary synchronizations there is at most one receiving process at a time.</dd>

</dl>

For more details about probabilistic semantics of priced timed automata please see:

> _Statistical Model Checking for Networks of Priced Timed Automata_, Alexandre David, Kim G. Larsen, Axel Legay, Marius Mikučionis, Danny Bøgsted Poulsen, Jonas van Vliet and Zheng Wang. In Proceedings of the 9<sup>th</sup> International Conference on Formal Modeling and Analysis of Timed Systems (FORMATS), Aalborg, Denmark, September 2011.