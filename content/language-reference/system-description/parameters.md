---
title: Parameters
weight: 30
---

Templates and functions are parameterised. The syntax for parameters is defined by the grammar for <tt>Parameters</tt>:

``` EBNF
Parameters ::= [ Parameter (',' Parameter)* ]
Parameter  ::= [Type] [ '&' ] [ID] [ArrayDecl]*
```

In contrast to global and local declarations, the parameter list should not be terminated by a semicolon.

## Call by Reference and Call by Value

Parameters can be declared to have either call-by-value or call-by-reference semantics. The syntax is taken from C++, where the identifier of a call-by-reference parameter is prefixed with an ampersand in the parameter declaration. Call-by-value parameters are not prefixed with an ampersand.

Clocks and channels must always be reference parameters.

**Note:** Array parameters must be prefixed with an ampersand to be passed by reference, this does not follow the C semantics.

## Examples

*   <tt>P(clock &x, bool bit)</tt>  
    process template <tt>P</tt> has two parameters: the clock <tt>x</tt> and the boolean variable <tt>bit</tt>.
*   <tt>Q(clock &x, clock &y, int i1, int &i2, chan &a, chan &b)</tt>  
    process template <tt>Q</tt> has six parameters: two clocks, two integer variables (with default range), and two channels. All parameters except <tt>i1</tt> are reference parameters.