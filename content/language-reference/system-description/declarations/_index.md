
---
title: Declarations
weight: 10
---

Declarations are either global or local (to a template) and can contain declarations of clocks, bounded integers, channels (although local channels are useless), arrays, records, and types. The syntax is described by the grammar for <tt>Declarations</tt>:

``` 
Declarations  ::= (VariableDecl | TypeDecl | [Function](Functions.html) | [ChanPriority](Priorities.html))*
VariableDecl  ::= [Type](TypeDeclarations.html) VariableID (',' VariableID)* ';'
VariableID    ::= ID [ArrayDecl](TypeDeclarations.html)* [ '=' Initialiser ]
Initialiser   ::= [Expression](Expressions.html)
               |  '{' Initialiser (',' Initialiser)* '}'
TypeDecls     ::= 'typedef' Type ID ArrayDecl* (',' ID ArrayDecl*)* ';'
```

The global declarations may also contain at most one [channel priority](Priorities.html#chan) declaration.

## Examples

*   <tt>const int a = 1;</tt>  
    constant <tt>a</tt> with value 1 of type integer.
*   <tt>bool b[8], c[4];</tt>  
    two boolean arrays <tt>b</tt> and c, with 8 and 4 elements respectively.
*   <tt>int[0,100] a=5;</tt>  
    an integer variable with the range [0, 100] initialised to 5.
*   <tt>int a[2][3] = { { 1, 2, 3 }, { 4, 5, 6} };</tt>  
    a multidimensional integer array with default range and an initialiser.
*   <tt>clock x, y;</tt>  
    two clocks <tt>x</tt> and <tt>y</tt>.
*   <tt>chan d;</tt>  
    a channel.
*   <tt>urgent chan e;</tt>  
    an urgent channel.
*   <pre>struct { int a; bool b; } s1 = { 2, true };</pre>
    an instantiation of the structure from above where the members <tt>a</tt> and <tt>b</tt> are set to <tt>2</tt> and <tt>true</tt>.
*   <tt>meta int swap;  
    int a;  
    int b;  
    assign swap = a; a = b; b = swap;  
    </tt>a meta variable is used to swap the contents of two integers.

## Type Declarations

The <tt>typedef</tt> keyword is used to name types.

### Example

The following declares a record type S containing an integer <tt>a</tt>, a boolean <tt>b</tt> and a clock <tt>c</tt>:

```
typedef struct 
{ 
  int a;   
  bool b;
  clock c;
} S;
```