---
title: Expressions
weight: 30
---

Most of the expression syntax of UPPAAL coincides with that of C, C++ and Java. E.g. assignments are done using the '=' operator (the older ':=' still works, but '=' is preferred). Notice that assignments are them self expressions.

The syntax of expressions is defined by the grammar for `Expression`.

``` EBNF
Expression = [ID]
            |  NAT
            |  Expression '[' Expression ']'
            |  Expression "'"
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
            |  'deadlock' | 'true' | 'false';

Arguments  = [ Expression ( ',' Expression )* ];

Assign     = '=' | ':=' | '+=' | '-=' | '*=' | '/=' | '%='
            | '|=' | '&=' | '^=' | '<<=' | '>>=';
Unary      = '+' | '-' | '!' | 'not';
Binary     = '<' | '<=' | '==' | '!=' | '>=' | '>'
            |  '+' | '-' | '*' | '/' | '%' | '&'
            |  '|' | '^' | '<<' | '>>' | '&&' | '||'
            |  '<?' | '>?' | 'or' | 'and' | 'imply';
```

Like in C++, assignment, preincrement and predecrement expressions evaluate to references to the first operand. The inline-if operator does in some cases (_e.g._ when both the true and false operands evaluate to compatible references) also evaluate to a reference, _i.e._, it is possible to use an inline-if on the left hand side of an assignment.

The use of the `deadlock` keyword is restricted to the [requirement specification language](/language-reference/requirements-specification/).

## Boolean Values

Boolean values are type compatible with integers. An integer value of 0 (zero) is evaluated to false and any other integer value is evaluated to true. The boolean value `true` evaluates to the integer value 1 and the boolean value `false` evaluates to the integer value 0\. **Notice:** A comparison like `5 == true` evaluates to false, since `true` evaluates to the integer value 1\. This is consistent with C++.

## Precedence

UPPAAL operators have the following associativity and precedence, listed from the highest to lowest. Operators borrowed from C keep the same precedence relationship with each other.

| Associativity | Operator                                  |
|---------------|:------------------------------------------|
| left          | () [] .                                   |
| right         | ! not ++ -- unary -                       |
| left          | * / %                                     |
| left          | - +                                       |
| left          | &lt;&lt; &gt;&gt;                         |
| left          | <? >?                                     |
| left          | < <= >= >                                 |
| left          | == !=                                     |
| left          | &                                         |
| left          | ^                                         |
| left          | &#124;                                    |
| left          | && and                                    |
| left          | &#124;&#124; or imply                     |
| right         | ?:                                        |
| right         | = := += -= *= /= %= &= &#124;= <<= >>= ^= |
| left          | forall exists sum                         |

## Operators

Anybody familiar with the operators in C, C++, Java or Perl should immediately feel comfortable with the operators in UPPAAL. Here we summarise the meaning of each operator.

| Operator     | Description                                                       |
|--------------|-------------------------------------------------------------------|
| ()           | Parenthesis alter the evaluation order                            |
| []           | Array lookup                                                      |
| .            | Infix lookup operator to access process or structure type scope   |
| !            | Logical negation                                                  |
| ++           | Increment (can be used as both prefix and postfix operator)       |
| --           | Decrement (can be used as both prefix and --> --postfix operator) |
| -            | Integer subtraction (can also be used as unary negation)          |
| +            | Integer addition                                                  |
| *            | Integer multiplication                                            |
| /            | Integer division                                                  |
| %            | Modulo                                                            |
| &lt;&lt;     | Left bitshift                                                     |
| &gt;&gt;     | Right bitshift                                                    |
| <?           | Minimum                                                           |
| >?           | Maximum                                                           |
| <            | Less than                                                         |
| <=           | Less than or equal to                                             |
| ==           | Equality operator                                                 |
| !=           | Inequality operator                                               |
| >=           | Greater than or equal to                                          |
| >            | Greater than                                                      |
| &            | Bitwise and                                                       |
| ^            | Bitwise xor                                                       |
| &#124;       | Bitwise or                                                        |
| &&           | Logical and                                                       |
| &#124;&#124; | Logical or                                                        |
| ?:           | If-then-else operator                                             |
| not          | Logical negation                                                  |
| and          | Logical and                                                       |
| or           | Logical or                                                        |
| imply        | Logical implication                                               |
| forall       | Forall quantifier                                                 |
| exists       | Exists quantifier                                                 |
| sum          | Sum expression                                                    |



Notice that the keywords `not`, `and` and `or` behave the same as the `!`, `&&`, and `||` operators, except that the former have lower precedence.

A few binary operators can be syntactically combined with assignment to produce a compact assignment expression:

| Operator | Assignment | Example       | Meaning          |
|----------|------------|---------------|------------------|
| +        | +=         | x += y        | x = x + y        |
| -        | -=         | x -= y        | x = x - y        |
| *        | *=         | x *= y        | x = x * y        |
| /        | /=         | x /= y        | x = x / y        |
| %        | %=         | x %= y        | x = x % y        |
| &        | &=         | x &= y        | x = x & y        |
| ^        | ^=         | x ^= y        | x = x ^ y        |
| &#124;   | &#124;=    | x &#124;= y   | x = x &#124; y   |
| &lt;&lt; | &lt;&lt;=  | x &lt;&lt;= y | x = x &lt;&lt; y |
| &gt;&gt; | &gt;&gt;=  | x &gt;&gt;= y | x = x &gt;&gt; y |



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

An expression `forall (ID : Type) Expr` evaluates to true if `Expr` evaluates to true for all values `ID` of the type `Type`. An expression `exists (ID : Type) Expr` evaluates to true if `Expr` evaluates to true for some value `ID` of the type `Type`. In both cases, the scope of `ID` is the inner expression `Expr`, and `Type` must be a bounded integer or a scalar set.

