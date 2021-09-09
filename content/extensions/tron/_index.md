---
title: UPPAAL TRON
---

## Requirements
TRON requires Unix environment and GNU C++ compiler (g++) or Microsoft Visual Studio or Sun Java 1.5 for creating custom adapters. It has been built on Debian GNU/Linux SID (unstable) and also for Windows in Cygwin environment using g++ from MingGW so it's very likely to work with C-library adapters built there. There's a small example C-library adapter built by Microsoft compiler, however currently it is only useful to connect to real IUTs in real-time, the virtual-time framework won't work in Windows, unless through TCP/IP socket adapter. Here is the dependency list with Debian package names in parenthesis:

  * Java 2 Standard Development Kit 1.5 (AKA J2SDK 5.0) from http://java.sun.com/. Used by: TRON Tracer GUI, smart-lamp. Earlier Java versions won't work.
  * Dot/Graphviz (graphviz) from http://www.graphviz.org/. Used by: TRON Tracer GUI.
  * R (r-base) from http://www.r-project.org/. Used by: latency.
  * GhostView (gv) from http://wwwthep.physik.uni-mainz.de/~plass/gv/. Used by: latency.

Install them all on Debian: `apt-get install g++ libstdc++6 graphviz r-base gv`

## Status of the Project

Now Uppaal TRON version 1.4 Beta 1 is available. The tool is still in early development and experimental phase, but now anyone can checkout and taste the early fruits on his/her own. The current version is based on the latest Uppaal 4.1. Current availability and limitations:

  1.  System specification accepted in <span class="sc">Uppaal</span> xta and xml format. The interface is specified separately in adapter library code.
  2.  Supported main <span class="sc">Uppaal</span> features: clocks, data variables, paired channel synchronizations, urgent locations. The use of arrays, broadcast channel, and committed locations are experimental and not tested.
  3.  Input and output actions through channel handshake synchronization (no buffering or value passing).
  4.  User supplied adapter loading via dynamic library interface.
  5.  Adapter development framework (C++), interfaces are not completely stabilized yet.
  6.  Examples of tool applications against C++ programs as IUT.
  7.  Use <span class="sc">Uppaal</span> to create and edit models.
  8.  TRON Tracer GUI demonstrates the main concepts: system model partitioning, interactive traces in testing, system emulation and monitoring.
  9.  Graphical user interface is mounted on generic trace-interpreter-adapter (special IUT adapter library) and serves as generic example of how to connect/link to TRON.
  10.  Stripped binary executable form of <span class="sc">Uppaal TRON</span>. No source code provided due to [licensing](#licens) restrictions. Binary is dynamically linked in order to provide efficient connectivity with user-supplied adapter.
  11. The tool is prepared on the following platforms:
  *   Windows 2000 Professional, GNU Compiler Collection 3.4.5
  *   Linux 2.6.18 on Intel PC, GNU Compiler Collection 4.1.2  
  <br/>Latest builds for Sun Solaris could also be provided upon request. It is important that the machine architecture should match and GCC-2 should not be mixed with GCC-3\. The same holds for GCC-4. Please report your experiences.

## User Manual 

You may want to read an early draft of [user-manual](manual.pdf) (still under development, comments are welcome).

## Testing Runtime

### Command Line Options

TRON binary is based on <tt>verifyta</tt> utility from Uppaal, hence there are a few options available to tune the Uppaal engine too. I will explain only TRON specific ones and some of <tt>verifyta</tt> that might effect testing. The following is printed on screen when TRON is run in command line:

<pre>./tron -h
Usage: tron [options] -I adapter model.xml [-- parameters to adapter]
Options:
  -A  Use convex-hull approximation.
  [-D filename](#D)
      specify a file for driver log (default /dev/null).
  [-F future](#F)
      The amount of future in mtu to be precomputed (default 0),
      To disable precomputation set it to -1 (not recommended).
  [-H n](#H)
      Set the hash table size for bit state hashing to 2**n
      (default = 27)
  [-I filename](#I)
      dynamic C-library with adapter to an implementation, or:
      TraceAdapter -- interact via textual stdin/stdout;
      SocketAdapter -- remote TCP/IP socket adapter.
  [-P delay](#P)
      short,long: try random delay from one of intervals (mtu),
      eager: delay as little as possible for chosen transition,
      lazy: delay as much as possible for chosen transition,
      random: delay within bounds specified by model (default).
  [-Q log](#Q)
      use logical (simulated) clock instead of host clock.
      or specify port number for simulated clock: -Q 6521
  [-S filename](#S)
      Append the verdict, I/O and duration to file (default /dev/null)
  -U  Unpack reduced constraint systems before relation test.
  -V  Print version information and exit.
  [-X integer](#X)
      Value to initialize random number generator (default time)
  -h  Print this message.
  [-i <dot|gui>](#i)
      Print a signal flow diagram of the system and exit:
        dot: outputs dot graph, expects formated standard input:
             "input" (channel)* "output" (channel)*
        gui: non-partitioned flow information for TRON GUI;
  [-o filename](#o)
      Redirect output to file instead of stdout, see also -v
  -s <0|1|2>
      Select search order.
        0: Breadth first (default)
        1: Depth first
        2: Random depth first
  [-u inpDelay,inpRes,outDelay,outRes](#u)
  -u inpRes,outRes
      Observation uncertainty intervals in microseconds:
      inpDelay: the least delay that takes to deliver input,
      inpRes:   possible additional delay for delivering input,
      outDelay: the least delay that takes to observe output,
      outRes:   possible additional delay for observing output.
  [-v <0+1+2+4+8+16>](#v)
      Specify verbosity of the output.
      For -o test logging verbosity bit-flags:
        = 0: only verdict, disable trace output (default),
        & 1: progress indicator for interactive experiments,
        & 2: test events applied in the UPPAAL engine,
        & 4: available input and delay choices for simulation,
        & 8: backup state set and prepare for final diagnostics,
        &16: dumps current state set on each update.
      [For -i partitioning: 0-none, 1-errors, 2-warnings, 3-diagnostics](#iv).
  [-w integer](#w)
      Specify additional number of time units to attempt to violate invariants.
      Works under assumption that invariants are not used in Environment.
  -q  Do not display the copyright message.

Environment variables:
  UPPAAL_DISABLE_SWEEPLINE   disable sweepline method
  UPPAAL_DISABLE_OPTIMISER   disable peephole optimiser
  UPPAAL_OLD_SYNTAX          use version 3.4 syntax

The value of these variables does not matter. Defining them is
enough to activate the feature in question.</pre>

Here is a more detailed description of testing specific options:

*   <tt>-I filename</tt> specifies the adapter to connect to **I**UT. It is either the name of a built-in adapter (such as TraceAdapter and SocketAdapter) or the filename of dynamically loaded C-library. See [Building Test Adapter](http://scenic33.e.cs.aau.dk/~marius/tron/adaptation.html#adapter) on how to make one.
*   <tt>-D filename</tt> specifies where the output of the **D**river (component that time-stamps input and output events) should be redirected to. The EBNF of the output is the following:

    <pre>DriverLog ::= ( line **EOL** )*
    line ::= timestamp | event
    timestamp ::= **"delay"** integer
    event ::= channelname **"("** paramlist **")"**
    paramlist ::= | integer ( **","** integer )*</pre>

    The <tt>timestamp</tt> line means that the system has delayed until the specified absolute time moment in microseconds counting from the beginning of testing. The <tt>event</tt> line means an input or an output event observation at the last delay timestamp in the driver. The specific input or output nature is specified by channel name and the bounded variable integer values.
*   <tt>-S filename</tt> specifies where the verdict information should be saved (usually used for gathering **S**tatistics of many TRON runs). If specified, each line of the file will consist of five elements: 1) integer for random seed used (see <tt>[-X](#X)</tt>) 2) verdict 3) number of inputs 4) number of outputs 5) time used in model time units.
*   <tt>-v <0+1+2+4+8+16></tt> specifies what testing information should be visible on the output by bit-flags:
    *   <tt>1</tt> progress indicator, useful in interactive command-line when no other testing information is specified;
    *   <tt>2</tt> events applied in Uppaal engine (mainly for debugging);
    *   <tt>4</tt> choices considered when emulating the environment;
    *   <tt>8</tt> makes a copy of the current state set before applying delay and output events, this enables some diagnostic information when test verdict is failed or inconclusive but also costs a bit of additional memory;
    *   <tt>16</tt> shows the current reachable state set before each update.The numbers above should be added and final integer result used in <tt>-v</tt> option. For example, for progress indicator (1) and diagnostic information (8) one should use <tt>-v 9</tt> as 1+8=9.
*   <tt>-o filename</tt> redirects the testing information (specified by <tt>-v</tt>) to the file rather than standard output stream.
*   <tt>-H n</tt> specifies the size of hash table in Uppaal engine for detecting loops in passed list states (as in verifyta), the size in testing can be much smaller as the TRON considers only the current reachable state set which is much smaller than the whole state space of the system (as in verification process);
*   <tt>-F future</tt> specifies the future input event horizon for environment emulation in model time units, the further horizon the more TRON should pre-compute into the future when choosing input event; the value should be as large as possible for richer input choices but small enough for TRON to be able to compute respond within 1 model time unit; the default is 1 model time unit (disabling it with 0 is not recommended);
*   <tt>-P delay</tt> constrains the choice of delay by the following heuristics:
    *   <tt>random</tt> the choice is based on available delays in the model and concrete delay is chosen by pseudo-random number generator; if delays are not bounded by invariant TRON may choose very large delays and hence appear idle for very long time;
    *   <tt>lazy</tt> the choice is based on available delays in the model and concrete delay is taken by choosing the longest possible; TRON may delay for very long if constraints (invariants) allow it;
    *   <tt>eager</tt> the choice is based on available delays in the model and concrete delay is taken by choosing the shortest delay possible;
    *   <tt>short,long</tt> are integers and specify the longest delay choice for short and long delay. The concrete delay is then chosen randomly based on the model and longest possible delay. The choice of a short or a long delay is random;
*   <tt>-w integer</tt> prolongs the model delay by specified number of model time units possibly breaking the invariants in the model; it was created as a workaround for proper IUT and environment invariant separation to be able to test the IUT invariants under assumption that the environment model did not contain any invariants; today correct partitioning (see [Test Interface Specification](adaptation.html#iface)) of the system model is recommended instead of this option;
*   <tt>-u inpDelay,inpRes,outDelay,outRes</tt> see [Observation Uncertainties](adaptation.html#obs) for explanation.
*   <tt>-Q log</tt> specifies that virtual time framework should be used rather than host machine's clock, string <tt>log</tt> can also be replaced by an integer meaning the port number for external virtual clock users, see [Virtual Time](adaptation.html#virtual) for more details;
*   <tt>-X integer</tt> specifies the value of random seed for the random number generator which drives the environment emulation choices; it could be useful to attempt to replicate an identical test run although it is very hard to ensure the same flow of time and event interleaving;
*   <tt>-i <dot|gui></tt> generates the signal flow of the system model in [graphviz](http://www.graphviz.org) format; when specified, TRON expects the input/output interface to be fed into standard input stream in the following EBNF format:

    <pre>TIS ::= inputs outputs precision timeout
    inputs ::= **"input"** channels **";"**
    outputs ::= **"output"** channels **";"**
    precision ::= **"precision"** integer **";"**
    timeout ::= **"timeout"** integer **";"**
    channels ::= | channel ( **","** channel )* **";"**
    channel ::= channelname **"("** variables **")"**
    variables ::= | variablename ( **","** variablename)*</pre>

    See also [Test Interface Specification](adaptation.html#iface). When <tt>-i</tt> is specified, <tt>-v</tt> option has a different special meaning:
*   <tt>-v <0|1|2|3></tt> specifies what information is produced in partitioning (<tt>-i</tt>) mode: 0 -- silent, no errors are shown, 1 - only errors are shown, 2 - warnings are shown, 3 - errors, warnings and rules being applied are shown. See also [Test Interface Specification](adaptation.html#iface).

### Interpreting Messages

Here is the beginning of output from smart lamp demo:
<pre>
1.  UPPAAL TRON 1.4 Beta 2 using UPPAAL 4.1.0 (rev. 2765), October 2006
2.  Compiled with g++-4.1.2 -Wall -DNDEBUG -O2    -DBOOST_DISABLE_THREADS
3.  Copyright (c) 1995 - 2006, Uppsala University and Aalborg University.
4.  All rights reserved.
5.  Options for the UPPAAL engine:
6.    Search order is breadth first
7.    Using no space optimisation
8.    State space representation uses minimal constraint systems
9.    Observation uncertainties: 0, 0, 0, 0 (microseconds).
10.   Future precomputation: closure(300 mtu).
11.   Input delay extended by: 0
12.   OS scheduler: non-real-time.
13. socket connect: Connection refused
14. (* 9 tries left *)
15.   Environment processes: user.
16.   Timeunit: 10000us
17.   Timeout: 1000000mtu
18.   Inputs: grasp(), release()
19.   Outputs: level(adapLevel)
</pre>

Lines 1-2 specify the version and the build environment of TRON binary, might be important when building the C-library adapter. Lines 3-4 contain copyright information. Lines 5-11 show the state of Uppaal engine and TRON options. Line 12 says that TRON is using non-real-time process scheduler which is used for all virtual time runs. In real time mode TRON will attempt to gain high priority and select real-time round-robin scheduler if possible (available and enough permissions given), which would minimize the scheduling disturbances from other processes. Lines 13-14 show that TRON attempted socket connection (to IUT) but failed and it will retry doing so for 9 times with 2 second intervals. Lines 15-19 show the model partitioning and testing interface information: environment consists of just _user_ process (_user_ invariants will be considered when offering input), model time unit is interpreted as 10000 microseconds, and 1000000 model time units are allocated for testing.

The messages are typical from TRON standard output stream when bit-flag 2 is selected in <tt>-v</tt> option:

<pre>
1.  TEST: delay to [245.. on 1
2.  TEST: grasp()@1225896-1225940 at [245..246) on 1
3.  TEST: level(0)@1771740 at [353..356) on 5
4.  TEST: level(1)@2752912 at [549..552) on 3
5.  TEST: level(2)@3777576 at [755..756) on 3
6.  TEST: level(3)@4798399 at [959..960) on 3
7.  TEST: delay to [1153.. on 3
8.  TEST: delay to [1159.. on 3
9.  TEST: release()@5798049-5798094 at [1159..1162) pre>
10. TEST: delay to [1169.. on 13
11. TEST: delay to [1175.. on 13
</pre>

Lines 20, 26-27, 29-30 mean that TRON has chosen a delay and nothing happened until it has expired, for example line 20 says that TRON is applying a delay on a current state set to the moment of 245 model time units on a single (1) state in a set, the upper bound of a delay is open and bounded only by future horizon (see <tt>[-F](#F)</tt>). Line 21 says that TRON is applying the input event on channel _grasp_ it has just executed at time interval 1225896-1225940 microseconds which is mapped to model time interval [245..246) in Uppaal constraint encoding. The encoding [245..246) means a model time interval (122,123) as 245/2=122.5 (remainder shows that the constraint is strict, i.e. >122, and the point 122mtu is not included) and 246/2=123 which is strict as ")" in the log. The same mapping and encoding procedure applies to outputs on lines 22-25 which show that output events on channel _level_ have variable values attached (0, 1, 2 and 3). The output is time-stamped right after it is registered in the driver. The inputs are time-stamped with two time-stamps: just before offering an input and right after the input is offered, to reflect an over-approximation and uncertainty on when exactly it was actually delivered at (remote) IUT.

### Verdict Assignment and Diagnostics

At the end of testing TRON will issue a verdict, which is either _PASSED_, _INCONCLUSIVE_ or _FAILED_. _PASSED_ means that the timeout for testing has expired and no faulty behavior has been detected. Test may fail with verdict _FAILED_ if IUT exposes the behavior which could not be mapped in the model of IUT, i.e. if IUT reported wrong output at wrong time (too early or too late) or IUT did not respond at all when it was required to respond with some output. In case of _INCONCLUSIVE_ verdict, TRON is either 1) confused with the output observed from IUT, cannot map this output to the model of environment and hence does not know how to continue testing or 2) late for delivering an input in time as required by the model of environment. The second option can be very frequent on heavily loaded machines, broken schedulers (Windows tend to issue spurious timeouts even if timeout did not expire) while testing in real time using the host machine's clock. Also it is still not clear how to handle situations when TRON and IUT rely on different clocks which drift away from each other, hence we rely on assumption that TRON is operating on a correct (reference) clock.

TRON can also provide additional information on why the test ended up with verdict _FAILED_ or _INCONCLUSIVE_ if the bit-flag 8 is specified on <tt>[-v](#v)</tt> option. The following is a typical output of such diagnostic information:

<pre>
1.  Short post-mortem analysis based on last good stateSet(3):
2.  1)
3.  ( interface.touching switch.idle dimmer.PassiveUp user.busy graspAdapter._id26 ... )
4.  interface.x>47, dimmer.x>260, user.z>52, graspAdapter.x>52, ...
5.  on=1 iutLevel=5 OL=7 adapLevel=5 user.L=5
6.  2)
7.  ( interface.holding switch.idle dimmer._id10 user.busy graspAdapter._id26 ... )
8.  interface.x>=50, user.z>52, graspAdapter.x>52, releaseAdapter.x>162, ...
9.  on=1 iutLevel=7 OL=7 adapLevel=5 user.L=5
10. 3)
11. ( interface.holding switch.idle dimmer.Up user.busy graspAdapter._id26 ... )
12. interface.x>=50, user.z>52, graspAdapter.x>52, releaseAdapter.x>162, #t>5937, ...
13. on=1 iutLevel=7 OL=7 adapLevel=7 user.L=5
14.   Options for input   : (empty)
15.   Options for output  : level@[11875..11894)
16.   Options for internal: starthold@[11875..13770), setLevel@[11875..11890)
17.   Options for delay   : ..13770)
18.   Last time-window    : [11987..11990)
19. Could not delay any more (to the last time-window).
20. Output expected: level(7)@0-0[11875..11894)
21. TEST FAILED: IUT failed to produce output in time
22. Time elapsed: 5993 tu = 59.939325s
23. Time    left: 994007 tu = 9940.060675s
24. Random  seed: 1163420344
25. AdapterConnection died: socket closed upon read
</pre>

Line 31 says the following analysis is based only on the last good state (might be inaccurate if fault happened much earlier than observed) consisting of 3 symbolic states. Lines 32-43 enumerate the symbolic states (it can be very long, this is a shortened version of it), for example line 32 specifies the symbolic state number 1, line 33 says in which control locations the processes are, line 34 enumerates clock constraints and line 35 enumerates values of integer variables. Lines 44-47 reiterates what options TRON was facing just before test has terminated: line 44 says that there could be no inputs offered, line 45 says that according to model the output _level_ is expected at model time interval (5937,5947) (as 11875/2=5937.5 and 11894/2=5947 in Uppaal encoding), line 46 enumerates internal transitions available in the model, line 47 specifies the longest possible delay until 6885mtu without observable input/output. Line 48 says that TRON was trying to compute the reachable symbolic state set for the interval (5993,5995), but according to line 49 it could not, as the resulting symbolic state set contained no states. Line 50 notes that there was _level(7)_ output expected at (5937,5947) therefore the conclusion in line 51 is that IUT failed to produce output (in required time). Lines 52-53 show how long test was running and how much left to testing timeout in model time units and seconds. Line 54 shows the random seed used to start the pseudo-random number generator (see <tt>[-X](#X)</tt> option). Line 55 contains spurious exception upon disposing _SocketAdapter_ which can be safely ignored.

As of version 1.4 be aware of [bug 369](http://bugsy.grid.aau.dk/cgi-bin/bugzilla/show_bug.cgi?id=369) in diagnosis.


## Adaptation

In this section we are going to show the adaptation process for TRON framework. We are going to use the smart lamp [light controller](examples.html#lamp) example to highlight the supported features and to show how to use them.

### Model Specification

TRON supports abstract requirement models in a sense that implementation under test (IUT) does not necessarily have to follow the structure of the model. User should use [Uppaal](http://www.uppaal.org) to specify requirements by creating a timed automata model of the whole (closed) system, i.e. the model should contain requirements for the IUT and also the assumptions about its environment (user). The processes in [Uppaal](http://www.uppaal.org) timed automata network communicate via channels. Every channel synchronization is an instantaneous event in the system, taking zero time as any other transition. So the simplest closed system suitable for testing using TRON consists of at least two communicating processes: IUT process and environment process. In this simple system the input event is fired whenever environment process shouts at some channel and IUT receives the channel synchronization, the output happens in the same manner but opposite direction.

The model of environment can be as simple as one process containing one location with a synchronized transition loop for each input/output channel synchronization. Such environment would test the most of IUT features/requirements as it is fully permissive, however this might be too expensive and unrealistic, especially if environment assumptions can be stated more precisely, e.g. modeling some case of system usage. It is important that environment is input enabled, i.e. it is able to consume any possible output produced by IUT, otherwise **TRON will issue verdict "inconclusive" in case the received output event cannot be applied to environment**.

In a more complex system the IUT (and environment) requirements may be modelled by many processes. In this case the system is partitioned into two sets of processes: the processes modelling the requirements for IUT (model of IUT) typically mimicking what the IUT should do and the processes for the environment assumptions (model of environment) mimicking what the tester should do. The IUT (environment) processes may communicate among themselves by channel synchronizations too, but such communication is treated as internal and not observable. The channel synchronization is treated as observable input/output event if and only if it is between the environment and IUT processes.

As noted before, the channel synchronization is an instantaneous event in timed automata network, hence the communication between the environment and the IUT is also treated as instantaneous. However real-time black-box testing is also a kind of remote testing, where the inputs/outputs are fed at one time instance and received slightly later as there is at least small communication delay. Even the slightest delay of electronic signal running short distance at a speed of light is significant as it might imply a different input and output event interleaving and hence a different outcome. The communication delay is especially significant on soft-real-time operating systems (such as Windows and Linux) where the process scheduling is a major contributor but is hardly predictable (Linux scheduler tries hard to be at most 10ms late and 2.6 branch usually fits into 1ms delay under low load conditions, see [Latency Experiments](examples.html#latency)). Currently **TRON time-stamps the input and output events when they arrive/leave TRON process**, hence the **model of IUT should also include the processes of adapter proxying and slightly delaying the actual input and output** to reflect such communication reality. The model of adapter also helps to make sure that the model of IUT is input enabled, i.e. IUT cannot refuse to accept the offered input, which might be important in testing features that are triggered only by that particular input (and time). **TRON will not try to offer an input if the model of IUT is not able to consume it**.

The model of the system should be validated in the [Uppaal](http://www.uppaal.org) symbolic simulator to make sure the model reflects an intended system behavior and the verifier should be used to check at least that model does not contain deadlocks ("A[] not deadlock" must be satisfied). In extreme cases where system state space is too large and cannot be verified (e.g. adapter processes involve queueing of input/output events and hence blowup the state space), a more abstract version of the model should be verified. **TRON might issue verdict "inconclusive" or "failed" if it runs into deadlock situation and/or give unreliable "last good state set" diagnostic information if deadlock is present but was avoided by taking other transitions**.

**Example.** Consider the smart lamp demo with the following model of the system: [LightContr.xml](LightContr.xml) (you are encouraged to load it into [Uppaal](http://www.uppaal.org)). I will use the signal flow diagram [LightContr.png](LightContr.png) to demonstrate how processes in this system communicate (see [Test Interface Specification](#iface) to produce signal flows of your own). The legend of this signal flow diagram is as follows: ellipse means process, rectangle means integer variable, diamond means channel, arrows indicate the flow of signal, i.e. process transmit on given channel if arrow is from ellipse to diamond, process receives on given channel if arrow is from diamond to ellipse, variable is being written by process if arrow points from ellipse to rectangle and variable is being read if arrow is from rectangle to ellipse. The labels on arrows indicate the channel synchronization when variable is accessed, dash means silent (internal) access without channel synchronization. TRON uses the observable input/output channel (double diamonds) declaration (see [Test Interface Specification](#iface)) to partition the system into the model of environment (light green items) and the model of IUT (light blue items). In this example, environment consists of _user_ process communicating through input channels _grasp_ and _release_ and output channel _level_. The requirements for IUT are modeled by _interface_, _dimmer_ and _switch_ processes. The communication delay is modeled by _levelAdapter_, _releaseAdapter_ and _graspAdapter_ processes.

### Test Interface Specification

Test interface is a set of observable input and output channels possibly with integer variables values bound to channel. Observable input and output channels define how the system model is partitioned into the model of IUT and the model of environment. The correct system partitioning is important in order to ensure correct verdict computation by using relativized timed input/output conformance relation (which means identifying and special treatment of IUT invariants which might interact with environment model as invariants are global in [Uppaal](http://www.uppaal.org) semantics). The idea of correct partitioning is a complete and consistent separation of environment model and IUT model by inspecting the following control rules:

1.  Channels, that are not declared as inputs/outputs, are non-observable called internal.
2.  Internal channel belongs to environment (IUT) if it is used by environment (IUT) process (respectively). Model is inconsistent and cannot be partitioned if the internal channel is used by both environment and IUT.
3.  Process belongs to environment (IUT) if it uses the internal environment (IUT) channel (respectively).
4.  Variable belongs to environment (IUT) if it is accessed by environment (IUT) process without observable input/output channel synchronization. Variable is not cathegorized (can be either) if accessed consistently only during observable input/output channel synchronization.
5.  Process belongs to environment (IUT) if accesses environment (IUT) variable (respectively) without observable channel synchronization.

It might be tricky to get complete and consistent (all processes are assigned to either IUT or environment) partitioning. Currently the adapter API is the only way to specify the test interface. The easiest way to experiment with test interface and partitioning is by generating signal flow diagram of the system. The signal flow diagram in [graphviz](http://www.graphviz.org/) format can be obtained from TRON standard output with <tt>-i dot</tt> option on specific [Uppaal](http://www.uppaal.org) model and entering the test interface information via standard input in the following tiny EBNF grammar (terminals are quoted in bold, this grammar is also used in _TraceAdapter_):

<pre>TIS ::= inputs outputs precision timeout
inputs ::= **"input"** channels **";"**
outputs ::= **"output"** channels **";"**
precision ::= **"precision"** integer **";"**
timeout ::= **"timeout"** integer **";"**
channels ::= | channel ( **","** channel )* **";"**
channel ::= channelname **"("** variables **")"**
variables ::= | variablename ( **","** variablename )*</pre>

Here, the precision specifies the duration of one model time unit (mtu) in microseconds and timeout specifies how many model time units is allocated for testing. **Upon success TRON will terminate with verdict "passed" when <tt>precision × timeout</tt> microseconds elapse and no fault is found.**

**Example**. The following command lines produce signal flow in [graphviz](http://www.graphviz.org/) format which is further laid-out onto the PNG picture format by [dot](http://www.graphviz.org/Documentation/dotguide.pdf) utility, the third line does it all in one:

<pre>tron -i dot [LightContr.xml](LightContr.xml) < [LightContr.trn](LightContr.trn) > [LightContr.dot](LightContr.dot)
dot -Tpng -o [LightContr.png](LightContr.png) [LightContr.dot](LightContr.dot)
tron -i dot [LightContr.xml](LightContr.xml) < [LightContr.trn](LightContr.trn) | dot -Tpng -o [LightContr.png](LightContr.png)</pre>

Note that TRON also adds a few constraints for the graph layout in dot file, in particular it specifies landscape A4 paper, which is handy for <tt>-Teps</tt> option but might not be good for some larger models.

If partitioning is not complete (some process, variable or channel is assigned to neither IUT nor environment) or inconsistent (according to rules some item is assigned to both IUT and environment) then TRON will write complains and warnings to the standard error stream. The verbosity of partitioning messages is controlled by <tt>-v</tt> option: <tt>-v 0</tt> -- none, <tt>-v 1</tt> -- errors, <tt>-v 2</tt> -- warnings, <tt>-v 3</tt> -- diagnostics. The diagnostic messages will show how TRON is trying to partition the processes, variables and channels by iteratively applying the control rules. It is also recommended to check the separation in the output stream from TRON once the test interface is specified during testing.

Currently (as of version 1.4 Beta 2) the variable usage in C-code functions is not analyzed, hence partitioning might work incorrectly. Also observable broadcast channels should be used with caution (IUT/environment cannot send and receive at the same time on observable broadcast channel). The source code for signal flow static analysis and partitioning will probably be available in the next release of [UTAP library](https://github.com/uppaalmodelchecker/utap).

### Observation Uncertainties

TRON is applying observable input and output events by the following algorithm: 1) time-stamp the event with the host machine clock, 2) convert to a model time representation in floating point number form 3) find the closest integers to the given floating point number 4) apply input/output event to the model state space as if it happened between the closest integers time points. Observation uncertainty is a tweak for such time-stamping scheme, which expands and shifts the time-stamping interval: the output event is expanded to the direction of past (as if it happened earlier than observed), the input event is expanded to the direction of future (as if it will happen later than it is actually sent). The observation uncertainty was an early idea to reduce state space explosion due to adapter models and still be able to handle the communication and scheduling latency.

The observation time uncertainty can be specified by <tt>-u</tt> option, see the output of <tt>tron -h</tt>. The parameters _inpDelay_ and _outDelay_ control how many microseconds the event time window is shifted and parameters _inpRes_ and _outRes_ specify how many microseconds the window is be expanded, which potentially might touch or cover a next time unit(s). Current implementation (1.4 Beta 2) does not treat the time-stamp shifts correctly as it is required to create a hole in a state space between possible outputs in the past and possible inputs, hence requires a more complicated state exploration algorithm. Values other than 0 for _inpDelay_ and _outDelay_ are not recommended. The values for _inpRes_ and _outRes_ should reflect the scheduling and communication latency, e.g. allow about 3000-4000 microseconds on Linux-2.6 (may vary on different machines).

Observation uncertainty is relevant only in testing in real world time and is irrelevant in virtual time.

### Building Test Adapter

Normally, when TRON process is launched for testing the following happens:

1.  TRON parses and sets the command line options
2.  TRON looks for [Uppaal](http://www.uppaal.org) timed automata model and loads it.
3.  TRON looks for adapter specified and attempts to create it via constructor call by passing a reporter object handle.
4.  Adapter constructor establishes connection to IUT (possibly launching another IUT process/thread, or simply connecting to remote IUT process).
5.  Adapter constructor configures the testing interface by declaring observable input/output channels, binding needed variables, sets the precision and the timeout for testing and returns the adapter handle to TRON.
6.  TRON statically analyzes the model and partitions the system into IUT and environment.
7.  TRON calls <tt>adapter.start()</tt> routine to indicate that no problems were found, adapter should finish any initializations and testing begins from the moment thread returns to TRON.
8.  Further input and output communication is asynchronous in a sense that IUT should use its own thread to report outputs to the reporter (which in turn will time-stamp and queue it) and TRON will call the method to register input (IUT is expected to add input to its input queue, notify its thread and return as soon as possible). **Caution: adapter interface may deadlock if the same input-offering-thread (from TRON) is used by adapter to report the output from IUT. It is also important to release the lock on input queue (if any) in IUT adapter when reporting outputs to allow TRON to offer input while the output is being reported.**
9.  After test is finished (via timeout or failure), TRON calls the adapter destructor to disconnect from IUT, cleanup and release all the resources.

Currently there are a few different adapter examples available as reference implementations, depending on platform and adapter method the actual action names may differ:

*   Textual communication via standard I/O adapter (virtual time recommended). See source code using _TraceAdapter_ in tracer directory under GNU environment (requires bash, GNU make, use [Cygwin](http://www.cygwin.com/) if on Windows). _TraceAdapter_ uses the ANTLR [lexer](trace_lexer.g) and [parser](trace_parser.g) to read the standard input stream (see how "make testsuite" example works for example traces accepted by _TraceAdapter_, it's even possible for human to interact with TRON).
*   TCP/IP socket adapter for remote IUTs (both: virtual and real time). See Java source code of smart-lamp using _SocketAdapter_ in java directory, [java-doc](https://people.cs.aau.dk/~marius/tron/java-doc). Remote adapter implementation in C/C++ can also be provided upon a request.
*   Microsoft Visual C library adapter example (currently only real time). See source code of mouse button example in MSVC directory.
*   GNU C library adapter example on Unix (both: virtual and real time). See source code of mouse button example in button directory.

### Virtual Time

Much of real-time control software concerns mainly correct timing and functional behavior and time spent on computation is negligible or predictable. TRON's virtual time framework offers a possibility to test a real-time application in laboratory conditions where time flow is controlled, i.e. time is allowed to flow when all processes are explicitly waiting and is stopped when at least process is busy computing. Virtual time framework has an advantage that otherwise inherent latencies (OS scheduling, communication) are removed.

The idea is based on a concept of monitor, where mutex locking and unlocking wrap a negligible amount of atomic computations and temporary mutex release by waiting on conditional variable reflects the process' intent to delay and wait for a specific condition.

By default TRON assumes host machine's real time clock and virtual time clock can be turned on by option <tt>-Q log</tt> which also opens a server socket on port 6521 to serve any remote request for virtual clock. User can also change the port number to 1234 by using option <tt>-Q 1234</tt> instead, just make sure that remote IUT will also use the same port number. Reference Java client implementation of remote virtual time clock can be found in java/tron/VirtualThread.java file.

#### POSIX C Example

POSIX (Portable Operating System Interface for uniX) way of creating a monitors is by using <tt>pthread_mutex_lock</tt>, <tt>pthread_mutex_unlock</tt>, <tt>pthread_cond_wait</tt> and <tt>pthread_cond_timedwait</tt> functions (see their manual pages e.g. on your Linux distribution). TRON binary (on Linux) exports the following substitute functions which call the OS's POSIX layer when testing in real time and uses virtual TRON's clock when testing in virtual time:

*   tron_thread_create instead of pthread_create
*   tron_mutex_init instead of pthread_mutex_init
*   tron_mutex_destroy instead of pthread_mutex_destroy
*   tron_mutex_lock instead of pthread_mutex_lock
*   tron_mutex_unlock instead of pthread_mutex_unlock
*   tron_cond_init instead of pthread_cond_init
*   tron_cond_destroy instead of pthread_cond_destroy
*   tron_cond_wait instead of pthread_cond_wait
*   tron_cond_timedwait instead of pthread_cond_timedwait
*   tron_cond_signal instead of pthread_cond_signal
*   tron_cond_broadcast instead of pthread_cond_broadcast
*   tron_gettime instead of gettimeofday

There are also functions to temporarily remove the current running thread from virtual time accounting and put it back to the pool of virtual time threads: <tt>tron_thread_deactivate</tt> and <tt>tron_thread_activate</tt>. These functions are not normally used, and exist only to simplify design of remote adapters like SocketAdapter.

#### Java Example

Example in java directory provides <tt>tron.VirtualLock</tt> class for controlling the state of (potentially remote) lock and creating <tt>tron.VirtualCondition</tt> variables. TRON's monitor paradigm is very similar to Java's synchronized methods, except that all participating threads should be created via <tt>tron.VirtualThread</tt> object, locking, unlocking, waits and notifications (signals) should be done explicitly on corresponding VirtualLock and VirtualCondition objects. See [java-doc](java-doc) for more.
