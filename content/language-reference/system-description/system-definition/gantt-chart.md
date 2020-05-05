---
title: Gantt Chart
weight: 30
---
A Gantt chart, commonly used in project management, is a bar chart that shows activities displayed against time. On the left of the chart is a list of the activities and along the top is a suitable time scale. Each activity is represented by a bar; the position and length of the bar reflect the start date, duration and end date of the activity.

In UPPAAL Gantt Charts are used to automatic visualize traces. One needs to specify the list of activities and for each activity, what the different colored parts of the bar should reflect.

The Gantt Chart specification is placed after the [system definition](System_Definition.html). The syntax is defined by the following grammar:

<pre>
GanttDecl ::= 'gantt {' GanttDef '}'

GanttDef ::= '' | GanttDef NonTypeId GanttArgs ':' GanttExprList ';'

GanttArgs ::= '' | '(' GanttDeclSelect ')'

GanttDeclSelect ::= [Id](Identifiers.html) ':' [Type](TypeDeclarations.html)   | GanttDeclSelect ',' Id ':' Type

GanttExprList ::= GanttExpr  | GanttExprList ',' GanttExpr

GanttExpr ::= [Expression](Expressions.html) '->' [Expression](Expressions.html) 
              | 'for (' GanttEntrySelect ')' [Expression](Expressions.html) '->' [Expression](Expressions.html)

GanttEntrySelect ::= Id ':' Type    | GanttEntrySelect ',' Id ':' Type

</pre>

The first part of <tt>GanttDef</tt> (the one before the colon) specifies the list of activities. The second part (the one after the colon) specifies for each activity, what the bar should reflect.  
An instance of <tt>GanttExpr</tt> consists of two expressions. The one before <tt>-></tt> is evaluated to a boolean value. If it is evaluated to true, the expression after <tt>-></tt> will be evaluated to an integer. Note that this integer is not necessarily a constant. The integer will be map to a color (e.g. 0 will be map to red and 1 to green), which is the color of the bar when the expression is evaluated to true.  
<tt>GanttDeclSelect</tt> and <tt>for (...)</tt> are to be considered as syntax shortcuts rather than constructs.

## Examples

Sample color definitions:

``` c
  const int C_RED    = 0;
  const int C_GREEN  = 1;
  const int C_BLUE   = 2;
  const int C_PURPLE = 3;
  const int C_ORANGE = 5;
  const int C_YELLOW = 6;
  const int C_CYAN   = 9;

  gantt {
    Red: true -> C_RED;
    Colors(i:int[0,32]): true -> i;
  }
```

### Scheduling

``` c
 gantt {
  Task(i : pid_t): Task(i).Ready -> 1,
                   Task(i).Running -> 2,
                   Task(i).Blocked -> 3,
                   Task(i).Error -> 0,
                   for(j : sid_t) Task(i).sema[j] -> 6;
  Scheduler: len==0 -> 0, len>0 -> 1;
 }
```

### Train Gate

``` c
gantt {
  Xxxx:  Train(0).Cross -> 0,
         Train(1).Cross -> 1,
         Train(2).Cross -> 2;
  Gate: true -> Gate.len;
}
```