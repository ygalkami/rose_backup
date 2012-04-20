import java.util.ArrayList;
import java.util.LinkedList;


public class Tray {
	public ArrayList<Block> Configuration = new ArrayList<Block>();
	public LinkedList<Move> possibleMoves = new LinkedList<Move>();
	public int hash;
	
	public Tray (ArrayList<Block> config, LinkedList<Move> moves) {
		this.Configuration = config;
		this.possibleMoves = moves;
	}
	
	public Tray (ArrayList<Block> config) {
		this.Configuration = config;
		this.possibleMoves = new LinkedList<Move>();
	}
	
	public Tray () {
		this.Configuration = new ArrayList<Block>();
		this.possibleMoves = new LinkedList<Move>();
	}
}
