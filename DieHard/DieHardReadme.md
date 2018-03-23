# Die Hard Algorithm
This TLA+ model simulates the riddle presented in Die Hard 3. You have a 3 and a 5 litre water container, each container has no markings except for that which gives you it's total volume. You also have a running tap. You must use the containers and the tap in such away as to exactly measure out 4 litres of water. 

To run the model in the TLA+ Toolbox, select the <i>Initial predicate and next-state relation</i> option in the <b>Model Overview</b> and enter`Init` and `Next` into the two fields. Next, in the <i>Invariants</i> box, add `TypeOK` and `big /= 4`.

Running the model should produce an error that produces the solution to the puzzle.