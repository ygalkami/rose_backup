/**
 * This interface is intended to be used in solving the "non-attacking chess
 * queens" problem. Each queen is an object which knows where it is placed on
 * the board and can tell you whether it (or any of its neighbors "to the left)
 * can attack a given squre on the board. Each queen is responsible for
 * negotiating with its neigbors to find a non-attacking configuration.
 * 
 * In the descriptions of these methods, "its neighbors" means all queens "to
 * the left" of this. 'neighbor' means the immediate neighbor (if any).
 */
public interface Queen {

	/**
	 * Finds the first position for this queen and its neighbors such that none
	 * of them attack each other.
	 * 
	 * @return true iff it finds such a position
	 */
	public boolean findFirst();

	/**
	 * Moves this queen to its next legal position (in which it doesn't attack
	 * any neighbors). If no such position is found, it asks its first neighbor
	 * to move, and then starts over at row 1. If neighbors have no untried
	 * positions, returns false. Otherwise returns true.
	 * 
	 * @return false if neighbors have no untried positions. Otherwise returns
	 *         true.
	 */
	public boolean findNext();

	/**
	 * Checks whether this queen of one of its neighbors can attack the given
	 * row and column.
	 * 
	 * @param row
	 * @param col
	 * @return true iff this queen (or its neighbors) can attack the given row
	 *         and column
	 */
	public boolean canAttack(int row, int col);

	/**
	 * A string representing the rows in which this queen and its neighbors. are
	 * placed.
	 */
	public String toString();

}
