---
title: External Functions
weight: 30
---

{{% notice info %}}
  External Functions is an expert user feature and requires a high-level understanding of dynamic library loading and linking.<br>
  The feature is supported on Linux and experimental on Windows and macOS.
{{% /notice %}}

{{% notice info %}}
This feature is supported since Uppaal Stratego version 4.1.20-7, or Uppaal version 5.0 or later.
{{% /notice %}}

External Functions can be declared alongside other declaratios. External functions are local to the current scope, defined by the grammar:

``` EBNF
ExternDecl   = 'import'  Path '{' [FwdDeclList] '}'
FwdDeclList  = FwdDecl ';' |
               FwdDeclList FwdDecl ';'
FwdDecl      = [ID '='] Type ID '(' [Parameters] ')'
```

<tt>Path</tt>
: is a double-quoted (using `"`) character sequence (string) denoting a file path to the library placed on the same computer as the used engine (`server` or `verifyta`).<br>
Note that the backslash (`\`) character in (Windows) paths needs to be either escaped with another backslash or replaced with the forwardslash (`/`), i.e. `\` should be replaced with either `\\` or `/`. For example, `"C:\libexternal.dll"` should be written as `"C:\\libexternal.dll"` or `"C:/libexternal.dll"`.

The following code will load the external libary `libexternal.so` from the path `/home/user/lib` and import the functions `get_number`, `set_number` and `is_the_world_safe`.
The function `is_the_world_safe` will be imported with the name `is_safe`.

Even though Uppaal will attempt to locate the library in several default paths, we recommend using a fully qualified path to the library file.

If you are using integers in external function, we recommend defining a full integer range in order to avoid Uppaal `int` range (`[-32768,32767]`) errors.

``` C
const int INT32_MIN = -2147483648;        // not needed since Stratego 4.1.20-11
const int INT32_MAX = 2147483647;         // not needed since Stratego 4.1.20-11
typedef int[INT32_MIN,INT32_MAX] int32_t; // not needed since Stratego 4.1.20-11

import "/home/user/lib/libexternal.so" {
    int32_t get_number();
    void set_number(int32_t n);
    int32_t get_sqrt(int32_t n);
    is_safe = bool is_the_world_safe();
};
```

## Type Conversion and Restrictions
The types transfarable between Uppaal and external functions are curretly limited to `bool`, `int`, `double`, `clock`, `chan`, `ptr_t` and `string`. Omitting complex types such as structs and nested data structures. Only single-dimentional arrays are supported on only mutable types; arrays of `chan` and strings are not currently supported.

The following table summarizes the current support:

| UPPAAL Type  | C Type       | By Value | Return | Array |
| ------------ | ------------ | -------- | ------ | ----- |
| bool         | bool         | x        | x      | x     |
| int          | int32_t      | x        | x      | x     |
| double       | double       | x        | x      | x     |
| clock        | double       |          |        | x     |
| chan         | const char*  |          |        |       |
| ptr_t        | size_t       | x        | x      | x     |
| string       | const char*  |          |        |       |
| \<type>[]    | \<type>      |          |        |       |


A violation of a range of a bounded integer (either pass-by-reference or return) will cause a runtime error.

## Resource Initialization and Release
The library is loaded during document parsing and the library can be instructed to initialize and release its resources using [Special Functions](../functions/#special-functions).

## Defining External Library

An external library can be compiled from C or C++ code and linked into a shared library.
Uppaal uses C symbol name mangling, so C++ compiler needs to be instructed to export `"C"` names, whereas C compiler does it by default.

The following C/C++ code implements the library functions used for the example above.

`external.h`:
``` C++
#ifndef LIBRARY_EXTERNAL_H
#define LIBRARY_EXTERNAL_H

#ifdef __cplusplus
extern "C" { // tells C++ compiler to use C symbol name mangling (C compiler ignores)
#endif // __cplusplus

int get_number();
void set_number(int n);
int get_sqrt(int n);
bool is_the_world_safe();

#ifdef __cplusplus
} // end of "C" symbol name mangling
#endif // __cplusplus

#endif // LIBRARY_EXTERNAL_H
```

`external.cpp`:
``` C++
#include "external.h"
#include <cmath>

static int number = 42; // internal state, be careful

#ifdef __cplusplus
extern "C" { // tells C++ compiler to use C symbol name mangling (C compiler ignores)
#endif // __cplusplus

int get_number()
{   // is not free from side-effects, when set_number is used
    return number;
}

void set_number(int n)
{   // the state needs to be synchronized with the model state
    number = n;
}

int get_sqrt(int n)
{
    return std::sqrt(n);
}

bool is_the_world_safe()
{
    return true;
}

#ifdef __cplusplus
} // end of "C" symbol name mangling
#endif // __cplusplus
```

Execute the following shell commands to compile the source `external.cpp` into object file `external.o` and then link `external.o` into a shared library `libexternal.so`:

``` sh
g++ -std=c++17 -Wpedantic -Wall -Wextra -fPIC -g -Og -o external.o -c external.cpp
gcc -shared -o libexternal.so external.o
```
For optimized builds replace `-g Og` with `-DNDEBUG -O3` in the above command and strip the details with `strip libexternal.so`.

For more library examples please visit [uppaal-libs](https://github.com/UPPAALModelChecker/uppaal-libs) repository.

## Debugging

Inspect the library file using `file /home/user/lib/libexternal.so`:
```
libexternal.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, ...
```

Inspect the dynamic library dependencies `ldd /home/user/lib/libexternal.so`:
```
       statically linked
```
This means that the library is linked with everything it needs and is self-contained, it does not require any additional libraries.
Alternatively, one may see a list of required libraries and where the library loader (`ld-linux.so`) can (not) find them.

Inspect the exported dynamic symbols of the library using `objdump -T /home/user/lib/libexternal.so`:
```
libexternal.so:     file format elf64-x86-64

DYNAMIC SYMBOL TABLE:
0000000000000000  w   D  *UND*  0000000000000000 __cxa_finalize
0000000000000000  w   D  *UND*  0000000000000000 _ITM_registerTMCloneTable
0000000000000000  w   D  *UND*  0000000000000000 _ITM_deregisterTMCloneTable
0000000000000000  w   D  *UND*  0000000000000000 __gmon_start__
0000000000001120 g    DF .text  0000000000000006 is_the_word_safe
0000000000001100 g    DF .text  000000000000000a get_number
0000000000004008 g    DO .data  0000000000000004 number
0000000000001110 g    DF .text  000000000000000a set_number
```

Similarly using `nm -D /home/user/lib/libexternal.so`:
```
                 w __cxa_finalize
0000000000001100 T get_number
                 w __gmon_start__
0000000000001120 T is_the_word_safe
                 w _ITM_deregisterTMCloneTable
                 w _ITM_registerTMCloneTable
0000000000004008 D number
0000000000001110 T set_number
```
(GNU compiler exports all symbols by default, hence `number` can be part of the exported symbol listing)

One can also inspect the library loading among all OS kernel calls, for example `strace verifyta external.xml`:
```
...
read(3, "<?xml version=\"1.0\" encoding=\"ut"..., 4096) = 1332
getcwd("/tmp/uppaal-lib", 1024)         = 16
read(3, "", 4096)                       = 0
openat(AT_FDCWD, "/home/user/lib/libexternal.so", O_RDONLY|O_CLOEXEC) = 4
read(4, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
newfstatat(4, "", {st_mode=S_IFREG|0750, st_size=13920, ...}, AT_EMPTY_PATH) = 0
mmap(NULL, 16400, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 4, 0) = 0x7f30277e5000
mmap(0x7f30277e6000, 4096, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x1000) = 0x7f30277e6000
mmap(0x7f30277e7000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x2000) = 0x7f30277e7000
mmap(0x7f30277e8000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x2000) = 0x7f30277e8000
close(4)                                = 0
mprotect(0x7f30277e8000, 4096, PROT_READ) = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
...
```
Here, one can see `verifyta` requesting for current directory (`getcwd`), and then opening `/home/user/libexternal.so` file (`openat`).

Alternatively, one may find errors when some library is missing or a path is wrong:
```
getcwd("/tmp/uppaal-lib", 1024)         = 16
read(3, "", 4096)                       = 0
openat(AT_FDCWD, "/home/user/wrong/libexternal.so", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
```

Errors when some symbol is not found (wrong function name):
```
getcwd("/tmp/uppaal-lib", 1024)         = 16
read(3, "", 4096)                       = 0
openat(AT_FDCWD, "/home/user/lib/libexternal.so", O_RDONLY|O_CLOEXEC) = 4
read(4, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
newfstatat(4, "", {st_mode=S_IFREG|0750, st_size=15264, ...}, AT_EMPTY_PATH) = 0
mmap(NULL, 16408, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 4, 0) = 0x7f988f7d5000
mmap(0x7f988f7d6000, 4096, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x1000) = 0x7f988f7d6000
mmap(0x7f988f7d7000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x2000) = 0x7f988f7d7000
mmap(0x7f988f7d8000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x2000) = 0x7f988f7d8000
close(4)                                = 0
mprotect(0x7f988f7d8000, 4096, PROT_READ) = 0
futex(0x7f988f6791f0, FUTEX_WAKE_PRIVATE, 2147483647) = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
write(2, "external.xml", 12external.xml)            = 12
write(2, ":", 1:)                        = 1
write(2, "/nta/declaration", 16/nta/declaration)        = 16
write(2, ":", 1:)                        = 1
write(2, "5", 15)                        = 1
write(2, ": [", 3: [)                      = 3
write(2, "error", 5error)                    = 5
write(2, "] ", 2] )                       = 2
write(2, "/home/user/lib/libexternal.so: "..., 68/home/user/lib/libexternal.so: undefined symbol: is_the_word_safe.) = 68
```

If the library implementation crashes, then one may try and debug it by loading `verifyta` with the specified model into a debugger or Integrated Development Environmnet (IDE) like Netbeans or Clion.

In order to step through the library calls, make sure that the library is compiled and linked with debug information (using `-g -Og` compiler arguments).

Alternatively, we strongly suggest to use unit tests to call your library and inspect the behavior in the debugger or IDE, for example:

`external_test.cpp`
``` C++
#include "external.h"
#include <cassert>

int main()
{
    int seven = get_sqrt(50);
    assert(seven == 7);
    int two = get_sqrt(-4);
    assert(two == 2);
}
```

Compile `external_test.cpp` into `external_test` against `libexternal.so` in `/home/user/lib` and run:
``` shell
g++ -std=c++17 -Wpedantic -Wall -Wextra -g external_test.cpp -L/home/user/lib -lexternal -o external_test
LD_LIBRARY_PATH=/home/user/lib ./external_test
```

The test above may produce the following output:
```
external_test: external_test.cpp:9: int main(): Assertion `two == 2' failed.
Aborted (core dumped)
```
Which means that the assertion `two == 2` on line `9` of `external_test.cpp` is false.

The test above can be (re-)run using `gdb` debugger:
``` shell
LD_LIBRARY_PATH=/home/user/lib gdb ./external_test
Reading symbols from ./external_test...
(gdb) r
Starting program: /tmp/uppaal-lib/external_test 
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
external_test: external_test.cpp:8: int main(): Assertion `two == 2' failed.

Program received signal SIGABRT, Aborted.
__pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
    at ./nptl/pthread_kill.c:44
44      ./nptl/pthread_kill.c: No such file or directory.
(gdb) bt
#0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
    at ./nptl/pthread_kill.c:44
#1  0x00007ffff7d61d2f in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
#2  0x00007ffff7d12ef2 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#3  0x00007ffff7cfd472 in __GI_abort () at ./stdlib/abort.c:79
#4  0x00007ffff7cfd395 in __assert_fail_base (fmt=0x7ffff7e71a70 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", 
    assertion=assertion@entry=0x55555555602c "two == 2", file=file@entry=0x55555555600f "external_test.cpp", 
    line=line@entry=8, function=function@entry=0x555555556004 "int main()") at ./assert/assert.c:92
#5  0x00007ffff7d0bdf2 in __GI___assert_fail (assertion=0x55555555602c "two == 2", 
    file=0x55555555600f "external_test.cpp", line=9, function=0x555555556004 "int main()") at ./assert/assert.c:101
#6  0x00005555555551c7 in main () at external_test.cpp:8
(gdb) up
#1  0x00007ffff7d61d2f in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
78      in ./nptl/pthread_kill.c
(gdb) 
#2  0x00007ffff7d12ef2 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
26      ../sysdeps/posix/raise.c: No such file or directory.
(gdb) 
#3  0x00007ffff7cfd472 in __GI_abort () at ./stdlib/abort.c:79
79      ./stdlib/abort.c: No such file or directory.
(gdb) 
#4  0x00007ffff7cfd395 in __assert_fail_base (fmt=0x7ffff7e71a70 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", 
    assertion=assertion@entry=0x55555555602c "two == 2", file=file@entry=0x55555555600f "external_test.cpp", 
    line=line@entry=8, function=function@entry=0x555555556004 "int main()") at ./assert/assert.c:92
92      ./assert/assert.c: No such file or directory.
(gdb) 
#5  0x00007ffff7d0bdf2 in __GI___assert_fail (assertion=0x55555555602c "two == 2", 
    file=0x55555555600f "external_test.cpp", line=8, function=0x555555556004 "int main()") at ./assert/assert.c:101
101     in ./assert/assert.c
(gdb) 
#6  0x00005555555551c7 in main () at external_test.cpp:9
9           assert(two == 2);
(gdb) p two
$1 = -2147483648
(gdb)
```

In the log above, one can see that the binary is loaded from `external_test`.

The program is run by command `r`, then a crash is observed due to failed assertion `two == 2`.

A call stack trace is printed using command `bt`, in particular it contains `main ()` from our source file `external_test.cpp`.

Then the debugger is instructed to go up in the call stack multiple times by issuing a command `up` and then blank command (simply enter, which repeats the last command).

Then at the `main` function call, the code line `assert(two == 2);` is highlighted.

And finally the value of variable `two` is printed using command `p two`. The value is `-2147483648` which is not as expected, hence the assertion failed.

It is also possible to attach `gdb` to an already running process (like `verifyta` or Uppaal engine `server`), set break points and watches.
