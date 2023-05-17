---
title: Requirements Specification
weight: 20
---

This section describes a BNF-grammar for the requirement specification language used in the verifier of UPPAAL.

## Symbolic Queries

Symbolic queries are performed using symbolic operations based on symbolic semantics of timed automata and correspond to a mathematically rigorous proof.


``` EBNF
SymbQuery ::=
        'A[]' Expression Subjection
      | 'E<>' Expression Subjection
      | 'E[]' Expression Subjection
      | 'A<>' Expression Subjection
      | Expression --> Expression Subjection

      | 'sup' ':' List Subjection
      | 'sup' '{' Expression '}' ':' List Subjection

      | 'inf' ':' List Subjection
      | 'inf' '{' Expression '}' ':' List Subjection

List ::= Expression | Expression ',' List

Subjection ::=
	    // empty for no subjection
	  | under StrategyName
```

<tt>Subjection</tt>
: indicates whether the query should be subjected to a strategy.

For `sup` properties, expression may not contain clock constraints and must evaluate to either an integer or a clock.

**See also:** [Semantics of the Symbolic Queries](symb_queries/)

### Examples

`A[] 1<2`
: invariantly `1<2`.

`E<> p1.cs and p2.cs`
: true if the system can reach a state where both process `p1` and `p2` are in their locations `cs`.

`A[] p1.cs imply not p2.cs`
: invariantly process `p1` in location `cs` implies that process `p2` is **not** in location `cs`.

`A[] not deadlock`
: invariantly the process is not deadlocked.

`sup: list`
: the property is always true and returns the suprema of the expressions (maximal values in case of integers, upper bounds, strict or not, for clocks).

`sup{expression}: list`
: The expressions in the `list` are evaluated only on the states that satisfy the the expression (a state predicate) that acts like an observation.

The `inf` formula
: is similar to `sup` but for infima. A state predicate should be used when a clock infimum is asked otherwise the trivial result is &ge;0.


## Controller Synthesis Queries

