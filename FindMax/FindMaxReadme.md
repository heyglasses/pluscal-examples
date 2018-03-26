# Find the maximum algorithm
## The Art of Computer Programming Vol. 1 pp. 96-97
For PlusCal practice, this code tests the *Find the maximum* as it appears in **The Art of Computer Programming**. To run the model, you have to set the `defaultInitValue <- 0` in the **Model Overview** tab. The values are contained in the variable *V*, which is represented as a tuple. The description below is taken verbatim from Knuth. 

Let us now apply some of the techniques of the preceding sections to the study of a typical algorithm.

**Algorithm M** (*Find the maximum*). Given *n* elements X[1], X[2], ... , X[n], we will find *m* and *j* such that 
*m* = X[ *j* ] = max<sub>1≤i≤n</sub> X[ *i* ], 
where j is the largest index that satisfies this relation.

<li>**M1.** [Initialize.] Set j←n, k←n−1, m←x[n]. (During this algorithm we will have *m* = X[ *j* ] = max<sub>k≤i≤n</sub> X[ *i* ].)

<li>**M2.** [All tested?] If k = 0, the algorithm terminates.

<li>**M3.** [Compare.] If X[k]≤m, go to **M5**.

<li>**M4.** [Change m.] Set j←k, m←X[k]. (This value of m is a new current maximum.)

<li>**M5.** [Decrease k.] Decrease k by one and return to **M2**. 
</li>