### Example

The following function can be used to check if all elements of the boolean array `a` have the value `true`.

``` c
bool alltrue(bool a[5])
{
  return forall (i : int[0,4]) a[i];
}
```

## Sum

An expression `sum (ID : Type) Expr` evaluates to an integer and is equal to the sum of the expressions evaluated with `ID` ranging over the given type argument. Boolean or state predicates (in TCTL expressions only) are accepted but not clock constraints. The expressions must be side-effect free. The type must be a bounded integer or a scalar set.

## Floating Point Type Support

Statistical model checking (SMC) supports double precision floating point type `double`. The clock variables also have floating point values in SMC. Symbolic and statistical model checking can be applied on the same model provided that `double` and `hybrid clock` type variables do not influencing the model logic, i.e. they cannot be used in guard and invariant constraints (but can be used in ODE expressions).

The following is the list of builtin floating point functions (mostly imported from C math library, hence the C math manual can be consulted for more details):

*   `int abs(int)` — absolute value of integer argument.
*   `double fabs(double)` — absolute value of double argument.
*   `double fmod(double x, double y)` — remainder of the division opration _x/y_.
*   `double fma(double x, double y, double z)` — computes _x*y+z_ as if to infinite precision.
*   `double fmax(double x, double y)` — the larger of the two arguments.
*   `double fmin(double x, double y)` — the smaller of the two arguments.
*   `double exp(double x)` — Euler's number raised to the given power: _e<sup>x</sup>_.
*   `double exp2(double x)` — 2 raised to the given power: _2<sup>x</sup>_.
*   `double expm1(double x)` — Euler's number raised to the given power minus 1: _e<sup>x</sup>-1_.
*   `double ln(double x)` — logarithm to the base of Euler's number: _log<sub>e</sub>(x)_.
*   `double log(double x)` — logarithm to the base of 10 _log<sub>10</sub>(x)_ (this is different from C library, kept for backward compatibility reasons).
*   `double log10(double x)` — logarithm to the base of 10: _log<sub>10</sub>(x)_.
*   `double log2(double x)` — logarithm to the base of 2: _log<sub>2</sub>(x)_.
*   `double log1p(double x)` — logarithm to the base of Euler's number with argument plus 1 _log<sub>e</sub>(1+x)_.
*   `double pow(double x, int y)` — raises to the specified integer power _x<sup>y</sup>_.
*   `double pow(double x, double y)` — raises to the specified floating point power _x<sup>y</sup>_.
*   `double sqrt(double x)` — computes square root.
*   `double cbrt(double x)` — computes cubic root.
*   `double hypot(double x, double x)` — computes hypotenuse of a right triangle: _sqrt(x<sup>2</sup>+y<sup>2</sup>)_.
*   `double sin(double x)` — sine of an angle in radians.
*   `double cos(double x)` — cosine of an angle in radians.
*   `double tan(double x)` — tangent of an angle in radians.
*   `double asin(double x)` — arc sine in radians.
*   `double acos(double x)` — arc cosine in radians.
*   `double atan(double x)` — arc tangent in radians.
*   `double atan2(double y, double x)` — arc tangent of the ratio _y/x_ in radians.
*   `double sinh(double x)` — hyperbolic sine: _(exp(x)-exp(-x))/2_.
*   `double cosh(double x)` — hyperbolic cosine: _(exp(x)+exp(-x))/2_.
*   `double tanh(double x)` — hyperbolic tangent: _(exp(x)-exp(-x))/(exp(x)+exp(-x))_.
*   `double asinh(double x)` — inverse hyperbolic sine.
*   `double acosh(double x)` — inverse hyperbolic cosine.
*   `double atanh(double x)` — inverse hyperbolic tangent.
*   `double erf(double x)` — Gauss error function (special non-elementary function of sigmoid).
*   `double erfc(double x)` — complement of a Gauss error function.
*   `double tgamma(double x)` — absolute value of the Gamma function (an extension of a factorial function _Γ(n)=(n-1)!_).
*   `double lgamma(double x)` — natural logarithm of the Gamma function.
*   `double ceil(double x)` — the ceiling function, the smallest integer value not less than _x_.
*   `double floor(double x)` — the floor function, the largest integer value not greater than _x_.
*   `double trunc(double x)` — nearest integer not greater in magnitude than _x_.
*   `double round(double x)` — nearest integer value to _x_ rounding halfway cases away from zero.
*   `int fint(double x)` — converts floating point value into integer (works like _trunc()_).
*   `double ldexp(double x, int y)` — multiplies by a specified power of two: _x*2<sup>y</sup>_.
*   `int ilogb(double x)` — extracts unbiased exponent: _trunc(log2(x+1))_.
*   `double logb(double x)` — extracts unbiased exponent: _trunc(log2(x+1))_.
*   `double nextafter(double from, double to)` — a next representable floating point value of _from_ in the direction of _to_.
*   `double copysign(double x, double y)` — floating point value with magnitude of _x_ and sign of _y_.
*   `bool signbit(double x)` — true if the argument _x_ is negative.<
*   `double random(double max)` — pseudo random number distributed uniformly over the interval _[0,max)_.
*   `double normal(double mean, double stddev)` — pseudo random number distributed according to normal (Gaussian) distribution for a given _mean_ and standard deviation _stddev_.

A few common constants and types can be declared as follows:

``` c
const int INT16_MIN     = -32768;
const int INT16_MAX     =  32767;
const int UINT16_MAX    =  65535;
const int INT32_MIN     = -2147483648;
const int INT32_MAX     =  2147483647;
typedef int[INT32_MIN, INT32_MAX] int32_t;
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
