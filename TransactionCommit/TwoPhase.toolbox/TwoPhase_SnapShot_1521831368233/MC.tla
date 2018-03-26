---- MODULE MC ----
EXTENDS TwoPhase, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
r1, r2, r3
----

\* MV CONSTANT definitions RM
const_152183136332256000 == 
{r1, r2, r3}
----

\* SYMMETRY definition
symm_152183136332257000 == 
Permutations(const_152183136332256000)
----

\* INIT definition @modelBehaviorInit:0
init_152183136332258000 ==
TPInit
----
\* NEXT definition @modelBehaviorNext:0
next_152183136332259000 ==
TPNext
----
=============================================================================
\* Modification History
\* Created Fri Mar 23 14:56:03 EDT 2018 by tbrunson6
