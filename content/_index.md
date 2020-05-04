# UPPAAL Help
[UPPAAL](http://www.uppaal.org) is a tool for modeling, validation and verification of real-time systems. It is appropriate for systems that can be modeled as a collection of non-deterministic processes with finite control structure and real-valued clocks (i.e. timed automata), communicating through channels and (or) shared data structures. Typical application areas include real-time controllers, communication protocols, and other systems in which timing aspects are critical.

The UPPAAL tool consists of three main parts:

  * a graphical user interface (GUI),
  * a verification server, and
  * a command line tool.

The GUI is used for modelling, symbolic simulation, concrete simulation, and verification. For both simulation and verification, the GUI uses the verification server. In simulation, the server is used to compute successor states. See also the section on setting up a remote server. The command line tool is a stand-alone verifier, appropriate for e.g. batch verifications.

More information can be found at the UPPAAL web site: http://www.uppaal.org.