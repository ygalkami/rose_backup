import java.awt.geom.Point2D;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;


/**
 * TODO Put here a description of what this class does.
 *
 * @author <your username>.
 *         Created Jan 31, 2008.
 */
public class Solver {
	public static int numblocks = 0;
	/**
	 * TODO Put here a description of what this method does.
	 *
	 * @param args
	 */
	
	public LinkedList<PreviousConfig> currentconfig = new LinkedList<PreviousConfig>();		// linked list of the previous configs - stores all old configurations and what we need to know about them
	public LinkedList<Tray> previousConfigs = new LinkedList<Tray>();	
	public LinkedList<Move> movesmade = new LinkedList<Move>();
	public Block[] Configuration;	// the array represetation of the board
	public Block[] ConfigurationGoal;	// the goal configuration we want to reach
	public Tray goalHash;	// the hash of the goal configuration we are trying to reach
	public static int boardRows;
	public static int boardCols;
	public static int numBlocksInGoal = 0;
	public static int previousconfigs = 0;
	public static int debugState = 0;	// which state the user wants for debugging purposes
	public int i = 0;
	
	// the solver constructor
	public Solver(int args, String configFile, String goalFile, String debug) {
		this.readFile(args, configFile, goalFile, debug);
		currentconfig.addFirst(new PreviousConfig());
		int count = 0;
		// go through each block in the configuration
		// and add the initial config to the linkedlist
		for (Block a : Configuration) {
			if (a != null)
				currentconfig.getFirst().configuration[count] = new Block(a.height, a.width, a.row, a.col);
			else
				break;
			count++;
		}
		//Add the initial configuration to the list of previous seen configs
		previousConfigs.add(new Tray(currentconfig.getFirst().configuration));
		this.goalHash = new Tray(ConfigurationGoal);
		Analyze(Configuration);
	}
	
	public void Analyze(Block[] blocks){
		//find possible moves for intial configuration
		for (Block a : currentconfig.getFirst().configuration) {
			if (a != null)
				findmoves(a, currentconfig.getFirst());
			else
				break;
		}
		
		Block temp = null;
		int count = 0;
		
		//while current configuration is not equal to goal configuration
		while (!checkdone(currentconfig.getFirst().configuration) /*&& count < 5*/) {
			//while there are more possible untried moves in the currentconfiguration
			while(currentconfig.getFirst().moves.size() > 0 && !checkdone(currentconfig.getFirst().configuration) /*&& count < 5*/) {
				if(debugState == 3){	// if debug state is 3, print out the last move
					if (movesmade.size() > 0)
						System.out.println(movesmade.getLast().toString());
				}
				
				move(currentconfig.getFirst().moves.getLast().block, currentconfig.getFirst().moves.getLast());
				count++;
			}

			//if done, print out moves made to get there
			if (checkdone(currentconfig.getFirst().configuration)) {
				for (Move a : movesmade) {
					System.out.println(a);
				}
				break;
			}
			
//			// if not done, backtrack to place where more moves are possible and continue
			
			boolean temp2 = this.backtrack();
			//if back at initial config exit to signfy that this puzzle was impossible
			if (!temp2) {
				System.exit(1);
			}
		}
	}
	
	//backtrack to a previous configuration
	public boolean backtrack() {
		if (currentconfig.size() > 1) {
			currentconfig.removeFirst();	// we added the new ones to the front of the list to imporve efficiency in backtracking
			movesmade.removeLast();
			// make a new linked list and go through and find new moves
			currentconfig.getFirst().moves = new LinkedList<Move>();
			for (Block a : currentconfig.getFirst().configuration)
				this.findmoves(a, currentconfig.getFirst());
		}
		else
			return false;
		int i = 0;
		//Configuration is a temporary config which is the current config, set it to the config that was backtracted to
		for (Block a : currentconfig.getFirst().configuration) {
			Configuration[i] = new Block(a.height, a.width, a.row, a.col);
			i++;
		}
		return true;
	}
	
	//find where a block is stored in the tray array
	public int find(Block a) {
		for (int i = 0; i < numblocks; i++) {
			if (Configuration[i].row == a.row && Configuration[i].col == a.col && Configuration[i].height == a.height && Configuration[i].width == a.width)
				return i;
		}
		return -1;
	}
	
	// method used in helping to find bugs in our has code
	public void debugLinkedListHash ()	{
		for (PreviousConfig config : currentconfig) {
			System.out.print(config.hash + " ");
		}
		System.out.println("");
	}
	
