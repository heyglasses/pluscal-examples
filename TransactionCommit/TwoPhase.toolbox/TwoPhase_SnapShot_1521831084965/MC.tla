---- MODULE MC ----
EXTENDS TwoPhase, TLC

\* CONSTANT definitions @modelParameterConstants:0RM
const_152183107994549000 == 
{ "r1", "r2", "r3" }
----

\* INIT definition @modelBehaviorInit:0
init_152183107994550000 ==
TPInit
----
\* NEXT definition @modelBehaviorNext:0
next_152183107994551000 ==
TPNext
----
=============================================================================
\* Modification History
\* Created Fri Mar 23 14:51:19 EDT 2018 by tbrunson6
