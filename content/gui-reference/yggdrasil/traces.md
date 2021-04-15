---
title: Generating Traces
weight: 10
---

Traces are generated using three purposes: queries, depth search, and individual edges.

In the [Verifier](/gui-reference/verifier/) tab the [existential queries (<tt>E<></tt>)](/language-reference/requirements-specification/) can be used to specify a desired functionality to be tested and hence can be selected as a test purpose for test case generation. All or specific queries can be selected and the resulting trace is added to be used as a test case.

The second option uses heuristics of random depth first search of the specified number of steps with a hope of increasing the coverage. The resulting trace is used as a test case. The search process is repeated until the newly generated trace does not contribute new coverage over the previous traces. In order to use this method a global integer variable named <tt>\_\_reach\_\_</tt> must be declared, initialized to zero and should not be used anywhere in the model. The number of steps depends on the model (size and depth of the model) and application domain (how long test cases are acceptable). If depth is configured too small there is a risk that many edges wil not be covered. If depth is configured very high, needlessly long test cases will be generated.  

The third option attempts to cover the remaining edges which are not covered by the previously generated traces. This method submits a separate reachability query for each uncovered edge. Large models may have many edges, and therefore many queries may take a long time to execute. Even worse: some edges might be unreachable at all and thus require exhaustive search which may consume a lot of time and memory. In order to use this method a global integer variable named <tt>\_\_single\_\_</tt> must be declared, initialized to zero and should not be used throughout the model.