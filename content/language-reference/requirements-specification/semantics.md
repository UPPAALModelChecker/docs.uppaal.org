---
title: Semantics of the Requirement Specification Language
weight: 10
menuTitle: "Semantics"
---

In the following we give a pseudo-formal semantics for the requirement specification language of UPPAAL. We assume the existence of a timed transition system (_S, s<sub>0</sub>,_ →) as defined in the [semantics of UPPAAL](/language-reference/system-description/semantics/l). In the following, <tt>p</tt> and <tt>q</tt> are [state properties](#state-properties) for which we define the following temporal properties:

### Possibly

The property <tt>E<> p</tt> evaluates to true for a timed transition system if and only if there is a sequence of alternating delay transitions and action transitions _s<sub>0</sub>_→_s<sub>1</sub>_→…→_s<sub>n</sub>_, where _s<sub>0</sub>_ is the initial state and _s<sub>n</sub>_ satisfies _p_.

### Invariantly

The property <tt>A[] p</tt> evaluates to true if (and only if) every reachable state satisfy <tt>p</tt>.

An _invariantly_ property <tt>A[] p</tt> can be expressed as the _possibly_ property <tt>not E<> not p</tt>.

### Potentially always

The property <tt>E[] p</tt> evaluates to true for a timed transition system if and only if there is a sequence of alternating delay or action transitions _s<sub>0</sub>_→_s<sub>1</sub>_→…→_s<sub>i</sub>_→… for which _p_ holds in all states _s<sub>i</sub>_ and which either:

*   is infinite, or
*   ends in a state (_L<sub>n</sub>, v<sub>n</sub>_) such that either
    *   for all _d_: (_L<sub>n</sub>, v<sub>n</sub>+d_) satisfies _p_ and _Inv_(_L<sub>n</sub>_), or
    *   there is no outgoing transition from (_L<sub>n</sub>, v<sub>n</sub>_)

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


## Statistical Properties



UPPAAL can estimate the probability of expression values statistically. There are four types of statistical properties: quantitative, qualitative, comparison and probable value estimation.

### Probability Estimation (Quantitative Model Checking)

<tt>'Pr[' ( Clock | '#' ) '<=' CONST '](' ('<>' | '[]') Expression ')'</tt>

Quantitative query estimates the probability of a path expression being true given that the predicate in probability brackets is true. Intuitively the model exploration is bounded by an expression in the brackets: it can be limited by setting the bound on a clock value, model time or the number of steps (discrete transitions).

The result is an estimated probability (with ε confidence interval specified in [statistical parameters](Menu_Bar/Options.html#statparam)) and a number of histograms over the values of the variable specified in the probability brackets. Note that histograms omit runs that do not satisfy the property.

### Hypothesis Testing (Qualitative Model Checking)

<tt>'Pr[' ( Clock | '#' ) '<=' CONST '](' ('<>' | '[]') Expression ')' **('<='|'>=') PROB**</tt>

Hypothesis testing checks whether the probability of a property is less or greater than specified bound. The query is more efficient than probability estimation as it is one sided and requires fewer simulations to attain the same level of significance.

### Probability Comparison

<tt>'Pr[' ( Variable | '#' ) '<=' CONST '](' ('<>' | '[]') Expression ')' **('<='|'>=')** 'Pr[' ( Variable | '#' ) '<=' CONST '](' ('<>' | '[]') Expression ')'</tt>

Compares two probabilities indirectly without estimating them.

### Value Estimation

<tt>'E[' ( Clock | '#' ) '<=' CONST ';' CONST ']' '(' ('min:'|'max:' Expression ')'</tt>

Estimates the value of an expression by running a given number of simulations.

### Examples

<dl>

<dt><tt>Pr[<=100] (<> Train.Cross)</tt></dt>

<dd>estimates the probability of the process <tt>Train</tt> reaching the location <tt>Cross</tt> within 100 model time units. The tool will produce a number of histograms over model time, like probability density distribution of <tt>Train.Cross</tt> becoming true over model time, thus allowing to inspect what the most likely moment in time is when the train arrives at crossing.</dd>

<dt><tt>Pr[cost<=1000] (<> Plane.Landing)</tt></dt>

<dd>estimates the probability of the process <tt>Plane</tt> reaching the location <tt>Landing</tt> within 1000 cost units where clock variable <tt>cost</tt> has various rates in different locations. The tool will produce a number of histograms over the <tt>cost</tt> values, like a probability density distribution of <tt>Plane.Landing</tt> becoming true over cost, thus allowing to inspect what the most likely cost is when the plane lands.</dd>

</dl>

## Property Equivalences

The UPPAAL requirement specification language supports five types of properties, which can be reduced to two types as illustrated by the following table.

<center>

<table border="1">

<tbody>

<tr>

<th>Name</th>

<th>Property</th>

<th>Equivalent to</th>

</tr>

<tr>

<td>Possibly</td>

<td><tt>E<> p</tt></td>

<td></td>

</tr>

<tr>

<td>Invariantly</td>

<td><tt>A[] p</tt></td>

<td><tt>not E<> not p</tt></td>

</tr>

<tr>

<td>Potentially always</td>

<td><tt>E[] p</tt></td>

<td></td>

</tr>

<tr>

<td>Eventually</td>

<td><tt>A<> p</tt></td>

<td><tt>not E[] not p</tt></td>

</tr>

<tr>

<td>Leads to</td>

<td><tt>p --> q</tt></td>

<td><tt>A[] (p imply A<> q)</tt></td>

</tr>

</tbody>

</table>

</center>