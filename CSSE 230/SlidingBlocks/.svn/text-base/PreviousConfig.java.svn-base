import java.awt.geom.Point2D;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;

// previous config is how we store all of our configurations. it has a linked list on the moves and the block configuration
public class PreviousConfig {
	
	public int hash;	// the hash of the config
	public LinkedList<Move> moves;	// the linked list of the moves for the config
	public Block[] configuration;	// an array representation of the board configuration
	public Move move;	
	
	public PreviousConfig(Block[] config, LinkedList<Move> moves) {
		this.moves = moves;
		this.configuration = config;
	}
	
	public PreviousConfig(Block[] config) {
		this.configuration = config;
		this.moves = new LinkedList<Move>();
	}
	
	public PreviousConfig() {
		this.moves = new LinkedList<Move>();
		this.configuration = new Block[Solver.numblocks];
	}
	
	public PreviousConfig(Move move) {
		this.moves = new LinkedList<Move>();
		this.configuration = new Block[Solver.numblocks];
		this.move = move;
	}
	
	public int hash(Block current) {
		// create the hash for the board configuration
		int sum = 0;
		int blocksum = 0;
		int prime = 257;
		blocksum += current.col * prime;
		blocksum += current.row;
		blocksum *= prime;
		blocksum += current.height;
		blocksum *= prime;
		blocksum += current.width;
		blocksum *= prime;
		return Math.abs(blocksum);
	}
	
	public String toString() {
		String returnString = "";
		for (Block a : this.configuration) {
			if (a != null)
				returnString += a.toString() + " ";
			else
				break;
		}
		
		return returnString;
	}
}
