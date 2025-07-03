---
title: CORA
---

## Language Guide

UPPAAL CORA is based on the newest internal development version of UPPAAL. On one hand this means that it contains all the new and exciting features of the next version of UPPAAL, but on the other it also means that it contains many new and untried features, that might change before the final release of UPPAAL. This page describes the new language features compared to the UPPAAL 4.0 series.

### Cost Annotation

In LPTA, an implicit continuous monotonic variable called _cost_ is defined. The rate at which this variable grows can be specified in the location invariant as:

```c
cost' == INTEXPR
```

where `INTEXPR` is an integer expression. If specified in multible locations, the actual cost rate is the sum of the cost rate specified in the current location of each process. The cost can be incremented on edges using the increment operator `+=`.

Here is an example of the aircraft landing problem: [xta](airland1R2.xta), [q](airland1R2.q).

### Remaining Cost Estimation

The performance of UPPAAL CORA can be improved dramatically by annotating the model with an admissible estimate of the remaining cost to reach the goal condition. Admissible means that the estimate is not bigger than the actual cost of reaching the goal, i.e., the estimate provides a lower bound on the remaining cost. The estimate is specified by declaring a meta integer variable named `remaining`. Specifying a good value for remaining is crucial for good performance.

In previous versions of UPPAAL, `remaining` had to be a lower bound on the remaining cost from the state and all its delay successors, but this is no longer required. Now `remaining` must simply be a lower bound on the remaining cost. When computing a successor, UPPAAL automatically adjusts the value of remaining. Thus even when you do not recompute remaining, it will still be a lower bound of the remaining cost. You will probably be able to come up with a better lower bound on the remaining cost, so you should try compute a remaining cost yourself on each edge transition.


## Command Line Options

Below we describe the new options supported by the command line interface of UPPAAL (verifyta). Most of these options are also available from the options menu in the graphical frontend.

### Guiding

A number of different search orders are supported. These can be selected with the `-o` option:

`-o0`
: Breadth first.

`-o1`
: Depth first.

`-o2`
: Random depth first.

`-o3`
: Smallest heur first.

`-o4`
: Best first.

`-o5`
: Best depth first.

The first two are well known from previous releases of UPPAAL. Random depth first search is similar to depth first search, but it randomises the order in which the successors of a state are searched. Smallest heur first requires the presence of an _integer_ variable named `heur` in the model. The state with the smallest value of this variable is always explored next. In most cases, this variable should be a meta variable. _Best first_ and _best depth first_ are used for optimal reachability, see the next topic.

### Optimal Reachability

UPPAAL CORA has support for finding optimal schedules. Optimality is defined in terms of a cost variable, see the [Language Guide](language.html#upta) for details. The optimal trace can be found by using the `-t3` option. With this option, UPPAAL CORA keeps searching until a trace to a goal state with the smallest value for the `cost` variable has been found. Alternatively you can use the `-E` option to find the optimal cost without generating the trace.

UPPAAL CORA automatically enables the `-o4` option (best first) when using the `-t3` option. This can be changed by manually using a different `-o` option _after_ the `-t3` option. In the best first search order, the state with the smallest value of the `cost` variable is searched next. An alternative is to use best depth first. This search order performs a depth first search, but always searches the state with the lowest cost first. If a remaining cost estimate annotation is provided, the interpretation of the best first and best depth first is changed to search the state with the smallest sum of the `cost` variable and the `remaining` variable next.

### Examples

The jugs example has been updated to the new syntax. You can download it here: [jugs2.ta](jugs2.ta), [jugs2.q](jugs2.q). You can find the optimal solution like this:

`verifyta -E jugs2.ta jugs2.q`


## Limitations
UPPAAL CORA has a number of limitations. These limitations are not fundamental, but are a result of using new internal data structures with a currently limited feature set. Over time, these limitations will be resolved.

  * No extrapolation, hence termination is not guaranteed unless you guarantee that either:
    * The system is acyclic.
    * All clocks are bound by invariants.
  * Simple reachability only:
    * No liveness check
    * No deadlock check
  * Limited use of guiding:
    * Support for (cost + remaining) sorting is implemented (best first search)
    * Support for heuristic variable is implemented, but the expression cannot refer to the cost variable.
