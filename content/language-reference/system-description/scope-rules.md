---
title: Scope Rules
weight: 60
---

The scope rules determine which element a name refers to in a given context. The context is either local (to a process template), or global (in a system description).

In a local context, the names are always referring to local declarations or formal parameters (if the name is locally defined), otherwise to a globally declared name.

In the global context, a name is always referring to a global declaration.

**Note:** There is only one name space in each context. This means that in each context all declared clocks, integer variables, constants, locations, and formal paramters must have unique names. However, local names may shadow globally declared names.