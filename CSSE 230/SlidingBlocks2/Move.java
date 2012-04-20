
public class Move {
	
	public int currentRow;
	public int currentCol;
	public int movetoRow;
	public int movetoCol;
	public Block block;

	public Move(int currentRow, int currentCol, int movetoRow, int movetoCol, Block block){
		this.currentRow = currentRow;
		this.currentCol = currentCol;
		this.movetoRow = movetoRow;
		this.movetoCol = movetoCol;
		this.block = block;
	}
	
	public String toString() {
		return this.currentRow + " " + this.currentCol + " " + this.movetoRow + " " + this.movetoCol;
	}

}