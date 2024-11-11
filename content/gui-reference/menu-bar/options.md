---
title: Options Menu
weight: 50
---

The options menu contains settings to control the behavior of the model-checker.

## Search Order

This option influences the order in which the state space is explored.

Breadth first
: Search the state space in breadth first search order. This is typically the most efficient option when the complete state space must be searched. When generating shortest or fastest traces, this is likely the best setting.

Depth first
: Search the state space in depth first search order. If a counter example or witnessing trace is expected to exist, this setting is usually better than the breadth first setting. It is not recommended to use this search order when generating shortest or fastest traces.

Random depth first
: Search the state space in randomised depth first search order. If a counter example or witnessing trace is expected to exist, this is usually the best setting. Due to the randomisation, traces may vary from run to run. It is not recommended to use this search order when generating shortest or fastest traces.


## State Space Reduction

When searching the state space, UPPAAL does not necessarily have to store all states in memory in order to guarantee termination. This option influences how aggressively UPPAAL tries to avoid storing states. There is normally a tradeoff between space and speed.

None
: Store all states.

Conservative
: Avoid storing committed states.

Aggressive
: Avoid storing more than one state per cycle.


## State Space Representation

This option determines how the state space should be represented in the model checker.

Some representations are approximative in the sence that either a larger or smaller state space than the real one is generated. When an approximative representation is used, UPPAAL may conclude that a query is _maybe_ satisfied, i.e., UPPAAL cannot make a decisive conclusions given the representation selected.

Difference Bound Matrices (DBM)
: DBMs are often fast, but for models with many clocks they require a lot of memory.

Compact Data Structure
: A more compact, but slower representation than DBMs. In particular for models with many clocks, this setting will often significantly reduce memory consumption. Even for models with no or few clocks, this option enables other memory saving techniques at the expense of speed.

Under Approximation
: Uses bit-state hashing to represent the state space. This results in an under approximation, however the degree of approximation can be adjusted by adjusting the size of the hash table: Large hash tables result in a larger part of the state space being searched. The hash table size can be selected with the _hash table size_ option.

Over Approximation
: Uses convex-hull approximation of zones. This results in an over approximation of the state space. For models without clocks, this setting has no effect.

Note that if a model contains stopwatches (invariant expressions like `x'==0` where `x` is a clock), then the resulting analysis is overapproximate even if _DBM_ or _Compact Data Structure_ options are selected (DBM cannot represent additional constraints required by stopwatches). In such case, UPPAAL may also report that a reachability propery is _maybe_ satisfied, meaning that the found counter-example trace may be spurious (i.e. not realizable).

## Diagnostic Trace

This option controls if a counter-example or witnessing trace (if there is one) should be generated during verification. The trace is loaded into the simulator after verification. Enabling trace generation has two side effects:

*   Only one property at a time can be verified.
*   Symmetry reduction is disabled.

The possible settings for trace generation are:

None
: Do not generated any diagnostic trace.

Some
: Generate a diagnostic trace.

Shortest
: Generate a shortest trace, i.e. a trace with the smallest number of transitions.

Fastest
: Generate a fastest trace, i.e. a trace with the shortest accumulated time delay.


## Extrapolation

The range of clocks is unbounded, i.e., clocks can obtain arbitrarily large real values. To guarantee termination, UPPAAL uses an abstraction techniques called _extrapolation_. The extrapolated state space is finite. UPPAAL implements a number of extrapolation techniques that differ in the size of the extrapolated state space. Not all extrapolation techniques preserve all properties for all kinds of models. UPPAAL automatically selects the coarsets extrapolation, which still preserves the property being analysed.

Sometimes it may be of benefit to use a coarser (and faster) extrapolation that the one selected by UPPAAL. By doing so, the analysis will use an over-approximation of the state space. Listed from finest to coarsets, the choices are: None, Difference, Local, and Lower/Upper.

