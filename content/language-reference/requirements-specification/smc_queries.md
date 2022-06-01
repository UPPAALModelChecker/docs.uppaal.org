---
title: Semantics of the Statistical Queries
weight: 30
menuTitle: "Statistical Queries"
---

UPPAAL can estimate the probability of expression values statistically. There are four types of statistical properties: quantitative, qualitative, comparison and probable value estimation.

## Simulation

<tt>'simulate'  '[' SMCBounds ']' '{' List '}' [ ':' [ SATRUNS ':' ] Expression ]</tt>

<tt>BoundType ::= (  | Clock | '#' ) '<=' BOUND</tt>

The simulation query collects the valuation of the specified list of expressions over the time, cost or action-transitions of the simulated run. The simulation runs can be filtered by a state expression after the colon (<tt>':'</tt>) and the number of satisfying runs can be limited by positive integer using <tt>SMCBounds</tt> and <tt>SATRUNS</tt>. If the filtering expression is provided then the result also includes a probability confidence interval similar to Probability Estimation below.

## Probability Estimation (Quantitative Model Checking)

<tt>'Pr[' SMCBounds '](' ('<>' | '[]') Expression ')'</tt>

Quantitative query estimates the probability of a path expression being true given that the predicate in probability brackets is true. Intuitively the model exploration is bounded by an expression in the brackets: it can be limited by setting the bound on absolute model time, a clock value, or the number of steps (discrete transitions).

The result is an estimated probability confidence interval (CI), where the level of significance (probability that CI does not include the actual probability) is controlled by &alpha; and the width is controlled by &epsilon; in the [statistical parameters](/gui-reference/menu-bar/options/#statparam). In addition the  and a number of histograms over the values of the variable specified in the probability brackets. Note that histograms omit runs that do not satisfy the property.

The number of runs can be specified by the optional <tt>RUNS</tt> argument in the <tt>SMCBounds</tt>. If the argument is absent, then the number of runs is determined by a sequential CI estimation algorithm.

**See also:** [CI Estimation](../ci_estimation/)

## Hypothesis Testing (Qualitative Model Checking)

<tt>'Pr[' SMCBounds '](' ('<>' | '[]') Expression ')' **('<='|'>=') PROB**</tt>

Hypothesis testing checks whether the probability of a property is less or greater than specified bound. The query is more efficient than probability estimation as it is one sided and requires fewer simulations to attain the same level of significance.

## Probability Comparison

<tt>'Pr[' SMCBounds '](' ('<>' | '[]') Expression ')' **'>='** 'Pr[' ( Variable | '#' ) '<=' CONST '](' ('<>' | '[]') Expression ')'</tt>

Compares two probabilities indirectly without estimating them.

## Full Weighted MITL

<tt>'Pr' MITLExpression</tt>

The exact evaluation of the probability that a run satisfies a given weighted MITL formula. 

## Value Estimation

<tt>'E[' SMCBounds ']' '(' ('min:'|'max:' Expression ')'</tt>

Estimates the value of an expression by running a given number of simulations.

## Examples

<dl>

<dt><tt>Pr[<=100] (<> Train.Cross)</tt></dt>

<dd>estimates the probability of the process <tt>Train</tt> reaching the location <tt>Cross</tt> within 100 model time units. The tool will produce a number of histograms over model time, like probability density distribution of <tt>Train.Cross</tt> becoming true over model time, thus allowing to inspect what the most likely moment in time is when the train arrives at crossing.</dd>

<dt><tt>Pr[cost<=1000] (<> Plane.Landing)</tt></dt>

<dd>estimates the probability of the process <tt>Plane</tt> reaching the location <tt>Landing</tt> within 1000 cost units where clock variable <tt>cost</tt> has various rates in different locations. The tool will produce a number of histograms over the <tt>cost</tt> values, like a probability density distribution of <tt>Plane.Landing</tt> becoming true over cost, thus allowing to inspect what the most likely cost is when the plane lands.</dd>

</dl>
