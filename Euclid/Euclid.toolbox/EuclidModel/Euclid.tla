------------------------------- MODULE Euclid -------------------------------
EXTENDS Naturals, TLC
CONSTANT K

Divides(i, j) == \E k \in 0..j : j = i * k
IsGCD(i, j, k) == Divides(i, j)
                  /\ Divides(i, k)
                  /\ \A r \in 0..j \union 0..k :
                  Divides(r, j) /\ Divides(r, k) => Divides(r, i)

(* --algorithm Gcd 
variables m \in 1..K, n \in 1..K, u = m, v = n;
begin
  while (u # 0) do
    if (u < v) then u := v || v := u end if;
    u := u - v
  end while;
  print <<m, "and", n, "have gcd", v>>;
  assert IsGCD(v, m, n)
end algorithm; *)
\* BEGIN TRANSLATION
VARIABLES m, n, u, v, pc

vars == << m, n, u, v, pc >>

Init == (* Global variables *)
        /\ m \in 1..K
        /\ n \in 1..K
        /\ u = m
        /\ v = n
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF (u # 0)
               THEN /\ IF (u < v)
                          THEN /\ /\ u' = v
                                  /\ v' = u
                          ELSE /\ TRUE
                               /\ UNCHANGED << u, v >>
                    /\ pc' = "Lbl_2"
               ELSE /\ PrintT(<<m, "and", n, "have gcd", v>>)
                    /\ Assert(IsGCD(v, m, n), 
                              "Failure of assertion at line 19, column 3.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << u, v >>
         /\ UNCHANGED << m, n >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ u' = u - v
         /\ pc' = "Lbl_1"
         /\ UNCHANGED << m, n, v >>

Next == Lbl_1 \/ Lbl_2
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Wed Mar 21 21:14:54 EDT 2018 by tbrunson6
\* Created Wed Mar 21 21:13:53 EDT 2018 by tbrunson6
