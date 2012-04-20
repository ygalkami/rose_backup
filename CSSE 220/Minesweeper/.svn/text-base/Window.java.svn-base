import java.awt.Color;
import java.awt.GridLayout;


import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JPanel;


public class Window {
	/* some special constants*/
	static final int SPECIAL_KEY = 'c';
	
	protected static int flagCount = 0;
	protected static int toWinCount = 0;
	
	static int EASY_FRAME_WIDTH = 500;
	static int EASY_FRAME_HEIGHT = 500;
	
	static int MEDIUM_FRAME_WIDTH = 775;
	static int MEDIUM_FRAME_HEIGHT = 775;
	
	static int EXPERT_FRAME_WIDTH = 1100;
	static int EXPERT_FRAME_HEIGHT = 1100;

	static int easy = 9;
	static int medium = 16;
	static int expert = 25;
	
	static int easybombs = 9;
	static int mediumbombs = 40;
	static int expertbombs = 99;
	
	static Square [][] easyboard = new Square[easy][easy];
	static Square [][] mediumboard = new Square[medium][medium];
	static Square [][] expertboard = new Square[expert][expert];
	
	static JFrame frame_Easy = new MenuFrame();
	static JFrame frame_Medium = new MenuFrame();
	static JFrame frame_Expert = new MenuFrame();
	
	static ImageIcon bomb = new ImageIcon("bomb.jpg");
	static ImageIcon flag = new ImageIcon("flag.jpg");
	
	static boolean won = false;
	
/**
 * Populates a 2D array with Squares to reprpesent the board.
 * 
 * @param frame the particular frame that the board will be created in; used for difficulty implementation
 * @param pieces the number of squares in each row/column of a difficulty board (made squares for simplicity)
 * @param frame_width the width of the window frame for the corresponding difficulty
 * @param frame_height the height of the window frame for the corresponding difficulty
 * @param board the particular board to populate with squares
 */
	public static void createboard(JFrame frame, int pieces, int frame_width, int frame_height, Square[][] board, int numbombs) {
		frame.setSize(frame_width, frame_height);
		frame.setTitle("Minesweeper");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel panel = new JPanel();
		
		panel.setFocusable(false);
		
		for (int i=0; i<pieces; i++) {
			for (int j=0; j<pieces; j++) {
				board[i][j] = new Square(i, j, pieces, board, numbombs);
				board[i][j].addActionListener(board[i][j]);
				panel.add(board[i][j]);
			}
		}
		
		panel.setLayout(new GridLayout(pieces, pieces));
		frame.add(panel);
		frame.setVisible(false);
	}
	
