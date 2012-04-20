import java.awt.geom.Point2D;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;


public class Solver {
	public int configHash;
	public int goalHash;
	public int numBlocks;
	public static int boardRows;
	public static int boardCols;
	
	static ArrayList<Block> goalTray = new ArrayList<Block>();
	public ArrayList<Block> Tray = new ArrayList<Block>();
	static LinkedList<Tray> Configurations = new LinkedList<Tray>();
	LinkedList<Move> movesMade = new LinkedList<Move>();
	HashMap<Integer, Integer> previousConfigs = new HashMap<Integer, Integer>();
	
	public Solver () {
		goalHash = this.hash(goalTray);
		Configurations.getFirst().hash = this.hash(Configurations.getFirst().Configuration);
		for (Block a : Configurations.getFirst().Configuration) {
			this.findmoves(a, Configurations.getFirst());
		}
		this.Analyze();
	}
	
	public void Analyze () {
		System.out.println("START");
		while (!checkdone(Configurations.getFirst().Configuration)) {
			while (Configurations.getFirst().possibleMoves.size() > 0) {
				previousConfigs.put(1, Configurations.getFirst().hash);
//				System.out.println("POSSIBLE MOVES: " + Configurations.getFirst().possibleMoves);
//				System.out.println("MOVE MADE: " + Configurations.getFirst().possibleMoves.getFirst());
				move(Configurations.getFirst().possibleMoves.getFirst().block, Configurations.getFirst().possibleMoves.getFirst());
//				System.out.println("NEW CONFIG: " + Configurations.getFirst().Configuration);
			}
			for (Tray a : Configurations) {
				System.out.println(a.Configuration);
			}
			if (Configurations.size() > 1) {
				System.out.println("Backtracking");
				this.backTrack();
			}
			else
				System.exit(1);
		}
	}
	
	public void backTrack() {
		Configurations.removeFirst();
		movesMade.removeFirst();
	}
	
	public boolean findmoves(Block current, Tray config) {
		int row = current.row;
		int col = current.col;
		int width = current.width;
		int height = current.height;
		int relativeWidth = col + width;
		int moveleft = 0; int moveright = 0; int moveup = 0; int movedown = 0;
		for (Block a : config.Configuration) {
			if (a != null && a.equals(current) == false) {
				for (int i = row; i < row + height; i++) {
					for (int j = col; j < col + width; j++) {
						if (moveright == 0 && a.contains(new Point2D.Double(i, (j + 1))) || (j + 1) >= boardCols) {
							moveright++;
						}
						
						if (moveleft == 0 && a.contains(new Point2D.Double(i, (j - 1))) || (j - 1) < 0) {
							moveleft++;
						}
						
						if (movedown == 0 && a.contains(new Point2D.Double((i + 1), j)) || (i + 1) >= boardRows) {
							movedown++;
						}
						
						if (moveup == 0 && a.contains(new Point2D.Double((i - 1), j)) || (i - 1) < 0) {
							moveup++;
						}
						if (moveleft > 0 && moveright > 0 && moveup > 0 && movedown > 0)
							break;
					}
					if (moveleft > 0 && moveright > 0 && moveup > 0 && movedown > 0)
						break;
				}
				if (moveleft > 0 && moveright > 0 && moveup > 0 && movedown > 0)
					break;
			}
		}
		
		if (moveright == 0 && col + 1 < boardCols)
			Configurations.getFirst().possibleMoves.add(new Move(row, col, row, col + 1, current));
		if (moveleft == 0 && col - 1 > -1)
			Configurations.getFirst().possibleMoves.add(new Move(row, col, row, col - 1, current));
		if (movedown == 0 && row + 1 < boardRows)
			Configurations.getFirst().possibleMoves.add(new Move(row, col, row + 1, col, current));
		if (moveup == 0 && row - 1 > -1)
			Configurations.getFirst().possibleMoves.add(new Move(row, col, row - 1, col, current));
		return true;
	}
	
	public boolean move (Block block, Move moveto) {
		Tray = Configurations.getFirst().Configuration;
		int position = Configurations.getFirst().Configuration.indexOf(block);
		Tray.get(position).row = moveto.movetoRow;
		Tray.get(position).col = moveto.movetoCol;
		
		if (previousConfigs.containsValue(this.hash(Tray))) {
			Configurations.getFirst().possibleMoves.removeFirst();
			return false;
		}
		
		this.movesMade.add(moveto);
		Configurations.getFirst().possibleMoves.removeFirst();
		Configurations.add(new Tray(Tray));
		Configurations.getFirst().hash = this.hash(Configurations.getFirst().Configuration);
		for (Block a : Configurations.getFirst().Configuration) {
			this.findmoves(a, Configurations.getFirst());
		}
		return true;
	}
	
	public int find(Block a) {
		return Configurations.getFirst().Configuration.indexOf(a);
	}
	
	public boolean checkdone(ArrayList<Block> current) {
		if(hash(current) == goalHash) {
			return true;
		}
		if(goalTray.size() > 1)
			if(find(goalTray.get(0)) > -1) {
				return true;
			}
		
		return false;
	}
	
	public int hash(ArrayList<Block> current) {
		int sum = 0;
		for (Block a : current) {
			if (a == null)
				break;
			sum += a.col * 3 + a.row * 13;
			if (a.height > 1)
				sum *= a.height + 1 * 5;
			else
				sum += 5;
			if (a.width > 1)
				sum *= a.width * 11;
			else
				sum += 11;
		}
		return Math.abs(sum * 23);
	}
	
	public static void main(String[] args) {
		try{
		    FileInputStream fstream = new FileInputStream(args[0]);
		    
		    DataInputStream in = new DataInputStream(fstream);
		        BufferedReader br = new BufferedReader(new InputStreamReader(in));
		    String strLine;
		    String[] temp = new String[3];
		    String[] board = br.readLine().split(" ");
		    boardRows = Integer.parseInt(board[0]);
		    boardCols = Integer.parseInt(board[1]);
		    Configurations.add(new Tray());
		    
		    while ((strLine = br.readLine()) != null)   {
		    	temp = strLine.split(" ");
		    	Configurations.getFirst().Configuration.add(new Block(Integer.parseInt(temp[0]), Integer.parseInt(temp[1]), Integer.parseInt(temp[2]), Integer.parseInt(temp[3])));
		    }
		    
		    in.close();
		    
		    fstream = new FileInputStream(args[1]);
		    in = new DataInputStream(fstream);
		    br = new BufferedReader(new InputStreamReader(in));
		    while ((strLine = br.readLine()) != null)
		    	temp = strLine.split(" ");
		    	goalTray.add(new Block(Integer.parseInt(temp[0]), Integer.parseInt(temp[1]), Integer.parseInt(temp[2]), Integer.parseInt(temp[3])));
		    }catch (Exception e){
		      System.err.println("Error: " + e.getMessage());
		    }
		    new Solver();

	}

}
