---
title: Basic Test Generation
weight: 10
---
 
<!-- 
_Locations/channels_
_*TOOL MENU*_
<tt> code 
 -->

<!-- Open the <a href="../onoff/onoff.xml">onoff.xml</a> file in Uppaal.  -->
### Create the models
Open the On/Off System model <tt> "onoff/onoff.xml" </tt> file in Uppaal. The system contains two templates entitled _System_ and _User_. The _System_ represents the system or device (e.g. lamp) under test. The _User_ models the possible user interactions with the system.   

The system can be either _On_ or _Off_, with channels _on_ and _off_ changing between them. The user can non-deterministically press _on_ or _off_.
|_System_ template | _User_ template    | 
|:------------- |:--------------:| 
|![_System_ template](../img/System.jpg) | ![_User_ template](../img/User.jpg)|

<!-- ![_System_ template](/gui-reference/yggdrasil/Tutorial/System.jpg) -->

### Add Test Cases specific model annotations

First, some _*Test Cases*_ specific declarations muse be made; these are required for the generator to use depth-first reachability and single step techniques for test-case generation. These variables must not be altered in the model. Hence, these two variables must be declared in the global _*Declarations*_ section:
``` c
int __reach__ = 0;
int __single__ = 0;
```

### Add test pre-fix and post-fix code
Second, there are two blocks of comments in the _*System declarations*_ section of the model. The contents of a multi-line comment starting with <tt>TEST_PREFIX</tt> or <tt>TEST_POSTFIX</tt> are ejected as prefix code (before the actual test case behavior) or postfix code (after actual test case behavior) for each test case. 

In this example each test case is a Java class with a main method; executing this Java class constitutes running the test case. Therefore the prefix and postfix code is the wrapper code to setup this Java class. 
``` java 
/** TEST_PREFIX
  package app;
  import app.App;

  class Test extends App {

  public static void main(String[] args) {

*/

/** TEST_POSTFIX
  }
}
*/
```

The test case <tt>class extends</tt> the <tt>App</tt> class we are testing. If you use a specific unit test framework, these lines should be changed to match its requiements. Each step in the test case will execute some methods on this class. 

By default, test cases will be named and sequentially numbered like <tt>testcase0.code</tt>. 
If desired, the filename and file extension can be changed by the following special comments in the _*System declarations*_ section. For now, stay with the defaults.    
``` java 
/** TEST_FILENAME test- */
/** TEST_FILEEXT .txt */
```

### Add test step code annotations
The system model must be decorated with test code. Double clicking the edge labeled <tt>on?</tt> and selecting the _*Test Code*_ tab reveals an area for entering test code. In this model the test code should be <tt>set_on();</tt>. This will execute the method <tt>set_on()</tt> on the application whenever this edge is taken in a test case. Similarly, <tt>set_off();</tt> is added to the edge labeled <tt>off?</tt>.

For locations, test code can be entered in two areas, _*Enter*_ and _*Exit*_. This test code is added to the test case when the trace reaches the location or leaves it, respectively. 

|Adding _edge_ test code  | Adding _location_ test code   | 
|:----------------------: |:-----------------------------:| 
|![Adding test code to edges](../img/test-cases-edge-code-1.png)|![Adding test code to locations](../img/test-cases-location-code-1.png)|


### Generating the test cases

To generate test cases go to the _*Yggdrasil*_ tab. You may need to enable the tab in the GUI first. 

|Enable Test Cases Tab               | Test Cases Tab              | 
|:------------- |:-------------:| 
|![Enable Test Cases Generation tab](../img/enable-test-cases-tab.png)|![Test Cases tab](../img/enabled-test-cases-tool-tab.png)|



Select which techniques for test case generation to use. For now only select the auto-_*depth*_ search mode with a depth of 20, and click _*add*_. 

![Generating tests with auto-depth mode](../img/test-cases-generate-1-1.png)


Clicking _*add*_ should generate a single trace. Each trace generated will have a line in the list similar to <tt>Trace coverage: 4/4</tt>. This shows that the trace covered four out of four edges. Further information about which locations and edges are/are not covered are shown in the _*Statistics*_ panel to the right. Here, all of the 3 locations and 4 edges are trivially covered. 

![Generation](../img/test-cases-coverage-1.png)

By double clicking the trace and selecting the _*Simulator*_ tab, the trace can be examined. Unsurprisingly, the trace simply runs in circles with alternating on/off presses. 

![Simulating a test case](../img/test-cases-simulator-1.png)

Next output the test cases to the file by clicking *_Save Test Cases_*. Select the output folder for test cases. Make this point to the <tt>onoff</tt> folder in this tutorial. 
![Test Cases Output](../img/test-cases-save-1.png)

### Inspecting the test case code

Pressing the _*Save Test Cases*_  button in the _*Test Cases*_ tab will generate a file called <tt>testcase0.code</tt> in the selected output folder. If several traces have been generated, several files will be generated with sequential numbering. 

Each of these will be a Java class with the sequence of method invocations induce by the generated trace. A snippet is shown below.
``` java
 1: package app;
 2: import app.App;
 3: 
 4: class Test extends App {
 5: 
 6:     public static void main(String[] args) {
 7: 
 8: expect_off();
 9: 
10: set_on();
11: 
12: expect_on();
13: 
14: set_off();
15: 
   <... snip ... >
93: 
94:     }
95: }
```


- The test case starts with the prefix code on lines 1-6. 
- Line 8 is the first step of the trace. This is <tt>expect_off();</tt> since the initial location is <tt>Off</tt>. 
- The first transition is the one labeled _on?_, the test code for this transition is <tt>set_on();</tt>. This is entered in the trace at line 10. 
- The trace then enters location _On_ and <tt>expect_on();</tt> is in the test case at line 12. The test case continues in this fashion.
- The trace ends with the postfix code on lines 94-95. 

### Exectuting the test cases
Running the <tt>test.sh</tt> (or <tt>test.bat</tt> on Windows) will compile and run the test cases one at a time. 
It will output the name of each file as it executes them.
No output from the test case signifies successful execution. 
<pre>
onoff$ ./test.sh 
testcase0.code
onoff$
</pre>

Running the <tt>testMutant.sh</tt> (or <tt>testMutant.bat</tt> on Windows) will compile and run the test cases on the mutant (intentionally wrong) implementation. 
This should result in an exception being thrown, signifying a test error. 
<pre>
onoff$ ./testMutant.sh 
testcase0.code
Exception in thread "main" java.lang.AssertionError
  at app.App.expect_on(App.java:17)
  at app.Test.main(Test.java:15)
onoff$
</pre>

The implementation code can be examined in the <tt>onoff/app</tt> folder. See file <tt> onoff/app/AppC.java</tt> for the correct implementation and <tt> onoff/app/AppM.java</tt> for the mutant. 

In order to transfer this to you own applications, you will have to decorate the model with test code such that the output from Yggdrasil constitutes an executable test case in whatever test execution framework you use. 