	/**
	 *  Randomly populates the Squares in the board with the proper of number of bombs.
	 * @param boardSize the row and column size of the board the bombs are set in
	 * @param numBombs the number of bombs to set
	 * @param board the specific board to set bombs in
	 */
	public static void setBombs (int boardSize, int numBombs, Square[][] board){
		boardSize = boardSize - 1;
		Square [] Bombs = new Square [numBombs];
		int setBombs = 1;
		while(setBombs <= numBombs){
				double indexRow = boardSize*Math.random();
				double indexColumn = boardSize*Math.random();
				Square square = board[(int)java.lang.Math.round(indexRow)][(int)java.lang.Math.round(indexColumn)];
				if(square.isBomb)
					continue;
				square.setBomb();
				setBombs++;
		}
	}
	/**
	 * 
	 * @param boardSize the size of the board to be reset by NewGame
	 * @param numBombs the number of bombs the board will be populated with
	 * @param board the actual board being reset by NewGame
	 */
	public static void newGame (int boardSize ,int numBombs, Square[][] board){
		for (int i = 0; i < boardSize;i++){
			for (int j = 0; j < boardSize; j++){
				board[i][j].isFlag = false;
				board[i][j].isBomb = false;
				Window.flagCount = 0;
				Window.toWinCount = 0;
				board[i][j].numBombsAround = 0;
				board[i][j].setIcon(null);
				board[i][j].setText(null);
				board[i][j].setBackground(Color.WHITE);
				Window.won = false;
				board[i][j].revealed = false;
			}
		}
		Window.setBombs(boardSize, numBombs, board);
	}
	/**
	 * Reveals all the bombs on the board; used in cheat function and lose.
	 * @param difficulity the rows/columns of the board for array index looping
	 * @param board the board where bombs are to be shown.
	 */
	public static void showbombs(int difficulity, Square [][] board) {
		for (int i=0; i<difficulity; i++) {
			for (int j=0; j<difficulity; j++) {
				if(board[i][j].isBomb && !board[i][j].isFlag)
					board[i][j].setIcon(bomb);
				else if (board[i][j].isBomb && board[i][j].isFlag)
					board[i][j].setIcon(flag);
			}
		}
	}
	/**
	 * Hides all the bombs on the board; used in cheat function and lose.
	 * @param difficulity the rows/columns of the board for array index looping
	 * @param board the board where bombs are to be hid.
	 */
	public static void hidebombs(int difficulity, Square [][] board) {
		for (int i=0; i<difficulity; i++) {
			for (int j=0; j<difficulity; j++) {
				if(board[i][j].isBomb && !board[i][j].isFlag)
					board[i][j].setIcon(null);
				else if (board[i][j].isBomb && board[i][j].isFlag)
					board[i][j].setIcon(flag);
			}
		}
	}
	/**
	 * Checks for a win by seeing if all of the squares that are bombs are covered by flags
	 * See Window class for more details
	 * @param difficulitybombs the number of bombs that flags has to be equal to
	 * @return true or false depending on the condition of the game
	 */
	public static boolean checkwinflags(int difficulitybombs) {
		if (difficulitybombs == Window.toWinCount) {
			return true;
		}
		else {
			return false;
		}
	}
	/**
	 * Checks for a win based on whether or not all squares are revealed except those that are
	 * bombs
	 * @param difficulitybombs the number of bombs on the board
	 * @param board the board that will be checked
	 * @param difficulity the number of squares in the board's row and column, used to find
	 * total squares
	 * @return true or false depending on whether or not the number of squares reveealed is 
	 * equal to the number of squares on the board minus the bombs.
	 */
	public static boolean checkwinrevealed(int difficulitybombs, Square [][] board, int difficulity) {
		int revealedcount = 0;
		
		for (int i = 0; i < Math.sqrt(difficulity); i++) {
			for (int j = 0; j < Math.sqrt(difficulity); j++) {
				if (board[i][j].revealed && !board[i][j].isBomb && !board[i][j].isFlag && !board[i][j].isQMark)
					revealedcount++;
			}
		}
		System.out.println(revealedcount);
		System.out.println(difficulity - difficulitybombs);
		if (revealedcount == (difficulity - difficulitybombs)) {
//			System.out.println("true");
			
			return true;
		}
		else {
			//System.out.println("false");
			return false;
		}
	}
	/**
	 * Creates all three boards for difficulties and sets bombs, allowing the game to be played.
	 * @param args
	 */
	public static void main(String [] args){
		createboard(frame_Easy, easy, EASY_FRAME_WIDTH, EASY_FRAME_HEIGHT, easyboard, easybombs);
		createboard(frame_Medium, medium, MEDIUM_FRAME_WIDTH, MEDIUM_FRAME_HEIGHT, mediumboard, mediumbombs);
		createboard(frame_Expert, expert, EXPERT_FRAME_WIDTH, EXPERT_FRAME_HEIGHT, expertboard, expertbombs);
		
		setBombs(easy, easybombs, easyboard);
		setBombs(medium, mediumbombs, mediumboard);
		setBombs(expert, expertbombs, expertboard);
		
		frame_Easy.show();
		
		//showbombs(easy, easyboard);
	}
}