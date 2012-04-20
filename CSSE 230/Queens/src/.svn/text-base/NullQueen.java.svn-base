/**
 * In the non-attacking chess queens problem, we represent the situation by a
 * linked list of queen objects. We could have a special test for the last queen
 * in the list, but that would make the methods much more complicated. It's
 * simpler to have a special Queen object to represent the end of the list. It
 * is rather trivial, and responds to all methods in fixed ways.
 * 
 * The NullQueen represents the end-of-the-line, off-the-board,
 * no-real-queen-so-nothing-to attack, only-one-choice.
 * 
 * @author Claude Anderson from an algorithm by Timothy Budd.
 */
public class NullQueen implements Queen {

	public boolean findFirst() {
		// There is no queen to position.
		return true;
	}

	public boolean findNext() {
		// There is no alternate position. If the null queen is
		// asked to move, we have searched all board configurations.
		return false;
	}

	public boolean canAttack(int row, int col) {
		// A null queen doesn't attack anything.
		return false;
	}

	@Override
	public String toString() {
		return "";
	}
}
