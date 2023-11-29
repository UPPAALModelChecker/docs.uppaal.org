---
title: Syntax of Statistical Queries
weight: 20
menuTitle: "Statistical Queries"
---

## Statistical Queries

Statistical queries are decided using concrete semantics of stochastic hybrid automata over a number of bounded concrete simulation runs and correspond to empirical measurements of the system performance. The results are of statistical estimate nature and may vary across different executions based on uncertainties specified in [Statistical parameters](/gui-reference/menu-bar/options/#statparam).

```EBNF
SMCQuery ::=
	    Simulate Subjection
      | Probability Subjection
      | ProbUntil Subjection
      | Probability ( '<=' | '>=' ) PROB Subjection
      | Probability Subjection '>=' Probability Subjection
      | Estimate Subjection

Simulate ::= 'simulate'  '[' SMCBounds ']' '{' List '}' [ ':' [ SATRUNS ':' ] Expression ]

Probability ::=
        'Pr' MITLExpression
      | 'Pr[' SMCBounds ']' '(' PathType Expression ')'

ProbUntil   ::= 'Pr[' SMCBounds ']' '(' Expression 'U' Expression ')'

Estimate ::= 'E[' SMCBounds ']' '(' ('min:' | 'max:') Expression ')'

SMCBounds ::= BoundType [ ; RUNS ]

BoundType ::= (  | Clock | '#' ) '<=' BOUND

PathType ::= ( '<>' | '[]' )

Subjection ::=
	    // empty for no subjection
	  | under StrategyName
```

<tt>BOUND</tt>
: is a non-negative integer constant denoting an upper bound over the absolute global time (when a variable is not specified), specific <tt>Clock</tt> (cost) variable or a number of action-transitions (<tt>#</tt>).

<tt>RUNS</tt>
: is an optional positive integer constant denoting the maximum number of runs. If the number of runs is not specified, then it is decided based on [Statistical parameters](/gui-reference/menu-bar/options/#statparam) and the particular estimation algorithm.

<tt>SATRUNS</tt>
: is an optional positive integer constant denoting the maximum number of runs that satisfy the state expression.

<tt>PROB</tt>
: is a floating point number from interval <tt>[0; 1]</tt> denoting a probability bound.

<tt>'#'</tt>
: means a number of simulation steps -- discrete edge-transitions -- in the run.

<tt>'min:'</tt>
: means the minimum value over a run of the proceeding expression.

<tt>'max:'</tt>
: means the maximum value over a run of the proceeding expression.

All expressions are state predicates and must be side effect free. It is possible to test whether a certain process is in a given location using expressions on the form <tt>process.location</tt>.

See [rail road diagram for the entire SMCQuery syntax](/grammar/#SMCQuery).

**See also:** [Semantics of the SMC Queries]({{<ref "language-reference/query-semantics/smc_queries">}})

### Examples

`simulate [<=10] { x }`
: creates one stochastic simulation run of up to `10` time units in length and plot the values of `x` expression over time (after checking, right-click the query and choose a plot).

`simulate [c<=10] { x, y+z }`
: creates one simulation run of up to `10` cost units in terms of clock variable `c` and plot the values of `x` and `y+z` expressions over the cost `c`.

`simulate [#<=10] { x, y+z }`
: creates one simulation run of up to `10` edge-transitions and plot the values of `x` and `y+z` expressions over the discrete simulation steps (edge-transitions).

`simulate [<=10; 100] { x, y+z } : 2 : goal`
: selects up to `2` simulation runs from `100` simulations of up to `10` time units in length, which satisfy `goal` state predicate, and then plot the values of expressions `x` and `y+z` over time. The query will also estimate a probability confidense interval of the expression `goal` being true just like in `Pr` query. The confidence level is controlled by &alpha;-level of significance in the [Statistical parameters](/gui-reference/menu-bar/options/#statparam).

`Pr[<=10](<> good)`
: runs a number of stochastic simulations and estimates the probability of `good` eventually becoming true within `10` time units. The number of runs is decided based on the probability interval precision (&pm;&epsilon;) and confidence level (level of significance &alpha; in [Statistical parameters](/gui-reference/menu-bar/options/#statparam)), see [CI Estimation](ci_estimation) for details. The query also computes a probability distribution over time when the predicate `good` is satisfied (right-click the property and choose a plot).

`Pr[c<=10; 100]([] safe)`
: runs `100` stochastic simulations and estimates the probability of `safe` remaining true within `10` cost units in terms of clock `c`.

`Pr[<=10](<> good) >= 0.5`
: checks if the probability of reaching `good` within `10` time units is greater than `50%`. Such query uses Wald's algorithm to decide the probability inequality and requires fewer runs than probability estimation and explicit comparison. Uses -&delta;, +&delta;, &alpha; and &beta; [Statistical parameters](/gui-reference/menu-bar/options/#statparam).

`Pr[<=10](<> best) >= Pr[<=10](<> good)`
: checks if the probability of reaching `best` is greater than reaching `good` within `10` time units. Such query uses a sequential algorithm to decide the probability inequality and requires fewer runs than probability estimation and explicit comparison. Uses -&delta;, +&delta;, u0, u1, &alpha; and &beta; [Statistical parameters](/gui-reference/menu-bar/options/#statparam). The query also provides a probability comparison plot over time/cost (right-click the query and choose plot).

`E[<=10; 100](max: cost)`
: estimates the maximal value of `cost` expression over `10` time units of stochastic simulation. Uses `100` stochastic simulations and assumes that the value follows [Student's t-distribution](https://en.wikipedia.org/wiki/Student%27s_t-distribution) with <tt>1-&alpha;</tt> confidence level.

The plots can be super-imposed using the [Plot Composer](/gui-reference/menu-bar/tools) from the [Tools](/gui-reference/menu-bar/tools) menu.