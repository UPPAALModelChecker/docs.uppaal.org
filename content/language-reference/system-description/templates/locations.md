---
title: Locations
weight: 10
---


Locations of a timed automaton are graphically represented as circles. If a timed automaton is considered as a directed graph, then locations represent the vertices of this graph. Locations are connected by [edges](/language-reference/system-description/templates/edges/).

## Names

Locations can have an optional name. Besides serving as an identifier allowing you to refer to the location from the [requirement specification language](/language-reference/requirements-specification/), named locations are useful when documenting the model. The name must be a valid [identifier](/language-reference/expressions/identifiers/) and location names share the name space with variables, types, templates, etc.

## Invariants

Locations are labelled with invariants. Invariants are expressions and thus follow the abstract syntax of [expressions](/language-reference/expressions/). However, the type checker restricts the set of possible expressions allowed in invariants.

An invariant must be a conjunction of simple conditions on clocks, differences between clocks, and boolean expressions not involving clocks. The bound must be given by an integer expression. Furthermore lower bounds on clocks are disallowed. It is important to understand that invariants influence the behaviour of the system -- they are distinctly different from specifying safety properties in the [requirements specification language](/language-reference/requirements-specification/). States which violate the invariants are undefined; by definition, such states do not exist. This influences the interpretation of urgent channels and broadcast channels. Please see the section on [synchronisations](/language-reference/system-description/templates/edges/#synchronisations) for a detailed discussion of this topic.

In addition, *stopwatches* are supported and they are declared within invariant expressions using [Lagrangian *derivative* notation](https://en.wikipedia.org/wiki/Notation_for_differentiation#Lagrange's_notation) (`x' == 0` for clock `x`) through conjunction (`&&` or `and`). Furthermore, the <tt>forall</tt> construct is accepted in invariants to ease use of clock arrays.

Statistical model checker supports arbitrary floating point expression as a clock *rate/derivative* which allows modeling of dynamical costs. Dynamical cost variables declared as `hybrid clock` are abstracted away from symbolic analysis, which allows to combine statistical and symbolic queries over the same model.

<a name="rate">

## Rate of Exponential

</a>

The rate of exponential is a ratio expression which specifies the rate of exponential probability distribution. The rate expression can be a simple integer expression or two integer expressions separated by a colon like <tt>r:q</tt> where the rate is determined as ratio <sup>r</sup>/<sub>q</sub>.

The rate of exponential is used in a [statistical model checking](/gui-reference/verifier/verifying/). If the location does not have an invariant over time, then it is assumed that the probability of leaving the location is distributed according to the exponential distribution: Pr(leaving after t)=1−e<sup>−λt</sup>, where e=2.718281828…, t is time and λ is the fixed rate. Probability density of the exponential distribution is λe<sup>−λt</sup> and thus intuitively λ means the probability density of leaving at time zero, i.e. as soon as some edge is enabled. The smaller the rate is specified, the longer the delay is preferred.

The generation of exact delay relies on pseudo random number generator and on 32-bit architectures the longest possible delay is rather limited: <sup>ln(2<sup>31</sup>)</sup>/<sub>λ</sub> ≈ <sup>21.49</sup>/<sub>λ</sub>.

### Examples

The following are valid invariants. Here <tt>x</tt> and <tt>y</tt> are clocks and <tt>i</tt> is an integer array.

`x <= 2`
: `x` is less than or equal to `2`.

`x < y`
: `x` is (strictly) less than `y`.

`forall(i:int[0,2]) x[i] <= 3`
: The clocks `x[0]`, `x[1]` and `x[2]` of the clock array `x` are less or equal to `3`.

`forall(i:int[0,2]) y[i]' == b[i]`
: The clock rates/derivatives `y[0]'`, `y[1]'`, and `y[2]'` are set to, respectively, `b[0]`, `b[1]` and `b[2]`. Note that for symbolic queries the only valid values are `0` and `1`. Setting the rate to `0` effectively stops a clock (makes it a stopwatch). In [statistical model checking](/gui-reference/verifier/verifying/) the rate is allowed to be any floating point expression. `hybrid clock` can be interpreted as a dynamical cost and abstracted away in symbolic queries while maintaining concrete values in statistical queries.

## Initial locations

Each template must have exactly one initial location. The initial location is marked by a double circle.

## Urgent locations

Urgent locations freeze time; _i.e._ time is not allowed to pass when a process is in an urgent location.

Semantically, urgent locations are equivalent to:

*   adding an extra clock, say `x`, that is reset on every incomming edge, and
*   adding an invariant `x <= 0` to the location.

## Committed locations

Like urgent locations, committed locations also freeze time.
Furthermore, if any process is in a committed location, the next transition must involve an edge from one of the committed locations.

Committed locations are useful for creating atomic sequences and for encoding synchronization between more than two components.
Notice that if several processes are in a committed location at the same time, then they will interleave.


> "The Impressive Power of Stopwatches" by Frank Cassez and Kim G. Larsen. In: "Concurrency Theory. CONCUR 2000", editor Catuscia Palamidessi. Lecture Notes in Computer Science, vol 1877. Springer, Berlin, Heidelberg. [doi:10.1007/3-540-44618-4_12](https://doi.org/10.1007/3-540-44618-4_12)

> "UPPAAL SMC tutorial" by Alexandre David, Kim G. Larsen, Axel Legay, Marius Mikučionis and Danny Bøgsted Poulsen. In: "International Journal on Software Tools for Technology Transfer" 17, 397–415 (2015). [doi:10.1007/s10009-014-0361-y](https://doi.org/10.1007/s10009-014-0361-y)
