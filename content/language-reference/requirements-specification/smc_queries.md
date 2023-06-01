---
title: Semantics of the Statistical Queries
weight: 30
menuTitle: "Statistical Queries"
---

UPPAAL can estimate the probability of expression values statistically. There are four types of statistical properties: quantitative, qualitative, comparison and probable value estimation.

See [rail road diagram of the entire SMCQuery syntax](/grammar/#SMCQuery).

![Rail road diagram of SMC query syntax](/grammar/diagram/SMCQuery.svg)

## Simulation

```EBNF
'simulate'  '[' SMCBounds ']' '{' List '}' [ ':' [ SATRUNS ':' ] Expression ]
```

The simulation query collects the valuation of the specified list of expressions over the time, cost or action-transitions of the simulated run. The simulation runs can be filtered by a state expression after the colon (<tt>':'</tt>) and the number of satisfying runs can be limited by positive integer using <tt>SMCBounds</tt> and <tt>SATRUNS</tt>. If the filtering expression is provided then the result also includes a probability confidence interval similar to Probability Estimation below.

## Probability Estimation (Quantitative Model Checking)

```EBNF
'Pr[' SMCBounds '](' ('<>' | '[]') Expression ')'
```

Quantitative query estimates the probability of a path expression being true given that the predicate in probability brackets is true. Intuitively the model exploration is bounded by an expression in the brackets: it can be limited by setting the bound on absolute model time, a clock value, or the number of steps (discrete transitions).

The result is an estimated probability confidence interval (CI), where the level of significance (probability that CI does not include the actual probability) is controlled by &alpha; and the width is controlled by &epsilon; in the [statistical parameters](/gui-reference/menu-bar/options/#statparam). In addition the  and a number of histograms over the values of the variable specified in the probability brackets. Note that histograms omit runs that do not satisfy the property.

The number of runs can be specified by the optional <tt>RUNS</tt> argument in the <tt>SMCBounds</tt>. If the argument is absent, then the number of runs is determined by a sequential CI estimation algorithm.

**See also:** [CI Estimation](../ci_estimation/)

## Hypothesis Testing (Qualitative Model Checking)

```EBNF
'Pr[' SMCBounds '](' ('<>' | '[]') Expression ')' ('<='|'>=') ProbNumber
```

Hypothesis testing checks whether the probability of a property is less or greater than specified bound. The query is more efficient than probability estimation as it is one sided and requires fewer simulations to attain the same level of significance.

## Probability Comparison

```EBNF
'Pr[' SMCBounds '](' ('<>' | '[]') Expression ')' **'>='** 'Pr[' ( Variable | '#' ) '<=' CONST '](' ('<>' | '[]') Expression ')'
```

Compares two probabilities indirectly without estimating them.

## Value Estimation

```EBNF
'E[' SMCBounds ']' '(' ('min:'|'max:' Expression ')'
```

Estimates the value of an expression by running a given number of simulations.

## Full Weighted MITL

```EBNF
MITLQuery = 'Pr' MITLExpression
MITLExpression =
               BExpr
            |  (MITLExpression && MITLExpression)
            |  (MITLExpression || MITLExpression)
            |  (MITLExpression 'U' '[' NAT ',' NAT ']' MITLExpression)
            |  (MITLExpression 'R' '[' NAT ',' NAT ']' MITLExpression)
            |  ('X' MITLExpression)
            |  ('<>' '[' NAT ',' NAT ']' MITLExpression)
            |  ('[]' '[' NAT ',' NAT ']' MITLExpression);
```

`BExpr`
: describes a Boolean expression over clocks, variables, and locations.

See [rail road diagram of entire MITLExpression syntax](/grammar/#MITLExpression):
![Rail road diagram of MITLExpression](/grammar/diagram/MITLExpression.svg)

The exact evaluation of the probability that a run satisfies a given weighted MITL formula.

## Examples

`Pr[<=100] (<> Train.Cross)`
: estimates the probability of the process `Train` reaching the location `Cross` within `100` model time units. The tool will produce a number of histograms over model time, like probability density distribution of `Train.Cross` becoming true over model time, thus allowing to inspect what the most likely moment in time is when the train arrives at crossing.

`Pr[cost<=1000] (<> Plane.Landing)`
: estimates the probability of the process `Plane` reaching the location `Landing` within `1000` cost units where clock variable `cost` has various rates in different locations. The tool will produce a number of histograms over the `cost` values, like a probability density distribution of `Plane.Landing` becoming true over cost, thus allowing to inspect what the most likely cost is when the plane lands.
