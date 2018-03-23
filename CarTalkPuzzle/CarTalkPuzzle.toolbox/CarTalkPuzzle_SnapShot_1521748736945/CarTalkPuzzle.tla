--------------------------- MODULE CarTalkPuzzle ---------------------------
EXTENDS Integers
CONSTANTS N, P

RECURSIVE Sum(_,_)
Sum(f,S) == IF S = {} THEN 0
                      ELSE LET x == CHOOSE x \in S : TRUE
                           IN  f[x] + Sum(f, S \ {x})

Break == {B \in [1..P -> 1..N] :    Sum(B, 1..P) = N
                                 /\ \A i \in 1..P : \A j \in (i+1)..P : B[i] =< B[j]}

IsRepresentation(w, B, S, T) ==     S \cap T = {}
                                 /\ w + Sum(B,S) = Sum(B,T)

IsSolution(B) ==  \A w \in 1..N : 
                     \E S, T \in SUBSET (1..P) : IsRepresentation(w, B, S, T)     
      
AllSolutions == { B \in Break : IsSolution(B) }

ExpandSolutions ==
  LET PiecesFor(w, B) == CHOOSE ST \in (SUBSET (1..P)) \X (SUBSET (1..P)) :
                           IsRepresentation(w, B, ST[1], ST[2])
      Image(S, B) == {B[x] : x \in S}
      SolutionFor(w, B) == << w, 
                              Image(PiecesFor(w, B)[1], B), 
                              Image(PiecesFor(w, B)[2], B) >>
  IN  { [w \in 1..N |-> SolutionFor(w, B)] : B \in AllSolutions }  

=============================================================================
\* Modification History
\* Last modified Thu Mar 22 15:56:54 EDT 2018 by tbrunson6
\* Created Thu Mar 22 14:28:51 EDT 2018 by tbrunson6
