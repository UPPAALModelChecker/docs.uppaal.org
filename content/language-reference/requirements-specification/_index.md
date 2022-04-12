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
	  | under Name   
```

For <tt>sup</tt> properties, expression may not contain clock constraints and must evaluate to either an integer or a clock.

**See also:** [Semantics of the Symbolic Queries](symb_queries/)

### Examples

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

<dl>
<dt><tt>Subjection</tt></dt>
<dd>indicates whether the query should be subjected to a strategy.</dd>
</dl>

## Controller Synthesis Queries

Controller synthesis queries are decided using symbolic techniques over Timed Game (TIGA) automata, where the discrete actions are either controllable (controller's actions, solid edges) or uncontrollable (environment actions, dashed edges). The result is either a strategy solving the game objective or that the strategy does not exist.

``` EBNF
TIGAQuery ::=
        'control:' Goal Subjection
      | 'E<>' 'control:' Goal Subjection
      | '{' someting '}' 'control:' Goal Subjection
      | TimeEfficientGameQuery Goal

TimeEfficientGameQuery ::=
        'control_t*' '(' u ',' g '):'
      | 'control_t*' '(' u '):'
      | 'control_t*:'
      
Goal ::=  
         'A<>' WinExpression
      | 'A[' NotLooseExpression 'U' WinExpression ']'
      | 'A[' NotLooseExpression 'W' WinExpression ']'
      | 'A[' NotLooseExpression ']'

WinExpression ::= Expression

NotLooseExpression ::= Expression

u ::= Expression

g ::= Expression

Subjection ::= 
	    // empty for no subjection
	  | under Name   
```

<dl>
<dt><tt>u</tt></dt>
<dd>describes a time limit within the game must be won.</dd>

<dt><tt>g</tt></dt>
<dd>describes an additional time limit such that the game can be won within <tt>u</tt> - <tt>g</tt> time units.</dd>

<dt><tt>Subjection</tt></dt>
<dd>indicates whether the query should be subjected to a strategy.</dd>
</dl>


## Statistical Queries

Statistical queries are decided using concrete semantics of stochastic hybrid automata over a number of bounded concrete simulation runs and correspond to empirical measurements of the system performance. The results are of statistical estimate nature and may vary across different executions based on uncertainties specified in the statistical parameters.

``` EBNF
SMCQuery ::=
	    Simulate Subjection
      | Probability Subjection
      | ProbUntil Subjection
      | Probability ( '<=' | '>=' ) PROB Subjection
      | Probability ( '<=' | '>=' ) Probability Subjection
      | Estimate Subjection

Simulate ::= 'simulate' SIMRUNS '[' SMCBounds ']' '{' List '}' [ : Expression [ ':' SATRUNS ]]

Probability ::= 
        'Pr' Expression
      | 'Pr[' SMCBounds ']' '(' PathType Expression ')'

ProbUntil   ::= 'Pr[' SMCBounds ']' '(' Expression 'U' Expression ')'

Estimate ::= 'E[' SMCBounds ']' '(' ('min:' | 'max:') Expression ')'

SMCBounds ::= BoundType [ ; RUNS ]

BoundType ::= (  | Clock | '#' ) '<=' BOUND

PathType ::= ( '<>' | '[]' )

Subjection ::= 
	    // empty for no subjection
	  | under Name   
```

<dl>
<dt><tt>BOUND</tt></dt>
<dd>is a non-negative integer constant denoting an upper bound over the absolute global time (when a variable is not specified), specific <tt>Clock</tt> (cost) variable or a number of action-transitions (<tt>#</tt>).</dd>

<dt><tt>RUNS</tt></dt>
<dd>is an optional positive integer constant denoting the maximum number of runs. If the number of runs is not specified, then it is decided based on statistical parameters and the particular estimation algorithm.</dd>

<dt><tt>SATRUNS</tt></dt>
<dd>is an optional positive integer constant denoting the maximum number of runs that satisfy the state expression.</dd>

<dt><tt>SATRUNS</tt></dt>
<dd>is a positive integer constant denoting the number of simulated runs.</dd>

<dt><tt>PROB</tt></dt>
<dd>is a floating point number from an interval [0;1] denoting a probability bound.</dd>

<dt><tt>'#'</tt></dt>
<dd>means a number of simulation steps -- discrete action-transitions -- in the run.</dd>

<dt><tt>'min:'</tt></dt>
<dd>means the minimum value over a run of the proceeding expression.</dd>

<dt><tt>'max:'</tt></dt>
<dd>means the maximum value over a run of the proceeding expression.</dd>

<dt><tt>Subjection</tt></dt>
<dd>indicates whether the query should be subjected to a strategy.</dd>
</dl>

All expressions are state predicates and must be side effect free. It is possible to test whether a certain process is in a given location using expressions on the form <tt>process.location</tt>.

**See also:** [Semantics of the SMC Queries](smc_queries/)


## Learning Queries

``` EBNF
LearningQuery ::=
        ExpQuantifier '(' Expression ')' '[' BoundType ']' Features ':' PathType Expression Subjection
	  | ExpQuantifier '[' BoundType ']' Features ':' PathType Expression Subjection
	  | ExpPrQuantifier '[' BoundType ']' Features ':' PathType Expression Subjection

ExpQuantifier ::= ( minE | maxE )

ExpPrQuantifier ::= ( minPr | maxPr )

Features ::= '{' List '}' '->' '{' List '}' 

Subjection ::= 
	    // empty for no subjection
	  | under Name   
```

<dl>
<dt><tt>Features</tt></dt>
<dd>describes a mapping from partial state to .</dd>

<dt><tt>Name</tt></dt>
<dd>indicates the name of a strategy, see also next section.</dd>

<dt><tt>Subjection</tt></dt>
<dd>indicates whether the query should be subjected to a strategy.</dd>
</dl>


## Strategy Queries

Strategy queries allow store, load, reuse and refine the strategies by assigning names to them.

``` EBNF
AssignQuery ::=
	    'strategy' Name '=' AssignableQuery

AssignableQuery ::=
        TIGAQuery
	  | LearningQuery Subjection
	  | 'loadStrategy' Features '(' Path ')'

NonAssignableQuery ::=
        SymbQuery
	  | SMCQuery
	  | 'saveStrategy' '(' Path ',' Name ')' 
```

<dl>
<dt><tt>Name</tt></dt>
<dd>indicates the name of a strategy.</dd>

<dt><tt>Path</tt></dt>
<dd>is a double-quoted character sequence (string) denoting a file system path.</dd>
</dl>
