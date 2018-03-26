------------------------------ MODULE FindMax ------------------------------
(*********** The Art of Computer Programming, Vol. 1, page 96-97 ***********)
EXTENDS Integers, Sequences, TLC

(* --algorithm FindMax
variables V, X, j, k, m;

begin 
  M1: V := << 1, 5, 8, 0, 10, -2, 67, 567, 30, -10, 10 >>;
      X := [i \in 1..Len(V) |-> V[i]];
      j := Len(X);
      k := Len(X) -1; 
      m := X[Len(X)];
  
  M2: while k /= 0 do
      M3: if X[k] <= m then
            goto M5;
          end if;
      M4: j := k;
          m := X[k];
      M5: k := k-1;
      end while;

print <<X, j, m>>
end algorithm; *)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES V, X, j, k, m, pc

vars == << V, X, j, k, m, pc >>

Init == (* Global variables *)
        /\ V = defaultInitValue
        /\ X = defaultInitValue
        /\ j = defaultInitValue
        /\ k = defaultInitValue
        /\ m = defaultInitValue
        /\ pc = "M1"

M1 == /\ pc = "M1"
      /\ V' = << 1, 5, 8, 0, 10, -2, 67, 567, 30, -10, 10 >>
      /\ X' = [i \in 1..Len(V') |-> V'[i]]
      /\ j' = Len(X')
      /\ k' = Len(X') -1
      /\ m' = X'[Len(X')]
      /\ pc' = "M2"

M2 == /\ pc = "M2"
      /\ IF k /= 0
            THEN /\ pc' = "M3"
            ELSE /\ PrintT(<<X, j, m>>)
                 /\ pc' = "Done"
      /\ UNCHANGED << V, X, j, k, m >>

M3 == /\ pc = "M3"
      /\ IF X[k] <= m
            THEN /\ pc' = "M5"
            ELSE /\ pc' = "M4"
      /\ UNCHANGED << V, X, j, k, m >>

M4 == /\ pc = "M4"
      /\ j' = k
      /\ m' = X[k]
      /\ pc' = "M5"
      /\ UNCHANGED << V, X, k >>

M5 == /\ pc = "M5"
      /\ k' = k-1
      /\ pc' = "M2"
      /\ UNCHANGED << V, X, j, m >>

Next == M1 \/ M2 \/ M3 \/ M4 \/ M5
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION


=============================================================================
