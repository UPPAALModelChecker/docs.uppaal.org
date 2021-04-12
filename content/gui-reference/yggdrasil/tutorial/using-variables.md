---
title: Using model variables
weight: 10
---
 

This tutorial assumes you have understood [basic test case generation](../basic-test-generation). 

## The model: Up/Down system

Open the <tt> updown/updown.xml</tt> file in Uppaal. 

The system contains two templates: _System_ and _User_. 

The system can be either _On_, _Max_, or _Off_, with channels _up_ and _down_ changing between them. The user can non-deterministically press _up_ or _down_.

|_System_ template | _User_ template    | 
|:------------- |:--------------:| 
|![_System_ template](../img/System2.png) | ![_User_ template](../img/User2.png)|

## Add model annotations and test pre- and post-fix code
Global variable declarations and prefix/postfix code is [the same as for the on/off model](basic-test-generation#add-test-cases-specific-model-annotations).

## Add test step code annotations accessing model variables
The system model is decorated with slightly different test code. 

- The location _Off_ is still decorated with <tt>expect_off();</tt>, similarly the location _Max_ is decorated with <tt>expect_max();</tt>. 
- The state _On_ is different, since here we want to verify the value of the variable <tt>val</tt> as well as the location. This is done by entering the value of <tt>val</tt> into the test case using the code <tt>
expect_on($(System.val));</tt>. This will execute the <tt>expect_on</tt> with the value of <tt>val</tt> as parameter. Since <tt>val</tt> is local to the process _System_ the name is entered as <tt>System.val</tt>. 

## Generating the test cases
Like the basic case, to generate test cases go to the _*Yggdrasil*_ tab.Select which techniques for test case generation to use. For now only select _*Depth auto mode*_ and a depth of 20. Click _*Add*_ to generate the test cases. 
![Generate test cases](../img/test-cases-generate-2.png)

## Inspecting the coverage 

The test generation will normally generate 2-3 test case traces (depending on randomization). Here 3 traces were generated. 
Each trace generated will have a line in the list similar to <tt>Trace coverage: 5/8</tt>. This shows that the trace covered five out of eight edges. Selecting a specific trace will show furter coverage statistics about that trace, i.e., which locations/edges are traversed how many times. Here, the _System_'s edge from location _On_ to _On_ has been traversed 6 times, whereas the edge from _On_ to _Off_ is traversed 0 times, revealing that it is not covered by this trace. 

![Inspecting trace 1](../img/test-cases-coverage-2-1.png)


By double clicking the trace and then selecting the _*Simulator*_ tab, the trace can be further examined. By selecting _*Mark Visited*_ in the _*View*_ menu, all covered edges will be colored blue in the simulator. 

![Inspecting the test trace](../img/test-cases-coverage-2-visualization.png)


The total coverage achieved by the previous steps can be viewed by clicking the _*Total Coverage*_ button which updates the trace statistics with the combined coverage. Due to the randomness of the model and the test case generation algorithm it is unlikely to get 100% coverage. Here, 1 location and 3 edges are left uncovered. 

![Inspecting trace 1](../img/test-cases-coverage-2-2.png)

## Completing coverage using the Single Step method


This coverage can be increased by using the _*Single step*_ method. This method searches for traces for uncovered edges.
Adding these, should result in a number of test trace being added (here one, thus four in total) giving <tt>8/8</tt> in total coverage, thereby achieving the desired high coverage; here complete edge- and location-coverage. 

![Completing coverage](../img/test-cases-coverage-2-3.png)


## Inspecting the test case code

Save the test cases using the _*Save Test Cases*_ button; select the output folder for test case to be the <tt>updown</tt> folder in this tutorial. This will produce a test-case file named <tt>testcase0.code</tt> in the selected output folder. If several traces have been generated, several files will be generated with sequential numbering. 

Each of these will be a Java class with the sequence of method invocations induce by the generated trace. A snippet is shown below.
``` java 
 1: package app;
 2: import app.App;
 3: 
 4: class Test extends App {
 5: 
 6:     public static void main(String[] args) {
 7: 
 8: 
 9: expect_off();
10: 
11: up();
12: 
13: expect_on(1);
14: 
15: up();
16: 
17: expect_on(2);
18: 
19: up();
20: 
21: expect_on(3);
22: 
23: down();
24: 
25: expect_on(2);
26: 
27: up();
   <... snip ...>
94:     }
95: }
```

- The overall composition of the test case is the same as in the first part of the tutorial
- The difference can be seen on lines 13, 17, 21, and 25. Here it is seen that the value of <tt>val</tt> is entered into the trace. 
- It can be seen that the value increases after <tt>up();</tt> and decreases after <tt>down();</tt>.

Running the <tt>test.sh</tt> (or <tt>test.bat</tt> on Windows) will compile and run the test cases one at a time. 
It will output the name of each file as it executes them.
No output from the test case signifies successful execution. 
<pre>
updown$ ./test.sh 
testcase0.code
testcase1.code
testcase2.code
testcase3.code
updown$
</pre>

Running the <tt>testMutant.sh</tt> (or <tt>testMutant.bat</tt> on Windows) will compile and run the test cases on the mutant implementation. 
This should result in an exception being thrown when executing test case number 3, signifying a test error. 
<pre>
updown$ ./testMutant.sh 
testcase0.code
testcase1.code
testcase2.code
testcase3.code
Exception in thread "main" java.lang.AssertionError
  at app.App.expect_on(App.java:17)
  at app.Test.main(Test.java:15)
updown$
</pre>

The implementation can be examined in the <tt>updown/app</tt> folder. See <tt> updown/app/AppC.java</tt> for the correct implementation and <tt>updown/app/AppM.java </tt> for the mutant. 
