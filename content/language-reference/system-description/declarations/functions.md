---
title: Functions
weight: 20
---

Functions can be declared alongside other declarations. The syntax for functions is defined by the grammar for <tt>Function</tt>:

<pre>
Function        ::= [Type](TypeDeclarations.html) [ID](Identifiers.html) '(' [Parameters](Parameters.html) ')' Block 
Block	        ::= '{' [Declarations](Declarations.html) Statement* '}'
Statement       ::= Block
                 | ';'
                 |  [Expression](Expressions.html) ';'
	         |  ForLoop
		 |  Iteration
	         |  WhileLoop 
	         |  DoWhileLoop 
	         |  IfStatement 
		 |  ReturnStatement
ForLoop	        ::= 'for' '(' [Expression](Expressions.html) ';' [Expression](Expressions.html) ';' [Expression](Expressions.html) ')' Statement 
Iteration	::= 'for' '(' [ID](Identifiers.html) ':' [Type](TypeDeclarations.html) ')' Statement
WhileLoop       ::= 'while' '(' [Expression](Expressions.html) ')' Statement
DoWhile         ::= 'do' Statement 'while' '(' [Expression](Expressions.html) ')' ';'
IfStatment      ::= 'if' '(' [Expression](Expressions.html) ')' Statement [ 'else' Statement ]
ReturnStatement ::= 'return' [ [Expression](Expressions.html) ] ';'
</pre>

## Iterators

The keyword <tt>for</tt> has two uses: One is a C/C++/Java like for-loop, and the other is a Java like iterator. The latter is primarily used to iterate over arrays indexed by scalars.

A statement <tt>for (ID : Type) Statement</tt> will execute <tt>Statement</tt> once for each value <tt>ID</tt> of the type <tt>Type</tt>. The scope of <tt>ID</tt> is the inner expression <tt>Expr</tt>, and <tt>Type</tt> must be a bounded integer or a scalar set.

## Examples

### add

The following function returns the sum of two integers. The arguments are call by value.

<pre> 
int add(int a, int b)
{
    return a + b; 
}
</pre>

### swap

The following procedure swaps the values of two call-by-reference integer parameters.

```
void swap(int &a, int &b) 
{
  int c = a;
  a = b;
  b = c;
}
```

### initialize

The following procedure initializes an array such that each element contains its index in the array. Notice that the an array parameter is a call-by-value parameter unless an ampersand is used in the declaration. This is different from C++ syntax, where the parameter could be considered an array of references to integer.

```
void initialize(int& a[10])
{
  for (i : int[0,9]) 
  {
    a[i] = i;
  }
}
```