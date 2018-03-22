----------------------------- MODULE FastMutex -----------------------------
EXTENDS Integers
CONSTANT N

(*  --algorithm FastMutex
{ variables x = 0, y = 0, b = [i \in 1..N |-> FALSE];
  process (Proc \in 1..N)
  variable j;
  
  { 
      ncs: skip; (* The Noncritical Section *)
    start: b[self ] := TRUE;
       l1: x := self;
       l2: if (y # 0) { 
           l3: b[self] := FALSE;
           l4: await y = 0;
               goto start 
       };

       l5: y := self;
       l6: if (x # self ) { 
           l7: b[self] := FALSE;
               j := 1;
       l8: while (j <= N ) { 
           await ~b[j];
           j := j+1 
       };
      
       l9: if (y # self ) { 
           l10: await y = 0;
                goto start 
       };
    };
    
   cs: skip ; (* The Critical Section *)
  l11: y := 0;
  l12: b[self] := FALSE;
       goto ncs 
  }
}
end algorithm; *)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES x, y, b, pc, j

vars == << x, y, b, pc, j >>

ProcSet == (1..N)

Init == (* Global variables *)
        /\ x = 0
        /\ y = 0
        /\ b = [i \in 1..N |-> FALSE]
        (* Process Proc *)
        /\ j = [self \in 1..N |-> defaultInitValue]
        /\ pc = [self \in ProcSet |-> "ncs"]

ncs(self) == /\ pc[self] = "ncs"
             /\ TRUE
             /\ pc' = [pc EXCEPT ![self] = "start"]
             /\ UNCHANGED << x, y, b, j >>

start(self) == /\ pc[self] = "start"
               /\ b' = [b EXCEPT ![self ] = TRUE]
               /\ pc' = [pc EXCEPT ![self] = "l1"]
               /\ UNCHANGED << x, y, j >>

l1(self) == /\ pc[self] = "l1"
            /\ x' = self
            /\ pc' = [pc EXCEPT ![self] = "l2"]
            /\ UNCHANGED << y, b, j >>

l2(self) == /\ pc[self] = "l2"
            /\ IF y # 0
                  THEN /\ pc' = [pc EXCEPT ![self] = "l3"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "l5"]
            /\ UNCHANGED << x, y, b, j >>

l3(self) == /\ pc[self] = "l3"
            /\ b' = [b EXCEPT ![self] = FALSE]
            /\ pc' = [pc EXCEPT ![self] = "l4"]
            /\ UNCHANGED << x, y, j >>

l4(self) == /\ pc[self] = "l4"
            /\ y = 0
            /\ pc' = [pc EXCEPT ![self] = "start"]
            /\ UNCHANGED << x, y, b, j >>

l5(self) == /\ pc[self] = "l5"
            /\ y' = self
            /\ pc' = [pc EXCEPT ![self] = "l6"]
            /\ UNCHANGED << x, b, j >>

l6(self) == /\ pc[self] = "l6"
            /\ IF x # self
                  THEN /\ pc' = [pc EXCEPT ![self] = "l7"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "cs"]
            /\ UNCHANGED << x, y, b, j >>

l7(self) == /\ pc[self] = "l7"
            /\ b' = [b EXCEPT ![self] = FALSE]
            /\ j' = [j EXCEPT ![self] = 1]
            /\ pc' = [pc EXCEPT ![self] = "l8"]
            /\ UNCHANGED << x, y >>

l8(self) == /\ pc[self] = "l8"
            /\ IF j[self] <= N
                  THEN /\ ~b[j[self]]
                       /\ j' = [j EXCEPT ![self] = j[self]+1]
                       /\ pc' = [pc EXCEPT ![self] = "l8"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "l9"]
                       /\ j' = j
            /\ UNCHANGED << x, y, b >>

l9(self) == /\ pc[self] = "l9"
            /\ IF y # self
                  THEN /\ pc' = [pc EXCEPT ![self] = "l10"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "cs"]
            /\ UNCHANGED << x, y, b, j >>

l10(self) == /\ pc[self] = "l10"
             /\ y = 0
             /\ pc' = [pc EXCEPT ![self] = "start"]
             /\ UNCHANGED << x, y, b, j >>

cs(self) == /\ pc[self] = "cs"
            /\ TRUE
            /\ pc' = [pc EXCEPT ![self] = "l11"]
            /\ UNCHANGED << x, y, b, j >>

l11(self) == /\ pc[self] = "l11"
             /\ y' = 0
             /\ pc' = [pc EXCEPT ![self] = "l12"]
             /\ UNCHANGED << x, b, j >>

l12(self) == /\ pc[self] = "l12"
             /\ b' = [b EXCEPT ![self] = FALSE]
             /\ pc' = [pc EXCEPT ![self] = "ncs"]
             /\ UNCHANGED << x, y, j >>

Proc(self) == ncs(self) \/ start(self) \/ l1(self) \/ l2(self) \/ l3(self)
                 \/ l4(self) \/ l5(self) \/ l6(self) \/ l7(self)
                 \/ l8(self) \/ l9(self) \/ l10(self) \/ cs(self)
                 \/ l11(self) \/ l12(self)

Next == (\E self \in 1..N: Proc(self))
           \/ (* Disjunct to prevent deadlock on termination *)
              ((\A self \in ProcSet: pc[self] = "Done") /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Thu Mar 22 14:07:37 EDT 2018 by tbrunson6
\* Created Thu Mar 22 11:31:29 EDT 2018 by tbrunson6
