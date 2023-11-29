---
title: Syntax of Strategy Queries
weight: 30
menuTitle: "Strategy Queries"
---

## Strategy Queries

Strategy queries allow store, load, reuse and refine the strategies by assigning names to them.

``` EBNF
AssignQuery ::=
	    'strategy' StrategyName '=' AssignableQuery

AssignableQuery ::=
        ControlQuery
	  | LearningQuery
	  | 'loadStrategy' Features '(' Path ')'

NonAssignableQuery ::=
        SymbolicQuery
	  | SMCQuery
	  | 'saveStrategy' '(' Path ',' StrategyName ')'
```

<tt>StrategyName</tt>
: indicates the name of a strategy.

<tt>Path</tt>
: is a double-quoted (using `"`) character sequence (string) denoting a file path on the same computer as the used engine (`server` or `verifyta`).<br>
Note that the backslash (`\`) character in (Windows) paths needs to be either escaped with another backslash or replaced with the forwardslash (`/`), i.e. `\` should be replaced with either `\\` or `/`.

See [rail road diagram of AssignableQuery in Query overview](/grammar/#Query).

### Examples

`strategy Safe = A[] safe`
: computes a safety/permissive strategy over the timed game model and stores it under the name `Safe`.

`A[] good under Safe`
: checks that the predicate `good` is always satisfied when the player/controller sticks to actions permitted by `Safe` strategy.

`E<> goal under Safe`
: checks that the `goal` state predicate is eventually satisfied when the player/controller uses `Safe` strategy.

`strategy SafeCheap = minE(cost)[<=10] {i,j} -> {d,f} : <> t>=10 under Safe`
: refines `Safe` strategy into `SafeCheap` by minimizing the expected value of `cost` expression.

`saveStrategy("folder/file.json", Safe)`
: writes `Safe` strategy to the file with path `folder/file.json`.

`strategy Safe = loadStrategy{i,j}->{d,f}("folder/file.json")`
: reads the strategy from the file with path `folder/file.json` and stores it under the name `Safe`.
