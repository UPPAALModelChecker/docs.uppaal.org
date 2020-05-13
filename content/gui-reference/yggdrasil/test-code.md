---
title: Specifying Test Code
weight: 20
---

Traces are translated into executable test cases based on test code entered into the model. The test code is entered as verbatim text, so any language or execution back-end can be used. Test code can be entered in five areas: Prefix code, location enter code, location exit code, edge code, and postfix code. Each test case starts with the prefix code, continues with test code along the locations and edges of the trace and ends with the postfix code.

The prefix (and the postfix) code is entered as a comment after the [system definition](/language-reference/system-description/system-definition/) section using a special multi-line comment starting with the word <tt>TEST_PREFIX</tt> (and <tt>TEST_POSTFIX</tt> respectively).

Each location in the transition system has two areas for test code. Double clicking a location in the editor will bring up a window with a test code tab. The location enter code is added to the test case when this location is entered, and the location exit code is added when the location is left.

Similarly double clicking an an edge will bring up a window with a single test code field. This code is added to the test case when the transition containing this edge is traversed.

For location and edge test code the value of variables can be entered into the test case. This is done using <tt>$(var)</tt> for global variables or <tt>$(Process.var)</tt> for process-local variables. Dollar signs can be escaped with backslash like <tt>\$ </tt>and backslash can be escaped with backslash like <tt>\\</tt>. For location enter code the value is read after the transition into the state has been taken. For location exit code the value is read before the transition out of the state is taken. For edge code the value is read before taking the transition.</tt></tt>

The test case file name and extension can be configured using special comments too: <tt>TEST_FILENAME</tt> and <tt>TEST_FILEEXT</tt>. These comments must be on one line. Generic name "testcase" and ".code" are used if these settings are not set.

Example test case generation settings in the system declarations after the system definition:

``` java
 /** TEST_FILENAME test- */
  /** TEST_FILEEXT .java */
  /** TEST_PREFIX
  public class Test {
    public static int main(String[] args){
  */
  /** TEST_POSTFIX
    }
  }
  */
```

_**Note** the double star in the special multiline comment start, single space characters in the <tt>TEST_FILE*</tt> options and no other characters on the comment begin and end lines in the <tt>TEST_*FIX</tt> options._
