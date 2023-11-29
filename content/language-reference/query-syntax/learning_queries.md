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
: learns a strategy by minimizing the expected `cost` value within `10` time units or when `goal` predicate becomes true given that the **entire** system state is observable.

`maxE(gain) [<=10] : <> goal`
: learns a strategy by minimizing the expected `gain` value withing `10` time units or when `goal` predicate becomes true given that the **entire** system state is observable.

`minE(cost) [<=10] { i, j } -> { d, f } : <> goal`
: learns a strategy by minimizing the expected `cost` value within `10` time units or when `goal` predicate becomes true given `i`, `j`, `d` and `f` observable state expressions (can be variables or arbitrary expressions). Values of `i` and `j` are interpreted as distinct categories and values of `d` and `f` as continuous. Note that both integers and floating-point type expressions can be in either list (depends on their interpretation).<br>
The `goal` predicate is deprecated, for best results use a predicate which stops together with the simulation bound, like `t>=10`, where `t` is a clock that is never reset.

The learning queries are usually used together with strategy assignment and refinement explained in [Strategy Queries]({{<relref "/strategy_queries">}}).