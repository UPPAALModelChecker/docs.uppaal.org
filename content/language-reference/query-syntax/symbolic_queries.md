---
title: Syntax of Symbolic Queries
weight: 10
menuTitle: "Symbolic Queries"
---

## Symbolic Queries

Symbolic queries are performed using symbolic operations based on symbolic semantics of timed automata and correspond to a mathematically rigorous proof.


```EBNF
SymbolicQuery ::=
        'A[]' Expression Subjection
      | 'E<>' Expression Subjection
      | 'E[]' Expression Subjection
      | 'A<>' Expression Subjection
      | Expression --> Expression Subjection

      | 'sup' ':' List Subjection
      | 'sup' '{' Predicate '}' ':' List Subjection

      | 'inf' ':' List Subjection
      | 'inf' '{' Predicate '}' ':' List Subjection

      | 'bounds' ':' List Subjection
      | 'bounds' '{' Predicate '}' ':' List Subjection

List ::= Expression | Expression ',' List

Predicate ::= Expression

Subjection ::=
	    // empty for no subjection
	  | under StrategyName
```

<tt>Predicate</tt>
: an expression over a system state evaluating to either `true` or `false`. The predicate typically refers to a process location, but it can also use integers, logical operations and clock constraints.

<tt>Subjection</tt>
: indicates whether the query should be subjected to a strategy.

For `sup` and `bounds` queries, the list of expressions may not contain clock constraints and must evaluate to either an integer or a clock.

<!-- ![SymbolicQuery rail road diagram](/grammar/diagram/SymbolicQuery.svg) -->

See [rail road diagram for the entire SymbolicQuery syntax](/grammar/#SymbolicQuery).

**See also:** [Semantics of the Symbolic Queries]({{<ref "language-reference/query-semantics/symb_queries">}})

### Examples

`A[] 1<2`
: invariantly `1<2`.

`E<> p1.cs and p2.cs`
: true if the system can reach a state where both process `p1` and `p2` are in their locations `cs`.

`A[] p1.cs imply not p2.cs`
: invariantly process `p1` in location `cs` implies that process `p2` is **not** in location `cs`.

`A[] not deadlock`
: invariantly the process is not deadlocked.

`sup: Train(1).x, Train(2).x`
: computes the suprema of <tt>Train(1).x</tt> and <tt>Train(2).x</tt> expressions (maximal values in case of integers, upper bounds, strict or not, for clocks).

`sup{Train(1).Crossing}: Train(1).x`
: computes the supremum of <tt>Train(1).x</tt> but only when <tt>Train(1)</tt> is in <tt>Crossing</tt>.

`inf{Gate.Occ}: Gate.len`
: similarly to `sup`, `inf`query computes infimum of the given expression <tt>Gate.len</tt> while process <tt>Gate</tt> is in <tt>Occ</tt> location. When a clock infimum is needed, the state predicate should be used, otherwise the result is trivially `>=0`.

`bounds{Train(1).Crossing}: Train(1).x`
: computes all individual intervals of `Train(1).x` when `Train(1)` is in `Crossing`. Introduced in UPPAAL 5.1.0-beta5.
