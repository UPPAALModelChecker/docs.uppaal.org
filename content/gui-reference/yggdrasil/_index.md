---
title: Test Cases (Yggdrasil)
weight: 70
---

Yggdrasil (Test Cases tab) is an offline test-case generation tool with a purpose of increasing edge coverage. It [generates traces](Generate.html) from the model, and translates them into test cases based on [test code](Testcode.html) entered into the model on edges and locations next to comments. Yggdrasil expects a _deadlock free_ and mostly _deterministic_ model.

Deadlocks can be checked against in the [Verifier](../Verifier/Introduction.html) tab using <tt>A[] not deadlock</tt> query.

There are no checks or reinforcements made for determinism. Non-deterministic implementation requirements (behavior not controlled by a test execution harness) may yield test-cases which cannot be executed in a controlled manner. For example, test execution harness might not be able to force the implementation under test to respond in a specific way assumed by a test case if the implementation is allowed to respond in multiple ways non-deterministically. The environment assumption model (edges controlled by the test execution harness) is encouraged to be non-deterministic to facilitate a more focused and flexible control when selecting test cases.

The buttons "Add" will generate traces based on the verification options selected in the [Options menu](../Menu_Bar/Options.html) where the search order and diagnostic trace options are _**overridden**_ by the corresponding drop-down list selection. The traces are added and shown in the Traces list below on the left. Selecting a trace will show the statistics for this trace in the Trace statistics on the right. The "Total Coverage" button will show the combined statistics of all the traces added so far. Double clicking a trace loads the trace in the Simulator tab, where the execution scenario can be examined in detail. [Simulator](../Simulator/Process_Window.html) colors the covered locations and edges in blue when "Mark Visited" option is selected under the [View menu](../Menu_Bar/View.html).

Test cases are exported to a specified directory specified by clicking "Export code" button at the bottom. Previously stored test cases are overwritten by new test ones.

_**Note:** the traces and statistics are lost when the model is reloaded. Traces and statistics are not saved with the model. Only the test cases can be saved._