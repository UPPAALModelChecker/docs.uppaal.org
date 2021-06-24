---
title: ECDAR
---

## Language

To define timed I/O automata, timed game automata of TIGA with the following constraints are used:

*   Invariants may not be strict.
*   Inputs must use controllable edges.
*   Outputs must use uncontrollable edges.
*   All channels must be declared broadcast.
*   The system is implicitly input enabled due to broadcast communication but for refinement checking purposes, the relevant inputs must be explicit in the model.
*   In the case of parallel composition of several components, a given output must be exclusive to one component.
*   For implementations, outputs must be urgent.
*   For implementations, every state must have independent time progress, i.e., progress must be ensured by either an output or infinite delay.
*   Tau transitions (no output or input) are forbidden.
*   Global variables are forbidden.

The grammar for specifying property is given by:

```
Property := 'consistency:' System | 'refinement:' System '<=' System | 'specification:' System | 'implementation:' System  
System := ID | '(' System Expr ')' | '(' Composition Expr ')' | '(' Conjunction Expr ')' | '(' Quotient Expr ')'  
Composition := System '||' System | Composition '||' System  
Conjunction := System '&&' System | Conjunction '&&' System  
Quotient := System '\' System  
Expr := /* nothing */ | ':' tctl  
```

In particular the grammar can generate expressions of the type `refinement: (A || B) <= (C : A[] not C.unsafe)`. As a reminder the tctl formulas supported are

*   `A[ p U q ]`  
    For all path _p_ must be satisfied until _q_ with the twist (due to the game setting) that _p_ must still hold when _q_ holds.
*   `A<> q`  
    Equivalent to `A[ true U q ]`.
*   `A[ p W q ]`  
    The weak until variant.
*   `A[] p`  
    Equivalent to `A[ p W false ]`.
*   `A[] (p && A<> q)`  
    This is the Büchi objective formula with safety. for all path _p_ must always hold and _q_ must always be reachable from all states.
*   `A[] A<> q`  
    Equivalent to `A[] (true && A<> q)`.

The formulas involving a Büchi objective can be used to constrain the behaviours to be non-zeno by adding an observer automata that visits a state when time elapses.</e<=i)></div>

## Known Issues

  * When checking for refinement, inputs that are part of the alphabet of the processes must be put explicitly in the model for all locations of that process.
  * The graphical simulator determinizes the strategy and limits the game even though the underlying strategy is more permissive.
  * When a sub-formula is inconsistent there is no strategy. If you want a strategy you need to ask for a consistency check on that sub-formula.
  * If you use the quotient, you must add two locations to the processes, one Universal and one Inconsistent. The universal one must accept all inputs of that process and generate all outputs. This must match the signature of the component. The inconsistent location must be urgent without any transition at all.
  * It is not possible to simulate the quotient in the simulator. This is a limitation inherent to the problem because this operator generates new states and transitions that do not have references in the original model, thus the graphical simulator will be lost.
  * We suspect that it is possible to write models that may fool ECDAR by giving wrong answers. This may happen due to some issues with extrapolation. Please deactivate extrapolations and make sure that your model is bounded if you experience this.