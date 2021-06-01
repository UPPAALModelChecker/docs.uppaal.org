---
title: External Functions
weight: 30
---

{{% notice info %}}
  External Functions is an expert user feature and requires a high-level understanding of dynamic library loading and linking.
  The feature is only officially supported on Linux.
{{% /notice %}}

External Functions can be decreated alongside other declaratios. External functions are local to the current scope, defined by teh grammar: 

``` EBNF 

ExternDecl   = 'import'  String '{' [FwdDeclList] '}'
FwdDeclList  = FwdDecl ';' | 
               FwdDeclList FwdDecl ';' 
FwdDecl      = [ID '='] Type ID '(' [Parameters] ')'

```



| UPPAAL Type  | C Type      | By Value | Return | Array |
| ------------ | ----------- | -------- | ------ | ----- |
| bool         | bool        | x        | x      | x     |
| chan         | const char  |          |        |       | 
| clock        | double      |          |        |       | 
| double       | double      | x        | x      | x     | 
| ptr_t        | size_t      | x        | x      | x     |
| int          | int32_t     | x        | x      | x     |
| string       | const char  |          |        |       |
| \<type>[]    | \<type>     |          |        |       |

Only single-dimenstions arrays are supported on only of mutable types; arrays of chan and strings are not currently supported.
  
