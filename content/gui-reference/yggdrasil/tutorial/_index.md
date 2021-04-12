---
title: Tutorial 
weight: 10
---

This tutorial shows how to use the Uppaal Test Cases Generator (Yggdrasil) to generate test scripts step-by-step. It assumes that you are familar with the basic syntax and semantics of Uppaal automata, the basic query language, and is able to use the model-editor. 

At the end of the tutorial you will be able to generate simple executable test cases.

The features for generating offline test cases are presented terms of two simple example systems: An On/Off system and an Up/Down counter. The behavior of these systems are generic, but could, respectively, represent a lamp with on/off capabilities and a dimmer lamp, which can be turned up or down. 

Both examples include a model, decorated with test-code, a (supposedly) correct implementation of the system, and a implementation mutant representing an implementation mistake. The system and mutant are implemented in Java so they should be platform independent.The generated test cases are output in Java and is, when compiled, executable on these implementations.  Execution scripts are included for Windows and Linux.

The necessary files are provided as part of the Uppaal distribution in the directory <tt> demo/yggdrasil/</tt>


The tutorial proceeds in 3 steps:

Continue to part two of this tutorial for explanation of how values of parameters can be used in test cases. 


1. [Basic Test Cases Generation](basic-test-generation)
2. [Test cases with model-variables](using-variables)
3. [Generating testcases using queries (test purposes)](using-queries)  

The concepts of TestGen is explained in the [Test Cases section](../).  

For comments or questions please contact Brian Nielsen <bnielsen@cs.aau.dk> or Marius Mikucionis <marius@cs.aau.dk>.