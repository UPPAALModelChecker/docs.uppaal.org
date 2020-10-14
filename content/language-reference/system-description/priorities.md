---
title: Priorities
weight: 50
---

Given some priority order on the transitions, the intuition is that, at a given time-point, a transition is enabled only if no higher priority transition is enabled (see also [Semantics](../semantics/).) We say that the higher priority transition _blocks_ the lower priority transition.

Priorities can be assigned to the channels and processes of a system. The priority orders defined in the system are translated into a priority order on tau-transitions and synchronizing transitions. _Delay transitions are still non-deterministic_ (unless urgent channels are used.)

*   [Priorities on Channels](#priorities-on-channels)
*   [Priorities on Processes](#priorities-on-processes)
*   [Priorities on both Channels and Processes](#priorities-on-both-channels-and-processes)


## Priorities on Channels

``` EBNF
ChanPriority ::= 'chan' 'priority' (ChanExpr | 'default') ((',' | '<') (ChanExpr | 'default'))* ';'
ChanExpr ::= ID
           | ChanExpr '[' Expression ']'
```

A channel priority declaration can be inserted anywhere in the global declarations section of a system (only one per system). The priority declaration consist of a list of channels, where the '<' separator defines a higher priority level for channels listed on its right side. The `default` priority level is used for all channels that are not mentioned, including tau transitions.

**Note:** the channels listed in the priority declaration must be declared earlier.

### Example

``` c
chan a,b,c,d[2],e[2];
chan priority a,d[0] < default < b,e;
```

The example assigns the lowest priority to channels `a` and `d[0]`, and the highest priority to channels `b`, `e[0]` and `e[1]`. The default priority level is assigned to channels `c` and `d[1]`.

## Priorities on Processes

Process priorities are specified on the system line, using the separator '<' to define a higher priority for processes to its right. If an instance of a template set is listed, all processes in the set will have the same priority.

### Example

``` c
system A < B,C < D;
```

### Resolving Synchronization

In a synchronisation the process priorities are ambigous, because more than one process is involved in such a transition.

When several processes synchronize, the priority of the transition is given by the highest priority of the processes. This applies to both standard synchronization and broadcast.


## Priorities on both Channels and Processes

In a system with priorities on both processes and channels, priorities are resolved by comparing priorities on channels first. If they are the same, the process priorities are compared.