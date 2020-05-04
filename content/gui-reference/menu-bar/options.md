---
title: Options Menu
weight: 50
---

The options menu contains settings to control the behavior of the model-checker.

## Search Order

This option influences the order in which the state space is explored.

<dl>

<dt>Breadth first</dt>

<dd>Search the state space in breadth first search order. This is typically the most efficient option when the complete state space must be searched. When generating shortest or fastest traces, this is likely the best setting.</dd>

<dt>Depth first</dt>

<dd>Search the state space in depth first search order. If a counter example or witnessing trace is expected to exist, this setting is usually better than the breadth first setting. It is not recommended to use this search order when generating shortest or fastest traces.</dd>

<dt>Random depth first</dt>

<dd>Search the state space in randomised depth first search order. If a counter example or witnessing trace is expected to exist, this is usually the best setting. Due to the randomisation, traces may vary from run to run. It is not recommended to use this search order when generating shortest or fastest traces.</dd>

</dl>

## State Space Reduction

When searching the state space, UPPAAL does not necessarily have to store all states in memory in order to guarantee termination. This option influences how aggressively UPPAAL tries to avoid storing states. There is normally a tradeoff between space and speed.

<dl>

<dt>None</dt>

<dd>Store all states.</dd>

<dt>Conservative</dt>

<dd>Avoid storing committed states.</dd>

<dt>Aggressive</dt>

<dd>Avoid storing more than one state per cycle.</dd>

</dl>

## State Space Representation

This option determines how the state space should be represented in the model checker.

Some representations are approximative in the sence that either a larger or smaller state space than the real one is generated. When an approximative representation is used, UPPAAL may conclude that a query is _maybe_ satisfied, i.e., UPPAAL cannot make a decisive conclusions given the representation selected.

<dl>

<dt>Difference Bound Matrices (DBM)</dt>

<dd>DBMs are often fast, but for models with many clocks they require a lot of memory.</dd>

<dt>Compact Data Structure</dt>

<dd>A more compact, but slower representation than DBMs. In particular for models with many clocks, this setting will often significantly reduce memory consumption. Even for models with no or few clocks, this option enables other memory saving techniques at the expense of speed.</dd>

<dt>Under Approximation</dt>

<dd>Uses bit-state hashing to represent the state space. This results in an under approximation, however the degree of approximation can be adjusted by adjusting the size of the hash table: Large hash tables result in a larger part of the state space being searched. The hash table size can be selected with the _hash table size_ option.</dd>

<dt>Over Approximation</dt>

<dd>Uses convex-hull approximation of zones. This results in an over approximation of the state space. For models without clocks, this setting has no effect.</dd>

</dl>

## Diagnostic Trace

This option controls if a counter-example or witnessing trace (if there is one) should be generated during verification. The trace is loaded into the simulator after verification. Enabling trace generation has two side effects:

*   Only one property at a time can be verified.
*   Symmetry reduction is disabled.

The possible settings for trace generation are:

<dl>

<dt>None</dt>

<dd>Do not generated any diagnostic trace.</dd>

<dt>Some</dt>

<dd>Generate a diagnostic trace.</dd>

<dt>Shortest</dt>

<dd>Generate a shortest trace, i.e. a trace with the smallest number of transitions.</dd>

<dt>Fastest</dt>

<dd>Generate a fastest trace, i.e. a trace with the shortest accumulated time delay.</dd>

</dl>

## Extrapolation

The range of clocks is unbounded, i.e., clocks can obtain arbitrarily large real values. To guarantee termination, UPPAAL uses an abstraction techniques called _extrapolation_. The extrapolated state space is finite. UPPAAL implements a number of extrapolation techniques that differ in the size of the extrapolated state space. Not all extrapolation techniques preserve all properties for all kinds of models. UPPAAL automatically selects the coarsets extrapolation, which still preserves the property being analysed.

Sometimes it may be of benefit to use a coarser (and faster) extrapolation that the one selected by UPPAAL. By doing so, the analysis will use an over-approximation of the state space. Listed from finest to coarsets, the choices are: None, Difference, Local, and Lower/Upper.

<dl>

<dt>Automatic</dt>

<dd>Selects the coarsest extrapolation preserving the property being analysed. If in doubt, use this setting.</dd>

<dt>None</dt>

<dd>Do not use extrapolation. Termination is no longer guaranteed. Since performing the extrapolation is relatively expensive, this may be of use if you know that the symbolic state space is finite.</dd>

<dt>Difference</dt>

<dd>Used whenever the model or the query contain difference constraints over clocks, e.g., <tt>x - y < 3</tt>.</dd>

<dt>Local</dt>

<dd>Used whenever the query contains either the deadlock keyword or involves a liveness property (except if the model or the query contain difference constraints).</dd>

<dt>Lower/Upper</dt>

<dd>Used whenever a reachability analysis is performed, except when the deadlock keyword is used or when the model or the query contain difference constraints.</dd>

</dl>

## Hash table size

Adjusts the amount of memory used to represent the state space when using bit-state hashing. This option has no effect unless _under approximation_ is selected.

## Reuse

When selected, instructs the verifier to (whenever possible) reuse the generated portion of the state space when several properties of the same system are checked.

<a name="statparam">

## Statistical Parameters

</a>

<dl>

<dt>Lower probabilistic deviation (-δ)</dt>

<dd>Used in hypothesis testing (qualitative model-checking) to specify the lower bound of indifference region from the specified probability.</dd>

<dt>Upper probabilistic deviation (+δ)</dt>

<dd>Used in hypothesis testing (qualitative model-checking) to specify the upper bound of indifference region from the specified probability.</dd>

<dt>Probability of false negatives (α)</dt>

<dd>Used in hypothesis testing (qualitative model-checking) and probability estimation (quantitative model-checking) to specify the level of significance.</dd>

<dt>Probability of false positives (β)</dt>

<dd>Used in hypothesis testing (qualitative model-checking) to specify the level of significance.</dd>

<dt>Probability uncertainty (ε)</dt>

<dd>Used in probability estimation (qualitative model-checking) to constrain the probability interval.</dd>

<dt>Ratio lower bound (u<sub>0</sub>)</dt>

<dd>Used in comparison of two probabilities.</dd>

<dt>Ratio upper bound (u<sub>1</sub>)</dt>

<dd>Used in comparison of two probabilities.</dd>

<dt>Histogram bucket width</dt>

<dd>Specifies the width of each column in the histogram. By default it is set to zero meaning that the width is determined by ratio of entire histogram width divided by a bucket count.</dd>

<dt>Histogram bucket count</dt>

<dd>Specifies the number of columns in the histogram. By default it is set to zero meaning that the count is determined by taking a square root of a total number of samples and dividing by four.</dd>

</dl>

## More Information

The compact data structure and the options for state space reduction are described in the following paper:

> _Efficient Verification of Real-Time Systems: Compact Data Structure and State Space Reduction_, Kim G. Larsen, Fredrik Larsson, Paul Pettersson and Wang Yi. In Proceedings of the 18th IEEE Real-Time Systems Symposium, pages 14-24\. San Francisco, California, USA, 3-5 December 1997.