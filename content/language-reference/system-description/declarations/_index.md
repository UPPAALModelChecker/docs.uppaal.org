
---
title: Declarations
weight: 10
---

Declarations are either global or local (to a template) and can contain declarations of clocks, bounded integers, channels (although local channels are useless), arrays, records, and types. The syntax is described by the grammar for <tt>Declarations</tt>:

``` EBNF
Declarations  ::= (VariableDecl | TypeDecl | [Function] | [ChanPriority])*
VariableDecl  ::= [Type] VariableID (',' VariableID)* ';'
VariableID    ::= ID [ArrayDecl]* [ '=' Initialiser ]
Initialiser   ::= [Expression]
               |  '{' Initialiser (',' Initialiser)* '}'
TypeDecls     ::= 'typedef' Type ID ArrayDecl* (',' ID ArrayDecl*)* ';'
```

The global declarations may also contain at most one [channel priority](/language-reference/system-description/priorities/) declaration.

## Examples

`const int a = 1;`
: constant `a` with value `1` of type integer.

`bool b[8], c[4];`
: two boolean arrays `b` and `c`, with `8` and `4` elements respectively.

`int[0,100] a=5;`
: an integer variable with the range `[0, 100]` initialised to `5`.

`int a[2][3] = { { 1, 2, 3 }, { 4, 5, 6} };`
: a multidimensional integer array with default range and an initialiser.

`clock x, y;`
: two clock variables `x` and `y`.

`chan d;`
: a channel variable.

`urgent chan e;`
: an urgent channel variable which forces the transition to be taken as soon as it is enabled.

`struct { int a; bool b; } s1 = { 2, true };`
: an instantiation of the structure from above where the members `a` and `b` are set to `2` and `true`.

```c
meta int swap;
int a;
int b;
```
**Update:** `swap = a; a = b; b = swap;`
: a `meta` variable `swap` is used to swap the contents of two integers `a` and `b`. The value of a `meta` variable is stored outside the state space (hence saves some state memory), but its value is valid only during one transition (e.g. transfering value between synchronizing processes).

{{% notice note %}}
Currently struct can't contain members of type `double` or `clock`.
{{% /notice %}}

## Type Declarations

The `typedef` keyword is used to name types.

### Example

The following declares a record type `S` containing an integer `a` and a boolean `b` members:

```
typedef struct
{
    int a;
    bool b;
} S;
```
