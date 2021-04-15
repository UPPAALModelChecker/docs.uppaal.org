---
title: Tutorial 
weight: 100
---

This tutorial shows how to use the Uppaal Test Generator (Yggdrasil) to generate test scripts step-by-step. It assumes that you are familar with the basic syntax and semantics of Uppaal automata, the basic query language, and is able to use the model-editor. 

At the end of the tutorial you will be able to generate simple executable test cases.

The features for generating offline test cases are presented terms of two simple example systems: An On/Off system and an Up/Down counter. The behavior of these systems are generic, but could, respectively, represent a lamp with on/off capabilities and a dimmer lamp, which can be turned up or down. 

Both examples include a model, decorated with test-code, a (supposedly) correct implementation of the system, and a implementation mutant representing an implementation mistake. The system and mutant are implemented in Java so they should be platform independent. The generated test cases are output in Java and is, when compiled, executable on these implementations.  Execution scripts are included for Windows and Linux.

The necessary files are provided as part of the Uppaal distribution in the directory <tt>demo/testcases/</tt>.

The tutorial proceeds in three steps:
1. [Basic Test Cases Generation](basic-test-generation). Here you will learn the basic steps involved in annotating the model with test code, and generating simple test cases.
2. [Test cases with model-variables](using-variables). Here you will learn how to insert the values of model variables into the test code, and how to generate a covering test suite.  
3. [Generating testcases using queries (test purposes)](using-queries). Here you will learn to generate test cases based on test purpose queries. 

The concepts of Test Cases generation is explained in the [Test Cases section](../).  

For comments or questions please contact Brian Nielsen <bnielsen@cs.aau.dk> or Marius Mikucionis <marius@cs.aau.dk>.