Controller synthesis queries are decided using symbolic techniques over Timed Game (TIGA) automata, where the discrete actions are either controllable (controller's actions, solid edges) or uncontrollable (environment actions, dashed edges). The result is either a strategy solving the game objective or that the strategy does not exist.

``` EBNF
TIGAQuery ::=
        ControlSpecifier Goal Subjection
      | CollaborativeControlSpecifier Goal Subjection
      | PartialControlSpecifier Goal Subjection
      | TimeEfficientGameSpecifier Goal

ControlSpecifier ::=
        'control:'

CollaborativeControlSpecifier ::=
        'E<>' 'control:'

PartialControlSpecifier ::=
        '{' List '}' 'control:'

TimeEfficientGameQuery ::=
        'control_t*' '(' GameTimeLimitExpression ',' LocalGameTimeLimitExpression '):'
      | 'control_t*' '(' u '):'
      | 'control_t*:'

Goal ::=
        'A<>' WinExpression
      | 'A[' NotLooseExpression 'U' WinExpression ']'
      | 'A[' NotLooseExpression 'W' WinExpression ']'
      | 'A[]' NotLooseExpression

WinExpression ::= Expression

NotLooseExpression ::= Expression

GameTimeLimitExpression ::= Expression

LocalGameTimeLimitExpression ::= Expression

Subjection ::=
	    // empty for no subjection
	  | under StrategyName
```

<tt>GameTimeLimitExpression</tt>
: describes a time limit within the game must be won. This expression is only evaluated once at the beginning, thus should not depend on the current state.

<tt>LocalGameTimeLimitExpression</tt>
: describes an additional time limit such that the game can be won within <tt>GameTimeLimitExpression</tt> - <tt>LocalGameTimeLimitExpression</tt> time units. This expression is evaluated in each state, and can therefore depend on state or clock constraints. Must be side-effect free.

### Examples

`control: E<> goal`
: compute a strategy where `goal` state predicate is eventually true no matter what the oponent/environment chooses to do. The resulting strategy is *deterministic* in a sense that for a given state the strategy proposes one action for the player/controller (while the oponent/environment may still choose from multiple actions).

`control: A[] safe`
: compute a strategy where `safe` state predicate is always true no matter what the oponent/environment chooses to do. The strategy is *permissive* in a sense that for a given state the strategy may propose multiple actions for the player/controller. Such permissive strategy can be thought of as a union of all strategies satisfying the predicate, therefore it does not have any notion of progress and may include infinite loops.

See also [Strategy Queries](#strategy-queries) below on how to store and query the properties of the computed strategies.

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
: is a non-negative integer constant denoting an upper bound over the absolute global time (when a variable is not specified), specific <tt>Clock</tt> (cost) variable or a number of action-transitions (`#`).

<tt>RUNS</tt>
: is an optional positive integer constant denoting the maximum number of runs. If the number of runs is not specified, then it is decided based on [Statistical parameters](/gui-reference/menu-bar/options/#statparam) and the particular estimation algorithm.

<tt>SATRUNS</tt>
: is an optional positive integer constant denoting the maximum number of runs that satisfy the state expression.

<tt>PROB</tt>
: is a floating point number from interval <tt>[0; 1]</tt> denoting a probability bound.</dd>

<tt>'#'</tt>
: means a number of simulation steps -- discrete edge-transitions -- in the run.

<tt>'min:'</tt>
: means the minimum value over a run of the proceeding expression.

<tt>'max:'</tt>
: means the maximum value over a run of the proceeding expression.

All expressions are state predicates and must be side effect free. It is possible to test whether a certain process is in a given location using expressions on the form <tt>process.location</tt>.

**See also:** [Semantics of the SMC Queries](smc_queries/)

### Examples

`simulate [<=10] { x }`
: createss one stochastic simulation run of up to `10` time units in length and plot the values of `x` expression over time (after checking, right-click the query and choose a plot).

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

## Learning Queries

```EBNF
LearningQuery ::=
        ExpQuantifier '(' Expression ')' '[' BoundType ']' Features ':' PathType Expression Subjection
	  | ExpQuantifier '[' BoundType ']' Features ':' PathType Expression Subjection
	  | ExpPrQuantifier '[' BoundType ']' Features ':' PathType Expression Subjection

ExpQuantifier ::= ( minE | maxE )

ExpPrQuantifier ::= ( minPr | maxPr )

Features ::= '{' List '}' '->' '{' List '}'

Subjection ::=
	    // empty for no subjection
	  | under StrategyName
```

`Features`
: describes a mapping (state space partition) from a partial state to a player action. The first list maps in the discrete space and trhen the second list maps in continuous space.


### Examples
`minE(cost) [&lt;=10] { i, j } -> { d, f } : <> goal`
: learns a strategy by minimizing the expected `cost` value within `10` time units or when `goal` predicate becomes true given `i`, `j`, `d` and `f` observable state expressions. `i` and `j` are used for discrete partitioning and `d` and `f` are used in continuous partitioning. The `goal` predicate is deprecated, for best results use a predicate which stops together with the simulation bound, like `t>=10`, where `t` is a clock that is never reset.

The learning queries are usually used together with strategy assignment and refinement explained below.

## Strategy Queries

Strategy queries allow store, load, reuse and refine the strategies by assigning names to them.

``` EBNF
AssignQuery ::=
	    'strategy' StrategyName '=' AssignableQuery

AssignableQuery ::=
        TIGAQuery
	  | LearningQuery
	  | 'loadStrategy' Features '(' Path ')'

NonAssignableQuery ::=
        SymbQuery
	  | SMCQuery
	  | 'saveStrategy' '(' Path ',' StrategyName ')'
```

<tt>StrategyName</tt>
: indicates the name of a strategy.</dd>

<tt>Path</tt>
: is a double-quoted character sequence (string) denoting a file system path.

### Examples

`strategy Safe = A[] safe`
: computes a safety/permissive strategy over the timed game model and stores it under the name `Safe`.

`A[] good under Safe`
: checks that the predicate `good` is always satisfied when the player/controller sticks to actions permitted by `Safe` strategy.

`E<> goal under Safe`
: checks that the `goal` state predicate is eventually satisfied when the player/controller uses `Safe` strategy.

`strategy SafeCheap = minE(cost)[<=10] { i, j } -> { d, f } : <> t>=10 under Safe`
: refines `Safe` strategy into `SafeCheap` by minimizing estimated value of `cost` expression.

`saveStrategy("folder/file.json", Safe)`
: writes `Safe` strategy to the file with path `folder/file.json`.

`strategy Safe = loadStrategy{i,j}->{d,f}("folder/file.json")`
: reads the strategy from the file with path `folder/file.json` and stores it under the name `Safe`.
