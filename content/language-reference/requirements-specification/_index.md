---
title: Requirements Specification
weight: 20
---

In this help section we give a BNF-grammar for the requirement specification language used in the verifier of UPPAAL.

``` EBNF
Prop ::= 
        'A[]' Expression 
      | 'E<>' Expression 
      | 'E[]' Expression 
      | 'A<>' Expression 
      | Expression --> Expression  

      | 'sup' ':' List
      | 'sup' '{' Expression '}' ':' List  

      | 'inf' ':' List
      | 'inf' '{' Expression '}' ':' List  

      | Probability
      | ProbUntil
      | Probability ( '<=' | '>=' ) PROB
      | Probability ( '<=' | '>=' ) Probability
      | Estimate  

List ::= Expression | Expression ',' List  

Probability ::= 'Pr[' ( Clock | '#' ) '<=' CONST ']' '(' ('<>'|'[]') Expression ')'  

ProbUntil   ::= 'Pr[' ( Clock | '#' ) '<=' CONST ']' '(' Expression 'U' Expression ')'  

Estimate ::= 'E[' ( Clock | '#' ) '<=' CONST ';' CONST ']' '(' ('min:' | 'max:') Expression ')'
```

<dl>

<dt><tt>CONST</tt></dt>

<dd>is a non-negative integer constant.</dd>

<dt><tt>PROB</tt></dt>

<dd>is a floating point number from an interval [0;1] denoting probability.</dd>

<dt><tt>'#'</tt></dt>

<dd>means a number of simulation steps -- discrete transitions -- in the run.</dd>

<dt><tt>'min:'</tt></dt>

<dd>means the minimum value over a run of the proceeding expression.</dd>

<dt><tt>'max:'</tt></dt>

<dd>means the maximum value over a run of the proceeding expression.</dd>

</dl>

All expressions are state predicates and must be side effect free. It is possible to test whether a certain process is in a given location using expressions on the form <tt>process.location</tt>. For <tt>sup</tt> properties, expression may not contain clock constraints and must evaluate to either an integer or a clock.

**See also:** [Semantics of the Requirement Specification Language](semantics/)

## Examples

*   <tt>A[] 1<2</tt>  
    invariantly 1<2.
*   <tt>E<> p1.cs and p2.cs</tt>  
    true if the system can reach a state where both process <tt>p1</tt> and p2 are in their locations <tt>cs</tt>.
*   <tt>A[] p1.cs imply not p2.cs</tt>  
    invariantly process <tt>p1</tt> in location <tt>cs</tt> implies that process <tt>p2</tt> is **not** in location <tt>cs</tt>.
*   <tt>A[] not deadlock</tt>  
    invariantly the process is not deadlocked.
*   <tt>sup: list</tt>  
    the property is always true and returns the suprema of the expressions (maximal values in case of integers, upper bounds, strict or not, for clocks).
*   <tt>sup{expression}: list</tt>  
    The expressions in the list are evaluated only on the states that satisfy the the expression (a state predicate) that acts like an observation.
*   The <tt>inf</tt> formula are similar to <tt>sup</tt> but for infima. A state predicate should be used when a clock infimum is asked otherwise the trivial result is >= 0.