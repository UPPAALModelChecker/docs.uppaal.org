---
title: Using Queries
weight: 10
---
<!-- 
This tutorial assumes you have understood [using variables](using-variables). 

## The system model 
This tutorial uses the same Up/Down model as in the section [using variables](using-variables). Open the <tt> updown/updown.xml</tt> file in Uppaal.  -->

<!-- ## Using the Queries 
Sometimes it is desirable to generate test cases for specific purposes. This can be done in Yggdrasil by creating a verification query for the purpose, and using it to generate a test case. 

In the _*Verifier*_ tab you can enter queries.
The _*Test Cases Generator*_  searches for all reachability queries (that is queries which start with '<code>E&lt;&gt;</code>'
`E<>`

<img src="ygg-verifier.png">


The query entered in this tutorial should be `E<> System.Max`, which asks the verifier to find a trace where the _System_ process is in the location _Max_. 


To generate test cases go to the <code>Yggdrasil</code> tab and activate the <code>Query file</code> option, and hit <code>Generate</code>.
<img src="ygg-generate4.png">


This should generate a trace from the query file. You can double click the trace and go to the <code>Simulator</code> tab and verify that this trace does indeed lead to the <code>Max</code> location. <br/>
<img src="ygg-simulator4.png">


 -->