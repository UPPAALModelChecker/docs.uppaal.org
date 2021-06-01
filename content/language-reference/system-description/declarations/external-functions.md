---
title: External Functions
weight: 30
---

{{% notice info %}}
  External Functions is an expert user feature and requires a high-level understanding of dynamic library loading and linking.
  The feature is only officially supported on Linux.
{{% /notice %}}

External Functions can be decreated alongside other declaratios. External functions are local to the current scope, defined by the grammar: 

``` EBNF 

ExternDecl   = 'import'  String '{' [FwdDeclList] '}'
FwdDeclList  = FwdDecl ';' | 
               FwdDeclList FwdDecl ';' 
FwdDecl      = [ID '='] Type ID '(' [Parameters] ')'

```

The following code will load the external libary `externallib.so` from the path `/home/user/lib` and import the functions `get_a_number`, `set_a_number` and `is_the_wold_safe`. The functions `is_the_wold_safe` will be imported with the name `importWithNewName`. 

We always recommend using a fully qualified path to the library file.
If you are using integers in external function, we recommend to defined a full integer range, to avoid problems with UPPAAL bounded integers.

``` C 
const int INT32_MAX = 2147483647;
typedef int[INT32_MIN,INT32_MAX] int32_t;

import "/home/user/lib/externallib.so" {
  int32_t get_a_number(); 
  void set_a_number(int32_t n);
  
  importWithNewName = bool is_the_wold_safe();
}

```

## Type Conversion and Restrictions
The types being transfarable between UPPAAL and external functions are curretly limited to `bool`, `chan`, `click`, `double`, `ptr_t` and `string`. Omitting complex types such as structs and nexted data structures. Only single-dimenstions arrays are supported on only of mutable types; arrays of chan and strings are not currently supported. See the following table for details: 


| UPPAAL Type  | C Type      | By Value | Return | Array |
| ------------ | ----------- | -------- | ------ | ----- |
| bool         | bool        | x        | x      | x     |
| chan         | const char  |          |        |       | 
| clock        | double      |          |        | x     | 
| double       | double      | x        | x      | x     | 
| ptr_t        | size_t      | x        | x      | x     |
| int          | int32_t     | x        | x      | x     |
| string       | const char  |          |        |       |
| \<type>[]    | \<type>     |          |        |       |


If a bounded integer ranges is violated, either when values are sent by reference or returned it will cause a runtime error.  

## Defining External Library

You can create a external library using either C or C++, by compiling it to a shared library.

The following C++ code defines a library with the same methods as used in the example above.

``` C++ 

int number = 42;

extern "C" int get_a_number() 
{
  return number;
}

extern "C" set_a_number(int n)
{
  number = n
}

extern "C" bool is_the_wold_safe();
{
    return true;
}
```

To compile a create a shared object file: 

``` sh 
g++ -std=c++17 -fPIC -c -o externallib.o externallib.cpp
gcc -shared -o externallib.so externallib.o 
```

For an advanced example see https://github.com/UPPAALModelChecker/uppaal-libs . 
  