	// check to see if we have seen the current config anytime before
	public boolean seenConfigBefore() {
		for (Tray tray : this.previousConfigs) {
			if (tray.config.equals(new Tray(Configuration).config))
				return true;
		}
		return false;
	}
	
	public int hashBlock(Block current) {
		// create hash code for an individual block 
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
	
	//take in a block to move
	public boolean move(Block block, Move moveto) {
		int position = find(block);

		// move the block to the desired position
		Configuration[position].row = moveto.moveToY;
		Configuration[position].col = moveto.moveToX;
		
		// if we have already seen this move, undo the move that we just made and remove it from the list of possible moves
		if (this.seenConfigBefore()) {
			Configuration[position].row = moveto.currentPosY;
			Configuration[position].col = moveto.currentPosX;
			currentconfig.getFirst().moves.removeLast();
			return false;
		}

		// if the move is made and we havent seen the configuration before, add the move made to the collection of moves that are part of the solution
		movesmade.add(moveto);
		// add this configuration to the list of previously seen configs
		this.previousConfigs.add(new Tray(Configuration));
		currentconfig.getFirst().moves.removeLast();
		currentconfig.addFirst(new PreviousConfig(new Move(moveto.currentPosY, moveto.currentPosX, moveto.moveToY, moveto.moveToX)));
		int i = 0;
		
		//add new config to linkedlist of configs
		for (Block a : Configuration) {
			if (a != null) {
				currentconfig.getFirst().configuration[i] = new Block(a.height, a.width, a.row, a.col);
			}
			else
				break;
			i++;
		}
		// find possible moves for new config
		for (Block a : currentconfig.getFirst().configuration) {
			if (a != null)
				this.findmoves(a, currentconfig.getFirst());
			else 
				break;
		}

		if(debugState == 2)	// if the debug state is 2, print out the current board configurations
			System.out.println(currentconfig.getFirst().toString());
		return true;
	}
	
	// method we used to debug our findmoves. were able to check and see where it was finding illeagal moves
	public void printPossibleMoves() {
		System.out.print("POSSIBLE MOVES: ");
		System.out.println(currentconfig.getFirst().moves);
	}
	
	// print out the current board configuration
	public void printConfig () {
		System.out.print("CONFIGURATION: ");
		for (Block a : currentconfig.getFirst().configuration) {
			if (a != null) {
				System.out.print(a + " ");
			}
		}
		System.out.println("");
	}
	
	// helped with us debugging parts of our code along the way
	public void printConfig2 () {
		System.out.print("TEMP CONFIGURATION: ");
		for (Block a : Configuration) {
			if (a != null) {
				System.out.print(a + " ");
			}
		}
		System.out.println("");
	}
	
	//check to see if this configuration is equivilant to the goal configuration
	public boolean checkdone(Block[] current) {
		if(this.compareTrays()) {
			return true;
		}
		
		if(ConfigurationGoal[1] == null) {
			if(find(ConfigurationGoal[0]) > -1) {
				return true;
			}
		}
		
		if (this.numblocks != this.numBlocksInGoal) {
			for (int i = 0; i < this.numBlocksInGoal; i++) {
				if (find(ConfigurationGoal[i]) == -1)
					return false;
			}
			return true;
		}
		
		return false;
	}
	
	// compare two trays to see if they are the same
	// used in seeing if were in the goal config
	public boolean compareTrays() {
		for (int a : this.previousConfigs.getLast().config) {
			if (!this.goalHash.contains(a))
				return false;
		}
		return true;
	}
	
	//finds all the possible moves, of the block passed in and the tray
	public boolean findmoves(Block current, PreviousConfig config) {
		int row = current.row;
		int col = current.col;
		int width = current.width;
		int height = current.height;
		int relativeWidth = col + width;
		int moveleft = 0; int moveright = 0; int moveup = 0; int movedown = 0;
		for (Block a : config.configuration) {
			if (a != null && a.equals(current) == false) {
				//Check every point that will be occuipied by the block after the move
				// if any of the current blocks are in those places, remove that move as a possibility
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
		
		// if all the adjacent spaces were open, we can make a move
		if (moveright == 0 && col + 1 < boardCols)
			currentconfig.getFirst().moves.add(new Move(row, col, row, col + 1, current, "right", "left"));
		if (moveleft == 0 && col - 1 > -1)
			currentconfig.getFirst().moves.add(new Move(row, col, row, col - 1, current, "left", "right"));
		if (movedown == 0 && row + 1 < boardRows)
			currentconfig.getFirst().moves.add(new Move(row, col, row + 1, col, current, "down", "up"));
		if (moveup == 0 && row - 1 > -1)
			currentconfig.getFirst().moves.add(new Move(row, col, row - 1, col, current, "up", "down"));

		if(debugState == 1){
			// debugging state to print out all possible moves found
			System.out.println(currentconfig.getFirst().moves);
		}
		return true;
	}
	
	// read files in
	public void readFile(int args, String configFile, String goalFile, String debug) {
		// if there is no debugging argument passed
		if (args == 2) {
			try {
				// read through the configuration file and intrepret the blocks and add them correctly to where we are storing out congifuration
				BufferedReader in = new BufferedReader(new FileReader(configFile));
				String temp = "";
				int count = 0;
				String[] size = new String[1];
				size = in.readLine().split(" ");
				boardRows = Integer.parseInt(size[0]);
				boardCols = Integer.parseInt(size[1]);
//				System.out
//						.println("Rows: " + boardRows + " Cols: " + boardCols);
				Configuration = new Block[boardRows * boardCols];
				// System.out.println(in.readLine());

				String[] line = new String[3];
				while ((temp = in.readLine()) != null) {
					line = temp.split(" ");
					Configuration[count] = new Block(Integer.parseInt(line[0]),
							Integer.parseInt(line[1]), Integer
									.parseInt(line[2]), Integer
									.parseInt(line[3]));
					count++;
				}
				
				numblocks = count;
//				for (Block a : Configuration) {
//					if (a != null)
//						System.out.print(a + " ");
//				}
				// read through the goal file and find out what we want our final configuration to look like
				in = new BufferedReader(new FileReader(goalFile));
				ConfigurationGoal = new Block[boardRows * boardCols];
				count = 0;
				while ((temp = in.readLine()) != null) {
					line = temp.split(" ");
					ConfigurationGoal[count] = new Block(Integer
							.parseInt(line[0]), Integer.parseInt(line[1]),
							Integer.parseInt(line[2]), Integer
									.parseInt(line[3]));
					count++;
				}
				this.numBlocksInGoal = count;
				// System.out.println(GoalConfiguration.values());
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
		// if there is a debugging argument passed
		else if(args == 3){
			try {
				if(debug.equals("-oMoves"))	// want the moves available at a each state to be printed
					debugState = 1;
				if(debug.equals("-oBoardConfigs"))	// print out each current board configuration
					debugState = 2;	
				if(debug.equals("-oLastMove"))	// print out the last move made 
					debugState = 3;
				
				BufferedReader in = new BufferedReader(new FileReader(configFile));
				String temp = "";
				int count = 0;
				String[] size = new String[1];
				size = in.readLine().split(" ");
				boardRows = Integer.parseInt(size[0]);
				boardCols = Integer.parseInt(size[1]);
//				System.out.println("Rows: " + boardRows + " Cols: " + boardCols);
				Configuration = new Block[boardRows * boardCols];
//				System.out.println(in.readLine());
				
				String[] line = new String[3];
				while ((temp = in.readLine()) != null) {
					line = temp.split(" ");
//					BlockConfiguration.put(new Point2D.Double(Integer.parseInt(line[2]), Integer.parseInt(line[3])), new Block(Integer.parseInt(line[0]), Integer.parseInt(line[1]), 
//							Integer.parseInt(line[2]), Integer.parseInt(line[3])));
					Configuration[count] = new Block(Integer.parseInt(line[0]), Integer.parseInt(line[1]), Integer.parseInt(line[2]), Integer.parseInt(line[3]));
					count++;
				}
				numblocks = count;
//				System.out.println(BlockConfiguration.values());
				in = new BufferedReader(new FileReader(goalFile));
				ConfigurationGoal = new Block[boardRows * boardCols];
				count = 0;
				while((temp = in.readLine()) != null) {
					line = temp.split(" ");
//					GoalConfiguration.put(new Point2D.Double(Integer.parseInt(line[2]), Integer.parseInt(line[3])), new Block(Integer.parseInt(line[0]), Integer.parseInt(line[1]), 
//							Integer.parseInt(line[2]), Integer.parseInt(line[3])));
					ConfigurationGoal[count] = new Block(Integer.parseInt(line[0]), Integer.parseInt(line[1]), Integer.parseInt(line[2]), Integer.parseInt(line[3]));
					count++;
				}
				this.numBlocksInGoal = count;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub.
		// check to see how many command line arguments are being passed in
		if (args.length == 2) {
			new Solver(args.length, args[0], args[1], null);
		}
		else
			new Solver(args.length, args[1], args[2], args[3]);
		

	}
}