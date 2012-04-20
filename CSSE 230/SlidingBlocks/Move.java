
public class Move {
	
	public int moveToX;
	public int moveToY;
	public int currentPosX;
	public int currentPosY;
	public String Direction = "";
	public String oppositeDirection = "";
	public Block block;

	//store current point and point to be moved to
	public Move(int currentY, int currentX, int movetoY, int movetoX, Block block, String direction, String oppositeDirection){
		this.currentPosX = currentX;
		this.currentPosY = currentY;
		this.moveToX = movetoX;
		this.moveToY = movetoY;
		this.block = block;
		this.Direction = direction;
		this.oppositeDirection = oppositeDirection;
	}
	
	public Move(int currentRow, int currentCol, int movetoRow, int movetoCol) {
		this.currentPosY = currentRow;
		this.currentPosX = currentCol;
		this.moveToY = movetoRow;
		this.moveToX = movetoCol;
	}
	
	public String toString() {
		return this.currentPosY + " " + this.currentPosX + " " + this.moveToY + " " + this.moveToX;
	}

}