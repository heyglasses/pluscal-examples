---- MODULE MC ----
EXTENDS CarTalkPuzzle, TLC

\* CONSTANT definitions @modelParameterConstants:0N
const_15217488855399000 == 
40
----

\* CONSTANT definitions @modelParameterConstants:1P
const_152174888553910000 == 
4
----

\* Constant expression definition @modelExpressionEval
const_expr_152174888553911000 == 
AllSolutions
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_152174888553911000>>)
----

=============================================================================
\* Modification History
\* Created Thu Mar 22 16:01:25 EDT 2018 by tbrunson6
