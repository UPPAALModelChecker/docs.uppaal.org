---
title: Template Instantiation
weight: 10
---

New templates can be defined from existing templates using the grammar for <tt>Instantiation</tt>. The new template has the same automaton structure and the same local variables as the template it is defined from. However, arguments are provided for any formal parameters of the template, thus changing the interface of the template.

<pre>Instantiation ::= ID [ '(' [Parameters]  ')' ] '=' ID '(' [Arguments] ')' ';'
</pre>

Template instantiation is most often used to bind formal parameters to actual arguments. The resulting template is later instantiated into a process by listing it in the [system line](../).

The new template can itself be parameterised. This provides the opportunity to make a partial instantiation of a template, where some formal parameters are bound while others remain free. Examples of typical uses are listed below.

For more examples, see the example systems included in the UPPAAL distribution.

## Examples

### Renaming

``` c
P1 = Q();
P2 = Q();
system P1, P2;
```

<tt>Q</tt> is a template without any formal parameters. <tt>P1</tt> and <tt>P2</tt> become templates identical to <tt>Q</tt>. This is used to make several instances of <tt>Q</tt> with different names. Notice that <tt>P1=Q()</tt> is a shorthand of <tt>P1()=Q()</tt>.

### Binding parameters

_In this example we use the textual syntax for template declaration as used in the XTA format. In the GUI, these templates would be defined graphically._

```
process R(int &i, const int j)
{
...
}
int x;
S = R(x, 1);
system S;
```

Here we bind the formal parameters of <tt>R</tt>, <tt>i</tt> and <tt>j</tt>, to <tt>x</tt> and <tt>1</tt> respectively. <tt>S</tt> becomes a template without any parameters. When listed in the system line, <tt>S</tt> is instantiated into a process with the same name.

### Partial instantiation

_In this example we use the textual syntax for template declaration as used in the XTA format. In the GUI, these templates would be defined graphically._

``` c
process P(int &x, int y, const int n, const int m)
{
   ...
}

int v, u;
const struct { int a, b, c; } data[2] = { { 1, 2, 3 }, { 4, 5, 6 } };

Q(int &x, const int i) = P(x, data[i].a, data[i].b, 2 * data[i].c);
Q1 = Q(v, 0);
Q2 = Q(u, 1);

system Q1, Q2;

```

Here <tt>P</tt> is a template with four formal parameters integer parameters. The first must be passed by reference, the remaining by value. <tt>Q</tt> is a template with two formal integer parameters. The first must be passed by reference, the second by value. <tt>Q1</tt> is equivalent to <tt>P(v, data[0].a, data[0].b, 2 * data[0].c</tt>.

This is very convenient when defining many instances of the same template with almost the same arguments. It is also useful to bind some formal parameters and leave others free. When the resulting template is listed in the system line, UPPAAL will create a process for each possible combination of arguments to the free parameters.