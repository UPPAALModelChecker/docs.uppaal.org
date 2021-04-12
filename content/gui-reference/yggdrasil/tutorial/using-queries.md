---
title: Using Queries
weight: 10
---

This tutorial assumes you have understood [using variables](../using-variables). 
### The system model 
This tutorial uses the same Up/Down model as in the section [using variables](../using-variables/#the-model-updown-system). Open the <tt> updown/updown.xml</tt> file in Uppaal.  

### Editing the Queries 
Sometimes it is desirable to generate test cases for specific purposes. This can be done by creating a verification query for the purpose, and use that to generate a test trace. 

In the _*Verifier*_ tab you can enter queries.
The _*Test Cases*_ generator is able to search for traces satisfying reachability queries (that is queries which start with `E<>`. The query entered in this tutorial should be `E<> System.Max`, which asks the verifier to find a trace where the _System_ process is in the location _Max_. 

![Test case queries](../img/query-editor.png)


### Generating test traces from queries
To generate test cases go to the _*Test Cases*_ tab and activate the _*Query*_ mode, and hit _*Add*_. 

![Test Case Generation with queries](../img/test-cases-query-mode.png)

This will generate a trace from the query file that leads to the _Max_ location. You can inspect in the trace statistics that that location is infact now covered. By default, a test trace will be generated per query for all queries in the query file. In the drop-down selector you can chosse a specific query to generate and add.  

![Resulting test trace](../img/test-cases-coverage-3-1.png)

Further, you can double click the trace and go to the _*Simulator*_ tab and verify that this trace does indeed lead to the _Max_ location. From the _Off_ location this requires doing _up_ ten successive times. 
![Inspecting the test trace in Simulator](../img/test-cases-simulator-3.png)

### Generating tests using the combined methodology

As recommended, start by adding test cases for the test purposes (queries), then optimize coverage by the auto-depth mode, and finally single-step mode. This results in the three sections listed the test traces output panel. 

![Coveage followin the methodology](../img/test-cases-coverage-3-2.png)
