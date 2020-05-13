---
title: Locations
weight: 10
---


Locations of a timed automaton are graphically represented as circles. If a timed automaton is considered as a directed graph, then locations represent the vertices of this graph. Locations are connected by [edges](Edges.html).

## Names

Locations can have an optional name. Besides serving as an identifier allowing you to refer to the location from the [requirement specification language](/language-reference/requirements-specification/), named locations are useful when documenting the model. The name must be a valid [identifier](/language-reference/expressions/identifiers/) and location names share the name space with variables, types, templates, etc.

## Invariants

Locations are labelled with invariants. Invariants are expressions and thus follow the abstract syntax of [expressions](/language-reference/expressions/). However, the type checker restricts the set of possible expressions allowed in invariants.

An invariant must be a conjunction of simple conditions on clocks, differences between clocks, and boolean expressions not involving clocks. The bound must be given by an integer expression. Furthermore lower bounds on clocks are disallowed. It is important to understand that invariants influence the behaviour of the system -- they are distinctly different from specifying safety properties in the [requirements specification language](/language-reference/requirements-specification/). States which violate the invariants are undefined; by definition, such states do not exist. This influences the interpretation of urgent channels and broadcast channels. Please see the section on [synchronisations](/language-reference/system-description/templates/edges/#synchronisations) for a detailed discussion of this topic.

In addition, stop-watches are supported and they are declared with invariants. Clock rate expressions are specified and they are part of the conjunction in the invariant. Furthermore, the <tt>forall</tt> construct is accepted in invariants to ease use of arrays.

Statistical model checker supports any integer expression as a clock rate which allows modeling costs.

<a name="rate">

## Rate of Exponential

</a>

The rate of exponential is a ratio expression which specifies the rate of exponential probability distribution. The rate expression can be a simple integer expression or two integer expressions separated by a colon like <tt>r:q</tt> where the rate is determined as ratio <sup>r</sup>/<sub>q</sub>.

The rate of exponential is used in a [statistical model checking](/gui-reference/verifier/verifying/). If the location does not have an invariant over time, then it is assumed that the probability of leaving the location is distributed according to the exponential distribution: Pr(leaving after t)=1−e<sup>−λt</sup>, where e=2.718281828…, t is time and λ is the fixed rate. Probability density of the exponential distribution is λe<sup>−λt</sup> and thus intuitively λ means the probability density of leaving at time zero, i.e. as soon as some edge is enabled. The smaller the rate is specified, the longer the delay is preferred.

The generation of exact delay relies on pseudo random number generator and on 32-bit architectures the longest possible delay is rather limited: <sup>ln(2<sup>31</sup>)</sup>/<sub>λ</sub> ≈ <sup>21.49</sup>/<sub>λ</sub>.

### Examples

The following are valid invariants. Here <tt>x</tt> and <tt>y</tt> are clocks and <tt>i</tt> is an integer array.

*   <tt>x <= 2</tt>  
    <tt>x</tt> is less than or equal to 2.
*   <tt>x < y</tt>  
    <tt>x</tt> is (strictly) less than <tt>y</tt>.
*   <tt>(i[0]+1) != (i[1]*10)</tt>
*   <tt>forall(i:int[0,2]) x[i] <= 3</tt>  
    The clocks <tt>x[0], x[1],</tt> and <tt>x[2]</tt> of the clock array are less or equal to 3.
*   <tt>forall(i:int[0,2]) y[i]' == b[i]</tt>  
    The clock rates <tt>y[0]', y[1]',</tt> and <tt>y[2]'</tt> are set to, respectively, <tt>b[0], b[1],</tt> and <tt>b[2]</tt>. Note that the only valid values are 0 and 1\. Setting the rate to 0 effectively stops a clock (makes it a stop-watch). In [statistical model checking](/gui-reference/verifier/verifying/) the rate is allowed to be any integer value (can be interpreted as continuous cost).

## Initial locations

Each template must have exactly one initial location. The initial location is marked by a double circle.

## Urgent locations

Urgent locations freeze time; _i.e._ time is not allowed to pass when a process is in an urgent location.

Semantically, urgent locations are equivalent to:

*   adding an extra clock, <tt>x</tt>, that is reset on every incomming edge, and
*   adding an invariant <tt>x <= 0</tt> to the location.

## Committed locations

Like urgent locations, committed locations freeze time. Furthermore, if any process is in a committed location, the next transition must involve an edge from one of the committed locations.

Committed locations are useful for creating atomic sequences and for encoding synchronization between more than two components. Notice that if several processes are in a committed location at the same time, then they will interleave.