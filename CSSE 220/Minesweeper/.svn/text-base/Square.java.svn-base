import java.awt.Color;
import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JPanel;

import java.lang.Math;

public class Square extends JButton implements ActionListener , KeyListener, MouseListener {
	/*Some predefined, useful constants for the class*/
	protected Square [][] board;
	protected int difficulity;
	protected int numbombs;
	protected int row;
	protected int col;
	protected int numBombsAround = 0;
	static final int SPECIAL_KEY = 'c';
	protected boolean isBomb = false;
	protected boolean isFlag = false;
	protected boolean isQMark = false;
	protected boolean revealed = false;
	protected ImageIcon bomb;
	protected ImageIcon flag;
	protected ImageIcon Qmark;
	protected Color background = Color.WHITE;
	protected Color nobombsaround = Color.BLUE;
	/**
	 * Square class constructor 
	 * @param row The number of rows the board the square is on will have
	 * @param col The number of columns the board the square is on will have
	 * @param diff The difficulty of the game
	 * @param board The board the square will appear on.
	 */
	public Square(int row, int col, int diff, Square [][] board, int numbombs) {
		this.addKeyListener(this);
		this.addMouseListener(this);
		this.bomb = new ImageIcon("bomb.jpg");
		this.flag = new ImageIcon("flag.jpg");
		this.Qmark = new ImageIcon("question_mark.gif");
		this.setBackground(background);
		this.row = row;
		this.col = col;
		this.difficulity = diff;
		this.board = board;
		this.numbombs = numbombs;
	}
	/**
	 * When a square is clicked, it reveals itself and the number of bombs it has around it.
	 * If no bombs are around the clicked square, adajcent squares are revealed until they have
	 * bombs near them.
	 * @param board the board that the square is on
	 */
	public void sweep(Square [][] board) {
		if (this.numBombsAround != 0) {
			if (!this.isFlag) {
				this.setText(this.numBombsAround);
				this.revealed = true;
			}
		}
		else if (this.revealed == false && this.isBomb == false) {
			this.setBackground(nobombsaround);
			this.revealed = true;
			for (int i = Math.max(0, this.row - 1); i <= Math.min(this.difficulity - 1, this.row + 1); i++) {
				for (int j = Math.max(0, this.col - 1); j <= Math.min(this.difficulity - 1, this.col + 1); j++) {
					if (i == this.row && j == this.col){}
					else {
						board[i][j].sweep(board);
					}
				}
			}
		}
	}
/**
 * When a square is clicked, sets it as a bomb if it is a bomb, or it calculates
 * the number of bombs adjacent to it if it is not a bomb.
 *
 */
	public void setBomb() {
		if (this.isBomb == false){
			this.isBomb = true;
		}
		
		for (int i = Math.max(0, this.row - 1); i <= Math.min(this.difficulity - 1, this.row + 1); i++) {
			for (int j = Math.max(0, this.col - 1); j <= Math.min(this.difficulity - 1, this.col + 1); j++) {
				if (i == this.row && j == this.col && board[i][j].isBomb == true){}
				else {
					board[i][j].numBombsAround++;
				}
			}
		}
	}
	
