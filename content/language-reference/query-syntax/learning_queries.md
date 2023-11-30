---
title: Syntax of Learning Queries
weight: 25
menuTitle: "Learning Queries"
---

## Learning Queries

``` EBNF
LearningQuery ::=
        ExpQuantifier '(' Expression ')' '[' BoundType ']' Features? ':' PathType Expression Subjection
	  | ExpQuantifier '[' BoundType ']' Features? ':' PathType Expression Subjection
	  | ExpPrQuantifier '[' BoundType ']' Features? ':' PathType Expression Subjection

ExpQuantifier ::= ( minE | maxE )

ExpPrQuantifier ::= ( minPr | maxPr )

Features ::= '{' List '}' '->' '{' List '}'

Subjection ::=
	    // empty for no subjection
	  | under StrategyName
```

`Features`
: describes a mapping (state space partition) from a partial state to a player action. The first list maps in the discrete space (values interpreted as distinct categories) and the second list maps in continuous space (assumes distance between values: similar values yield similar cost).

See [rail road diagram for the entire LearningQuery syntax](/grammar/#LearnQuery).

### Examples
`minE(cost) [<=10] : <> goal`
: learns a strategy that minimizes the expected `cost` expression within `10` time units or when `goal` predicate becomes true given that the **entire** system state is observable.

`maxE(gain) [<=10] : <> goal`
: learns a strategy that maximizes the expected `gain` expression withing `10` time units or when `goal` predicate becomes true given that the **entire** system state is observable.

The `goal` predicate is deprecated, for best results use a predicate which stops together with the simulation bound, like `t>=10`, where `t` is a clock that is never reset.

`minE(cost) [<=10] { i, j } -> { d, f } : <> goal`
: learns a strategy that minimizes the expected `cost` expression within `10` time units or when `goal` predicate becomes true. Where only the expressions `i`, `j`, `d` and `f` are observable.  The `{..} -> {..}` syntax controls what is observable. 
On one hand, by observing only a partial state learning times can be significantly reduced and the strategy structure simplified.
On the other hand, the resulting strategy is not guaranteed to converge to a optimal solution under partial observability.
There are two types of observable state expressions: *discrete* and *continuous*. 
The *discrete* are specified in the first bracket and the *continuous* in the second: `{discrete expressions} -> {continuous expressions}`. 
By default the entire state is considered during learning.
  
**Discrete** expressions are observed as they are, i.e the query `minE(cost) [<=10] { i, j } -> { } : <> goal` creates a strategy by only observing the values of `i` and `j`.

**Continuous** expressions are discretized using online partition refinement (see [Teaching Stratego to Play Ball](https://vbn.aau.dk/ws/files/378436068/main.pdf)).
The query `minE(cost) [<=10] { } -> { d, f } : <> goal` learns a strategy based on the discretized  expressions `d` and `f`.

Integers, clocks, floating points or even arbitrary expressions can be used in either type of observabilty. However we suggest caution when using floating point numbers or clocks in discrete observability.  
Process locations are ignored when specifying observability unless explicitly specified using `location` keyword.
For example `Cat.location` and `Mouse.location` refer to the locations of `Cat` and `Mouse` processes.

The learning queries are usually used together with strategy assignment and refinement explained in [Strategy Queries]({{<relref "/strategy_queries">}}).