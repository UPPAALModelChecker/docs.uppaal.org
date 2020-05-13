---
title: Expressions
weight: 30
---

Most of the expression syntax of UPPAAL coincides with that of C, C++ and Java. E.g. assignments are done using the '=' operator (the older ':=' still works, but '=' is preferred). Notice that assignments are them self expressions.

The syntax of expressions is defined by the grammar for <tt>Expression</tt>.

<pre>
Expression ::= [ID]
            |  NAT
            |  Expression '[' Expression ']'
            |  Expression '''
            |  '(' Expression ')'
            |  Expression '++' | '++' Expression
            |  Expression '--' | '--' Expression
            |  Expression Assign Expression
            |  Unary Expression
            |  Expression Binary Expression
            |  Expression '?' Expression ':' Expression
            |  Expression '.' ID
	    |  Expression '(' Arguments ')'
	    |  'forall' '(' ID ':' Type ')' Expression
	    |  'exists' '(' ID ':' Type ')' Expression
	    |  'sum' '(' ID ':' Type ')' Expression
            |  'deadlock' | 'true' | 'false'

Arguments  ::= [ Expression ( ',' Expression )* ]

Assign     ::= '=' | ':=' | '+=' | '-=' | '*=' | '/=' | '%='
            | '|=' | '&=' | '^=' | '<<=' | '>>='
Unary      ::= '+' | '-' | '!' | 'not'
Binary     ::= '<' | '<=' | '==' | '!=' | '>=' | '>'
            |  '+' | '-' | '*' | '/' | '%' | '&'
            |  '|' | '^' | '<<' | '>>' | '&&' | '||'
            |  '<?' | '>?' | 'or' | 'and' | 'imply'
</pre>

Like in C++, assignment, preincrement and predecrement expressions evaluate to references to the first operand. The inline-if operator does in some cases (_e.g._ when both the true and false operands evaluate to compatible references) also evaluate to a reference, _i.e._, it is possible to use an inline-if on the left hand side of an assignment.

The use of the <tt>deadlock</tt> keyword is restricted to the [requirement specification language](/language-reference/requirements-specification/).

## Boolean Values

Boolean values are type compatible with integers. An integer value of 0 (zero) is evaluated to false and any other integer value is evaluated to true. The boolean value <tt>true</tt> evaluates to the integer value 1 and the boolean value <tt>false</tt> evaluates to the integer value 0\. **Notice:** A comparison like <tt>5 == true</tt> evaluates to false, since <tt>true</tt> evaluates to the integer value 1\. This is consistent with C++.

## Precedence

UPPAAL operators have the following associativity and precedence, listed from the highest to lowest. Operators borrowed from C keep the same precedence relationship with each other.

<table>

<tbody>

<tr>

<td>left</td>

<td>() [] .</td>

</tr>

<tr>

<td>right</td>

<td>! not ++ -- unary -</td>

</tr>

<tr>

<td>left</td>

<td>* / %</td>

</tr>

<tr>

<td>left</td>

<td>- +</td>

</tr>

<tr>

<td>left</td>

<td><< >></td>

</tr>

<tr>

<td>left</td>

<td><? >?</td>

</tr>

<tr>

<td>left</td>

<td>< <= >= ></td>

</tr>

<tr>

<td>left</td>

<td>== !=</td>

</tr>

<tr>

<td>left</td>

<td>&</td>

</tr>

<tr>

<td>left</td>

<td>^</td>

</tr>

<tr>

<td>left</td>

<td>|</td>

</tr>

<tr>

<td>left</td>

<td>&& and</td>

</tr>

<tr>

<td>left</td>

<td>|| or imply</td>

</tr>

<tr>

<td>right</td>

<td>?:</td>

</tr>

<tr>

<td>right</td>

<td>= := += -= *= /= %= &= |= <<= >>= ^=</td>

</tr>

<tr>

<td>left</td>

<td>forall exists sum</td>

</tr>

</tbody>

</table>

## Operators

Anybody familiar with the operators in C, C++, Java or Perl should immediately feel comfortable with the operators in UPPAAL. Here we summarise the meaning of each operator.

<table>

<tbody>

<tr>

<td>()</td>

<td>Parenthesis alter the evaluation order</td>

</tr>

<tr>

<td>[]</td>

<td>Array lookup</td>

</tr>

<tr>

<td>.</td>

<td>Infix lookup operator to access process or structure type scope</td>

</tr>

<tr>

<td>!</td>

<td>Logical negation</td>

</tr>

<tr>

<td>++</td>

<td>Increment (can be used as both prefix and postfix operator)</td>

</tr>

<tr>

<td>--</td>

<td>Decrement (can be used as both prefix and --> --postfix operator)</td>

</tr>

<tr>

<td>-</td>

<td>Integer subtraction (can also be used as unary negation)</td>

</tr>

<tr>

<td>+</td>

<td>Integer addition</td>

</tr>

<tr>

<td>*</td>

<td>Integer multiplication</td>

</tr>

<tr>

<td>/</td>

<td>Integer division</td>

</tr>

<tr>

<td>%</td>

<td>Modulo</td>

</tr>

<tr>

<td><<</td>

<td>Left bitshift</td>

</tr>

<tr>

<td>>></td>

<td>Right bitshift</td>

</tr>

<tr>

<td><?</td>

<td>Minimum</td>

</tr>

<tr>

<td>>?</td>

<td>Maximum</td>

</tr>

<tr>

<td><</td>

<td>Less than</td>

</tr>

<tr>

<td><=</td>

<td>Less than or equal to</td>

</tr>

<tr>

<td>==</td>

<td>Equality operator</td>

</tr>

<tr>

<td>!=</td>

<td>Inequality operator</td>

</tr>

<tr>

<td>>=</td>

<td>Greater than or equal to</td>

</tr>

<tr>

<td>></td>

<td>Greater than</td>

</tr>

<tr>

<td>&</td>

<td>Bitwise and</td>

</tr>

<tr>

<td>^</td>

<td>Bitwise xor</td>

</tr>

<tr>

<td>|</td>

<td>Bitwise or</td>

</tr>

<tr>

<td>&&</td>

<td>Logical and</td>

</tr>

<tr>

<td>||</td>

<td>Logical or</td>

</tr>

<tr>

<td>?:</td>

<td>If-then-else operator</td>

</tr>

<tr>

<td>not</td>

<td>Logical negation</td>

</tr>

<tr>

<td>and</td>

<td>Logical and</td>

</tr>

<tr>

<td>or</td>

<td>Logical or</td>

</tr>

<tr>

<td>imply</td>

<td>Logical implication</td>

</tr>

<tr>

<td>forall</td>

<td>Forall quantifier</td>

</tr>

<tr>

<td>exists</td>

<td>Exists quantifier</td>

</tr>

<tr>

<td>sum</td>

<td>Sum expression</td>

</tr>

</tbody>

</table>

Notice that the keywords <tt>not</tt>, <tt>and</tt> and <tt>or</tt> behave the same as the <tt>!</tt>, <tt>&&</tt>, and <tt>||</tt> operators, except that the former have lower precedence.

A few binary operators can be syntactically combined with assignment to produce a compact assignment expression:

<table>

<tbody>

<tr>

<th>Operator</th>

<th>Assignment</th>

<th>Example</th>

<th>Meaning</th>

</tr>

<tr>

<td>+</td>

<td>+=</td>

<td>x += y</td>

<td>x = x + y</td>

</tr>

<tr>

<td>-</td>

<td>-=</td>

<td>x -= y</td>

<td>x = x - y</td>

</tr>

<tr>

<td>*</td>

<td>*=</td>

<td>x *= y</td>

<td>x = x * y</td>

</tr>

<tr>

<td>/</td>

<td>/=</td>

<td>x /= y</td>

<td>x = x / y</td>

</tr>

<tr>

<td>%</td>

<td>%=</td>

<td>x %= y</td>

<td>x = x % y</td>

</tr>

<tr>

<td>&</td>

<td>&=</td>

<td>x &= y</td>

<td>x = x & y</td>

</tr>

<tr>

<td>^</td>

<td>^=</td>

<td>x ^= y</td>

<td>x = x ^ y</td>

</tr>

<tr>

<td>|</td>

<td>|=</td>

<td>x |= y</td>

<td>x = x | y</td>

</tr>

<tr>

<td><<</td>

<td><<=</td>

<td>x <<= y</td>

<td>x = x << y</td>

</tr>

<tr>

<td>>></td>

<td>>>=</td>

<td>x >>= y</td>

<td>x = x >> y</td>

</tr>

</tbody>

</table>

## Expressions Involving Clocks

When involving clocks, the actual expression syntax is restricted by the type checker. Expressions involving clocks are divided into three categories: _Invariants_, _guards_, and _constraints_:

*   An invariant is a conjunction of upper bounds on clocks and differences between clocks, where the bound is given by an integer expression, and clock rates.
*   A guard is a conjunction of bounds (both upper and lower) on clocks and differences between clocks, where the bound is given by an integer expression.
*   A constraint is any boolean combination (involving negation, conjunction, disjunction and implication) of bounds on clocks and differences between clocks, where the bound is given by an integer expression.

In addition, any of the three expressions can contain expressions (including disjunctions) over integers, as long as invariants and guards are still conjunctions at the top-level. The full constraint language is only allowed in the requirement specification language.

## Out of Range Errors and Invalid Evaluations

An evaluation of an expression is _invalid_ if out of range errors occur during evalution. This happens in the following situations:

*   Division by zero.
*   Shift operation with negative count.
*   Out of range assignment.
*   Out of range array index.
*   Assignment of a negative value to a clock.
*   Function calls with out of range arguments.
*   Function calls with out of range return values.

In case an invalid evaluation occurs during the computation of a successor, _i.e._, in the evaluation of a guard, synchronisation, assignment, or invariant, then the verification is aborted.

## Quantifiers

An expression <tt>forall (ID : Type) Expr</tt> evaluates to true if <tt>Expr</tt> evaluates to true for all values <tt>ID</tt> of the type <tt>Type</tt>. An expression <tt>exists (ID : Type) Expr</tt> evaluates to true if <tt>Expr</tt> evaluates to true for some value <tt>ID</tt> of the type <tt>Type</tt>. In both cases, the scope of <tt>ID</tt> is the inner expression <tt>Expr</tt>, and <tt>Type</tt> must be a bounded integer or a scalar set.

### Example

The following function can be used to check if all elements of the boolean array <tt>a</tt> have the value <tt>true</tt>.

``` c
bool alltrue(bool a[5])
{
  return forall (i : int[0,4]) a[i];
}
```

## Sum

An expression <tt>sum (ID : Type) Expr</tt> evaluates to an integer and is equal to the sum of the expressions evaluated with <tt>ID</tt> ranging over the given type argument. Boolean or state predicates (in TCTL expressions only) are accepted but not clock constraints. The expressions must be side-effect free. The type must be a bounded integer or a scalar set.

## Floating Point Type Support

Statistical model checking (SMC) supports double precision floating point type <tt>double</tt>. The clock variables also have floating point values in SMC. Symbolic and statistical model checking can be applied on the same model provided that <tt>double</tt> and <tt>hybrid clock</tt> type variables do not influencing the model logic, i.e. they cannot be used in guard and invariant constraints (but can be used in ODE expressions).

The following is the list of builtin floating point functions (mostly imported from C math library, hence the C math manual can be consulted for more details):

*   <tt>int abs(int)</tt> — absolute value of integer argument.
*   <tt>double fabs(double)</tt> — absolute value of double argument.
*   <tt>double fmod(double x, double y)</tt> — remainder of the division opration _x/y_.
*   <tt>double fma(double x, double y, double z)</tt> — computes _x*y+z_ as if to infinite precision.
*   <tt>double fmax(double x, double y)</tt> — the larger of the two arguments.
*   <tt>double fmin(double x, double y)</tt> — the smaller of the two arguments.
*   <tt>double exp(double x)</tt> — Euler's number raised to the given power: _e<sup>x</sup>_.
*   <tt>double exp2(double x)</tt> — 2 raised to the given power: _2<sup>x</sup>_.
*   <tt>double expm1(double x)</tt> — Euler's number raised to the given power minus 1: _e<sup>x</sup>-1_.
*   <tt>double ln(double x)</tt> — logarithm to the base of Euler's number: _log<sub>e</sub>(x)_.
*   <tt>double log(double x)</tt> — logarithm to the base of 10 _log<sub>10</sub>(x)_ (this is different from C library, kept for backward compatibility reasons).
*   <tt>double log10(double x)</tt> — logarithm to the base of 10: _log<sub>10</sub>(x)_.
*   <tt>double log2(double x)</tt> — logarithm to the base of 2: _log<sub>2</sub>(x)_.
*   <tt>double log1p(double x)</tt> — logarithm to the base of Euler's number with argument plus 1 _log<sub>e</sub>(1+x)_.
*   <tt>double pow(double x, int y)</tt> — raises to the specified integer power _x<sup>y</sup>_.
*   <tt>double pow(double x, double y)</tt> — raises to the specified floating point power _x<sup>y</sup>_.
*   <tt>double sqrt(double x)</tt> — computes square root.
*   <tt>double cbrt(double x)</tt> — computes cubic root.
*   <tt>double hypot(double x, double x)</tt> — computes hypotenuse of a right triangle: _sqrt(x<sup>2</sup>+y<sup>2</sup>)_.
*   <tt>double sin(double x)</tt> — sine of an angle in radians.
*   <tt>double cos(double x)</tt> — cosine of an angle in radians.
*   <tt>double tan(double x)</tt> — tangent of an angle in radians.
*   <tt>double asin(double x)</tt> — arc sine in radians.
*   <tt>double acos(double x)</tt> — arc cosine in radians.
*   <tt>double atan(double x)</tt> — arc tangent in radians.
*   <tt>double atan2(double y, double x)</tt> — arc tangent of the ratio _y/x_ in radians.
*   <tt>double sinh(double x)</tt> — hyperbolic sine: _(exp(x)-exp(-x))/2_.
*   <tt>double cosh(double x)</tt> — hyperbolic cosine: _(exp(x)+exp(-x))/2_.
*   <tt>double tanh(double x)</tt> — hyperbolic tangent: _(exp(x)-exp(-x))/(exp(x)+exp(-x))_.
*   <tt>double asinh(double x)</tt> — inverse hyperbolic sine.
*   <tt>double acosh(double x)</tt> — inverse hyperbolic cosine.
*   <tt>double atanh(double x)</tt> — inverse hyperbolic tangent.
*   <tt>double erf(double x)</tt> — Gauss error function (special non-elementary function of sigmoid).
*   <tt>double erfc(double x)</tt> — complement of a Gauss error function.
*   <tt>double tgamma(double x)</tt> — absolute value of the Gamma function (an extension of a factorial function _Γ(n)=(n-1)!_).
*   <tt>double lgamma(double x)</tt> — natural logarithm of the Gamma function.
*   <tt>double ceil(double x)</tt> — the ceiling function, the smallest integer value not less than _x_.
*   <tt>double floor(double x)</tt> — the floor function, the largest integer value not greater than _x_.
*   <tt>double trunc(double x)</tt> — nearest integer not greater in magnitude than _x_.
*   <tt>double round(double x)</tt> — nearest integer value to _x_ rounding halfway cases away from zero.
*   <tt>int fint(double x)</tt> — converts floating point value into integer (works like _trunc()_).
*   <tt>double ldexp(double x, int y)</tt> — multiplies by a specified power of two: _x*2<sup>y</sup>_.
*   <tt>int ilogb(double x)</tt> — extracts unbiased exponent: _trunc(log2(x+1))_.
*   <tt>double logb(double x)</tt> — extracts unbiased exponent: _trunc(log2(x+1))_.
*   <tt>double nextafter(double from, double to)</tt> — a next representable floating point value of _from_ in the direction of _to_.
*   <tt>double copysign(double x, double y)</tt> — floating point value with magnitude of _x_ and sign of _y_.
*   <tt>bool signbit(double x)</tt> — true if the argument _x_ is negative.<
*   <tt>double random(double max)</tt> — pseudo random number distributed uniformly over the interval _[0,max)_.
*   <tt>double normal(double mean, double stddev)</tt> — pseudo random number distributed according to normal (Gaussian) distribution for a given _mean_ and standard deviation _stddev_.

A few common constants and types can be declared as follows:

``` c
const int INT16_MIN     = -32768;
const int INT16_MAX     =  32767;
const int UINT16_MAX    =  65535;
const int INT32_MIN     = -2147483648;
const int INT32_MAX     =  2147483647;
const int UINT32_MAX    =  4294967295;
typedef int[INT32_MIN, INT32_MAX] int32_t;
typedef int[0, UINT32_MAX]        uint32_t;
const double M_PI       = 3.14159265358979312;  // Pi
const double M_PI_2     = 1.57079632679489656;  // Pi/2
const double M_PI_4     = 0.785398163397448279; // Pi/4
const double M_E        = 2.71828182845904509;  // Euler's number e
const double M_LOG2E    = 1.44269504088896339;  // log_2(e)
const double M_LOG10E   = 0.434294481903251817; // log_10(e)
const double M_LN2      = 0.693147180559945286; // log_e(2)
const double M_LN10     = 2.3025850929940459;   // log_e(10)
const double M_1_PI     = 0.318309886183790691; // 1/Pi
const double M_2_PI     = 0.636619772367581382; // 2/Pi
const double M_2_SQRTPI = 1.12837916709551256;  // 2/sqrt(Pi)
const double M_SQRT2    = 1.41421356237309515;  // sqrt(2)
const double M_SQRT1_2  = 0.707106781186547573; // 1/sqrt(2)
```