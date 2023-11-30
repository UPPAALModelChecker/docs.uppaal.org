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
