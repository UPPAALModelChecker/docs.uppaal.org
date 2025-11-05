---
title: Syntax of Controller Synthesis
weight: 15
menuTitle: "Controller Synthesis"
---

## Controller Synthesis Queries

Controller synthesis queries are decided using symbolic techniques over Timed Game (TIGA) automata, where the discrete actions are either controllable (controller's actions, solid edges) or uncontrollable (environment actions, dashed edges). The result is either a strategy solving the game objective or that the strategy does not exist.

``` EBNF
ControlQuery ::=
        ControlSpecifier Goal Subjection
      | CollaborativeControlSpecifier Goal Subjection
      | PartialControlSpecifier Goal Subjection
      | TimeEfficientGameSpecifier Goal
      | ApproximateControlSpecifier     // In section below
      | TatlExpression                  // In section below

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
      | 'A[' NotLoseExpression 'U' WinExpression ']'
      | 'A[' NotLoseExpression 'W' WinExpression ']'
      | 'A[]' NotLoseExpression

WinExpression ::= Expression

NotLoseExpression ::= Expression

GameTimeLimitExpression ::= Expression

LocalGameTimeLimitExpression ::= Expression

Subjection ::=
	    // empty for no subjection
	  | under StrategyName

```

<tt>GameTimeLimitExpression</tt>
: describes a time limit within the game must be won. This expression is only evaluated once at the beginning, thus should not depend on the current state.

<tt>LocalGameTimeLimitExpression</tt>
: describes an additional time limit such that the game can be won within <tt>GameTimeLimitExpression - LocalGameTimeLimitExpression</tt> time units. This expression is evaluated in each state, and can therefore depend on state or clock constraints. Must be side-effect free.

See [rail road diagram for the entire ControlQuery syntax](/grammar/#ControlQuery).

### Examples

`control: E<> goal`
: compute a strategy where `goal` state predicate is eventually true no matter what the oponent/environment chooses to do. The resulting strategy is *deterministic* in a sense that for a given state the strategy proposes one action for the player/controller (while the oponent/environment may still choose from multiple actions).

`control: A[] safe`
: compute a strategy where `safe` state predicate is always true no matter what the opponent/environment chooses to do. The strategy is *permissive* in a sense that for a given state the strategy may propose multiple actions for the player/controller. Such permissive strategy can be thought of as a union of all strategies satisfying the predicate, therefore it does not have any notion of progress and may include infinite loops.

`A[ safe U goal ]`
: computes a safety strategy but only up until the `goal` is reached.

`A[ safe W goal ]`
: (weakly until the `goal`) either a safety strategy is found or a safety strategy holds until the goal is reached.

See also [Strategy Queries](#strategy-queries) below on how to store and query the properties of the computed strategies.



### Approximate-control queries

{{% notice info %}}
The query is available in the UPPAAL COSHY version only.
{{% /notice %}}

Synthesize a strategy to enforce a desired invariant, using approximation techniques. The strategy is a user-defined partition of hyper-rectangular "cells" of equal size. For each cell, the strategy gives a set of safe edges to take.

```EBNF
ApproximateControlSpecifier ::=
        'acontrol : A[] ' DesiredInvariantExpression Partition

DesiredInvariantExpression ::= Expression

Partition ::=
    '{' Interval (',' Interval)* '}'

Interval ::=
      Identifier '[' Integer ',' Integer ']'            // (1)
    | Identifier '[' Double ',' Double ']' ':' Integer  // (2)
    | Identifier '.location'                            // (3)

```

The partition should include all state variables. Excluding state-variables may produce an invalid strategy, but can be done for e.g. cost variables that have no impact on safety.
Integer variables must be included as a bounded interval (1).

Double and clock variables must be bounded and indicate the number of discrete buckets the interval will be split into (2).
For example, for `clock x`, the interval `x[0.1, 0.2]:4` discretizes `x` into [0.1, 0.125), [0.125, 0.15), [0.15, 0.175) and [0.175, 0.2).

The location of processes must also be included (3). For example, `WaterTank.location`. Since the number of locations is discrete and bounded, nothing else needs to be specified.

#### Example

```
strategy shield = acontrol: A[] water_level < 10 && water_level > 0 { WaterTank.location, water_level[-1, 11]:24 }
```

Declares a strategy called `shield` to enforce the desired invaraint `water_level < 10 && water_level > 0`. The system has two, state variables. First, the `WaterTank` template has 5 locations, so `WaterTank.location` has 5 possible values. The second variable, `water_level[-1, 11]:24` is a double which gets split up into 24 intervals, with the corresponding size of 0.5. So the partition will contain `5·24 = 120` cells.


### Timed Alternating-Time Temporal Logic (TATL)

{{% notice info %}}
TATL queries are available in the UPPAAL TATL version only.
{{% /notice %}}

{{% notice info %}}
Due to some yet-to-be resolved parsing conflicts, TATL sub-expressions are wrapped in parenthesis if they themselves are also valid TATL expressions.
{{% /notice %}}

```EBNF
TatlExpression ::=
      Identifier '@' TatlExpressionOrExpression                             // (A)
    | TatlCoalition TatlPathProp
    ;

TatlCoalition ::=
      '<<' PlayerColorList '>>'                                             // (B1)
    | '[[' PlayerColorList ']]'                                             // (B2)
    ;

TatlPathProp ::=
      '[' TatlExpressionOrExpression 'U' TatlExpressionOrExpression ']'     // (C1)
    | '<>' TatlExpressionOrExpression                                       // (C2)
    | '[]' TatlExpressionOrExpression                                       // (C3)
    | 'X' TatlExpressionOrExpression                                        // (C4)
    ;

TatlExpressionOrExpression ::=
      '(' TatlExpression ')'
    | '(' TatlExpression ')' BoolOrKWAnd TatlExpressionOrExpression
    | '(' TatlExpression ')' BoolOrKWOr TatlExpressionOrExpression
    | '!' '(' TatlExpression ')'
    | Expression
    ;

PlayerColorList ::=
      /* empty */
    | PlayerColor
    | PlayerColorList ',' PlayerColor
    ;

PlayerColor ::=
      'black' | 'lightgray' | 'darkgray' | 'red' | 'green' | 'blue' | 'yellow' | 'cyan' | 'magenta' | 'orange' | 'pink' ;
```

Alternating-Time Temporal (ATL) logic is an extension of computation-tree logic (CTL), where the traditional for-all- and exists path quantifiers have been replaced with outcome quantifiers, quantifying over the possible outcome paths resulting from a coalition of players working together. The timed extension comes from the addition of the freeze operator.

- **(A) The freeze operator.** The left-hand side must be a globally defined clock that is not used in any automata (undefined behavior otherwise). `z @ RHS` is satisfied if the right-hand side is satisfied after the clock `z` is reset in the current state.
- **(B) Outcome quantifiers.**
  - `<< S >> rho` (B1) is satisfied if there *exist* strategies for the players `S` such that *all* outcome paths satisfies path property `rho`.
  - `[[ S ]] rho` (B2) is satisfied if there *exists* an outcome path satisfying `rho` for *all* strategies the players `S`.
  - Empty clauses: `<< >>` is equivalent to `A`, and `[[ ]]` is equivalent to `E`.
- **(C) Path Properties.** Your typical CTL temporal operators. Note that `X` is the next *location* operator.

#### Players

TATL queries are defined over timed *multi-player* games. A TATL query considers each edge color a different player (it does not matter if an edge is marked uncontrollable).
There are 11 different edge colors available in the UPPAAL GUI and they are referred to using their natural language name, i.e. `red`, `green`, `blue`, etc.

The semantics are similar to that of a standard 2-player game. The player `red` may activate enabled red edges at any time, and must do it in a timed-locked state, if any is enabled.
If two players activate an edge in the same instant, it is non-deterministic which activation happens.
If a synchronization involves more than one player, it is consider "uncontrollable", unless they are all working together.

#### Examples

`<< green >> [] safe`
: satisfied if there exists a strategy for `green` such that only `safe` states are visited (despite the actions of other players).

`[[ red ]] [ safe U goal ]`
: satisfied if the system *can* stay in `safe` states until eventually reaching a `goal` state despite the actions of player `red`.

`<<>> [] (<<red, blue>> <> goal)`
: satisfied if in all reachable states `red` and `blue` can cooperate such that `goal` is eventually reached.

`z @ (<< green, blue >> [ (safe && z <= 5) U goal ])`
: satisfied if `green` and `blue` can cooperate to reach a `goal` state within 5 time units and only visiting `safe` states along the way (`z` is a global clock).