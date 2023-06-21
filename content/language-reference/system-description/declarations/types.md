---
title: Types
weight: 10
---

There are 6 predefined types: `int`, `bool`, `clock`, `chan`, `double` and `string`. Array and record types can be defined over all types except `string`.

```EBNF
Type          ::= Prefix TypeId
Prefix        ::= 'urgent' | 'broadcast' | 'meta' | 'const'
TypeId        ::= ID | 'int' | 'clock' | 'chan' | 'bool' | 'double' | 'string'
               |  'int' '[' [Expression] ',' [Expression] ']'
               |  'scalar' '[' Expression ']'
               |  'struct' '{' FieldDecl (FieldDecl)* '}'
FieldDecl     ::= Type ID ArrayDecl* (',' ID ArrayDecl*)* ';'
ArrayDecl     ::= '[' [Expression] ']'
               |  '[' Type ']'
```

The default range of an integer is `[-32768, 32767]`. Any assignment out of range will cause the verification to abort.

Variables of type `bool` can have the values `false` and `true`, which are equivalent to the the integer values `0` and `1`. Like in C, any non-zero integer value evalutes to `true` and `0` evaluates to `false`.

Channels can be declared as urgent and/or broadcast channels. See the section on [synchronisations](/language-reference/system-description/templates/edges/#synchronisations) for information on urgent and broadcast channels.

Floating-point variables of the `double`-type behave like C-`double`.
{{% notice warning %}}
Doubles values are not supported in the _symbolic_ verification and simulation engine and are simply ignored, which can lead to unexpected results.
{{% /notice %}}



Variables of `string` type must be declared constant. The primary use of `string` variables is in combination with [External Functions](ExternalFunctions.html)

## Constants

Integers, booleans, doubles strings, and arrays and records over integers and booleans can be marked constant by prefixing the type with the keyword `const`.

## Meta variables

Integers, booleans, doubles, and arrays and records over integers and booleans can be marked as meta variables by prefixing the type with the keyword `meta`.

Meta variables are stored outside of the state vector and are semantically not considered part of the state. I.e. two states that only differ in meta variables are considered to be equal.

## Arrays

The size of an array is specified either as an integer or as a bounded integer type or scalar set type. In the first case the array will be `0`-indexed. In the latter case, the index will be of the given type. The following declares a scalar set `s_t` of size 3 and an integer array `a` of size 3 indexed by the scalar:

```c
typedef scalar[3] s_t;
int a[s_t];
```

## Record Variables

Record types are specified by using the `struct` keyword, following the C notation. For example, the record `s` below consist of the two fields `a` and `b`:

```c
struct {
    int a;
    int b;
} s;
```

## Scalars

Scalars in UPPAAL are integer like elements with a limitted number of operations: Assignment and identity testing. Only scalars from the same scalar set can be compared.

The limitted number of operations means that scalars are unordered (or that all orders are equivalent in the sense that the model cannot distinguish between any of the them). UPPAAL applies _symmetry reduction_ to any model using scalars. Symmetry reduction can lead to dramatic reductions of the state space of the model. resulting in faster verification and less memory being used.

Notice that symmetry reduction is **not** applied if diagnostic trace generation is enabled or when `A<>`, `E[]` or `-->` properties are verified.

Scalar sets are treated as types. New scalar sets are constructed with the `scalar[n]` type constructor, where `n` is an integer indicating the size of the scalar set. Scalars of different scalar sets are incomparable. Use `typedef` to name a scalar set such that is can be used several times, e.g.

```c
typedef scalar[3] mySet;
mySet s;
int a[mySet];
```

Here `mySet` is a scalar set of size `3`, `s` is a variable whos value belongs to the scalar set `mySet` and `a` is an array of integers indexed by the scalar set `mySet`. Thus `a[s] = 2` is a valid expression.