	public void bombsAround(int bombs) {
		this.numBombsAround = bombs;
	}

/**
 * Lets the squares listen for a key press of 'c'; used to implement the cheat function
 * found it Window (showbombs).
 */
	public void keyPressed(KeyEvent e) {
		if (e.getKeyChar()== SPECIAL_KEY){
			Window.showbombs(Window.easy, Window.easyboard);
			Window.showbombs(Window.medium, Window.mediumboard);
			Window.showbombs(Window.expert, Window.expertboard);
	        
		}
		
	}
/**
 * Lets them hear for a release of 'c', used to implement the cheat function
 * found in Window (showbombs).
 */
	public void keyReleased(KeyEvent e) {
		if (e.getKeyChar()== SPECIAL_KEY){
			Window.hidebombs(Window.easy, Window.easyboard);
			Window.hidebombs(Window.medium, Window.mediumboard);
			Window.hidebombs(Window.expert, Window.expertboard);
	       
		}
		
	}
	/**
	 * Sets the flag variable of each square and displays an icon; used in mouseClicked method
	 * when right-click is detected.
	 */
	public void setFlag(){
		if(this.isFlag){
			this.isFlag = false;
			this.revealed = false;
			this.setIcon(null);
		}
		else {
			this.isFlag = true;
			this.revealed = true;
			this.setIcon(this.flag);
			}
	}
	/**
	 * Sets a square as a Question mark.
	 *
	 */
	public void setQmark() {
		if (this.isQMark) {
			this.isQMark = false;
			this.revealed = false;
			this.setIcon(null);
		}
		else {
			this.isQMark = true;
			this.revealed = true;
			this.setIcon(Qmark);
		}
	}
	/**
	 * Shows the number of bobs around a square, used as a function
	 * to easily change the colors of the numbers shown on the square
	 * @param numbombsaround the number of bombs for each square.
	 */
	public void setText(int numbombsaround) {
		numbombsaround = this.numBombsAround;
		if (numbombsaround == 1)
			this.setForeground(Color.BLUE);
		else if (numbombsaround == 2)
			this.setForeground(Color.GREEN);
		else if (numbombsaround == 3)
			this.setForeground(Color.RED);
		else if (numbombsaround == 4)
			this.setForeground(new Color(0, 50, 0));
		else if (numbombsaround == 5)
			this.setForeground(Color.PINK);
		
		this.setText("" + numbombsaround);
	}

/**
 * Checks for clicks - if a left click on a square, runs the sweep function,
 * or if it's a bomb, reveeals all the bombs,
 * or, if a right-click is detected, runs setFlag to change flag or question mark status
 * 
 * Also checks for a win or a lose after each click; a VERY important method.
 */
	public void mouseClicked(MouseEvent e) {
		if (!Window.won) {
			if(e.getButton()!=3 && !this.isFlag){
				if(!this.isBomb && this.numBombsAround != 0){
					this.setText(this.numBombsAround);
				}
				else if(!this.isBomb && this.isQMark) {
					this.setText(this.numBombsAround);
				}
				else if(this.isBomb){
					Window.showbombs(Window.easy, Window.easyboard);
					Window.showbombs(Window.medium, Window.mediumboard);
					Window.showbombs(Window.expert, Window.expertboard);
					Window.won = true;
					
					String [] you = new String[4];
					String [] lose = new String[4];
					you[0] = "Y";
					you[1] = "o";
					you[2] = "u";
					you[3] = " ";
					lose[0] = "L";
					lose[1] = "o";
					lose[2] = "s";
					lose[3] = "e";
					
					for (int i = 0; i < this.difficulity; i++) {
						for (int j = 0; j < this.difficulity; j++) {
							board[i][j].setText("");
							board[i][j].setBackground(Color.WHITE);
						}
					}
					for (int i = 0; i < 4; i++) {
						this.board[(int) Math.floor(this.difficulity / 2)][i].setText(you[i]);
						this.board[(int) Math.floor(this.difficulity / 2)][i].setIcon(null);
						this.board[(int)Math.floor(this.difficulity / 2)][i + 4].setText(lose[i]);
						this.board[(int)Math.floor(this.difficulity / 2)][i + 4].setIcon(null);
					}
					System.out.println("lose");
				}
				else if (this.numBombsAround == 0)
					this.sweep(board);
		
				this.revealed = true;
			}
	
			if (e.getButton() == 3 && !this.isBomb && !this.isFlag && !this.revealed && !this.isQMark)
				{
					Window.flagCount++;
					this.setFlag();
				}
			else if (e.getButton()== 3 && !this.isBomb && this.isFlag && this.revealed && !this.isQMark){
				Window.flagCount--;
				this.setFlag();
				this.setQmark();
			}
			else if (e.getButton()==3 && this.isBomb && !this.isFlag && !this.revealed && !this.isQMark){
				Window.flagCount++;
				Window.toWinCount++;
				this.setFlag();
			}
			else if (e.getButton()==3 && this.isBomb && this.isFlag && this.revealed && !this.isQMark){
				Window.flagCount--;
				Window.toWinCount--;
				this.setFlag();
				this.setQmark();
			}
			else if (e.getButton() == 3 && this.revealed && this.isQMark) {
				this.setQmark();
			}
			
			if (Window.checkwinflags(this.numbombs) || Window.checkwinrevealed(this.numbombs, this.board, this.difficulity * this.difficulity)) {
				String [] you = new String[3];
				String [] win = new String[3];
				you[0] = "Y";
				you[1] = "o";
				you[2] = "u";
				win[0] = "W";
				win[1] = "i";
				win[2] = "n";
				for (int i = 0; i < this.difficulity; i++) {
					for (int j = 0; j < this.difficulity; j++) {
						board[i][j].setText("");
						board[i][j].setIcon(null);
						board[i][j].setBackground(Color.WHITE);
					}
				}
				for (int i = 0; i < 3; i++) {
					this.board[(int) Math.floor(this.difficulity / 2)][i].setText(you[i]);
					this.board[(int)Math.floor(this.difficulity / 2)][i + 4].setText(win[i]);
				}
				System.out.println("win");
			}
		}
			
	}

	public void actionPerformed(ActionEvent e) {}
	
	public void keyTyped(KeyEvent e) {}

	public void mouseEntered(MouseEvent arg0) {}

	public void mouseExited(MouseEvent arg0) {}

	public void mousePressed(MouseEvent e) {}

	public void mouseReleased(MouseEvent arg0) {}	
	
}