Automatic
: Selects the coarsest extrapolation preserving the property being analysed. If in doubt, use this setting.

None
: Do not use extrapolation. Termination is no longer guaranteed. Since performing the extrapolation is relatively expensive, this may be of use if you know that the symbolic state space is finite.

Difference
: Used whenever the model or the query contain difference constraints over clocks, e.g., `x - y < 3`.

Local
: Used whenever the query contains either the deadlock keyword or involves a liveness property (except if the model or the query contain difference constraints).

Lower/Upper
: Used whenever a reachability analysis is performed, except when the deadlock keyword is used or when the model or the query contain difference constraints.


## Hash table size

Adjusts the amount of memory used to represent the state space when using bit-state hashing. This option has no effect unless _under approximation_ is selected.

## Reuse

When selected, instructs the verifier to (whenever possible) reuse the generated portion of the state space when several properties of the same system are checked.

<a name="statparam">

## Statistical Parameters

</a>

Lower probabilistic deviation (-δ)
: Used in hypothesis testing (qualitative model-checking) to specify the lower bound of indifference region from the specified probability.

Upper probabilistic deviation (+δ)
: Used in hypothesis testing (qualitative model-checking) to specify the upper bound of indifference region from the specified probability.

Probability of false positives (α)
: Used in hypothesis testing (qualitative model-checking queries like `Pr[...](...) <= 0.5`) and probability estimation (quantitative model-checking queries like `Pr[...](...)`) to specify the [level of significance](https://en.wikipedia.org/wiki/Statistical_significance) (probability of [Type I error](https://en.wikipedia.org/wiki/Type_I_and_type_II_errors#Type_I_error)).

Probability of false negatives (β)
: Used in hypothesis testing (qualitative model-checking queries like `Pr[...](...) <= 0.5`) to specify the [level of significance](https://en.wikipedia.org/wiki/Statistical_significance) (probability of [Type II error](https://en.wikipedia.org/wiki/Type_I_and_type_II_errors#Type_II_error)).

Probability uncertainty (ε)
: Used in probability estimation (qualitative model-checking) to constrain the size of the [confidence interval](https://en.wikipedia.org/wiki/Confidence_interval) in a form of p &pm; ε (1-α CI).

Ratio lower bound (u<sub>0</sub>)
: Used in comparison of two probabilities.

Ratio upper bound (u<sub>1</sub>)
: Used in comparison of two probabilities.

Histogram bucket width
: Specifies the width of each column in the histogram. By default it is set to zero meaning that the width is determined by ratio of entire histogram width divided by a bucket count.

Histogram bucket count
: Specifies the number of columns in the histogram. By default it is set to zero meaning that the count is determined by taking a square root of a total number of samples and dividing by four.

Trace resolution
: compresses the expression trajectories for a specified screen resolution in dots-per-inch (DPI), by ommitting trajectory points which fall into the same screen pixel.

Discretization step for hybrid systems
: the (smallest) time step used to integrate dynamical equations. UPPAAL versions 4.1.3-4.1.26 except 4.1.20 use fixed time step Euler method. UPPAAL 5.0.0, UPPAAL 4.1.20, and Stratego versions use adaptive Runge-Kutta integrator based on precision.

Local integration error bound
: Numerical error bound in Runge-Kutta integration method, the computed dynamical signal should not differ from the true value by this error bound.

Integration error bound pr. time-unit:
: Accumulated numerical error bound in Runge-Kutta integratio method per time-unit, the computed dynamical signal should not diverge by more than specifified bound per model time-unit.

## More Information

The compact data structure and the options for state space reduction are described in the following paper:

> _Efficient Verification of Real-Time Systems: Compact Data Structure and State Space Reduction_, Kim G. Larsen, Fredrik Larsson, Paul Pettersson and Wang Yi. In Proceedings of the 18th IEEE Real-Time Systems Symposium, pages 14-24\. San Francisco, California, USA, 3-5 December 1997.
