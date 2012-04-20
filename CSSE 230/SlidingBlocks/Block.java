import java.awt.geom.Point2D;
import java.util.ArrayList;
import java.util.HashMap;

// the block class that we use to represent the blocks on the board
public class Block {
	public int width;
	public int height;
	public int row;
	public int col;
	public int relativeWidth;
	public ArrayList<Point2D.Double> allpoints = new ArrayList<Point2D.Double>();
	
	public Block(int height, int width, int row, int col){
		this.width = width;
		this.height = height;
		this.col = col;
		this.row = row;
		this.relativeWidth = col + width;

	}
	
	public boolean equals(Block block) {
		// see if two blocks aer equal
		if (block.row == this.row && block.col == this.col && block.height == this.height && block.width == this.width)
			return true;
		return false;
	}
	
	public boolean contains(Point2D.Double point) {
		// check to see if a certain block contains another point
		if (this.row <= point.x && (this.row + this.height) > point.x && this.col <= point.y && (this.col + this.width) > point.y)
			return true;
		return false;
	}
	
	public void Move(String Direction) {
		// move the block
		if (Direction == "right") {
			this.col += 1;
		}
		else if (Direction == "left")
			this.col -= 1;
		else if (Direction == "down")
			this.row += 1;
		else if (Direction == "up")
			this.row -= 1;
	}
	
	public void MoveRight() {
		for (int i = 0; i < allpoints.size(); i++) {
			allpoints.get(i).y += 1;
		}
		this.col += 1;
	}
	
	public void MoveLeft() {
		for (int i = 0; i < allpoints.size(); i++) {
			allpoints.get(i).y -= 1;
		}
		this.col -= 1;
	}
	
	public void MoveUp() {
		for (int i = 0; i < allpoints.size(); i++) {
			allpoints.get(i).x -= 1;
		}
		this.row -= 1;
	}
	
	public void MoveDown() {
		for (int i = 0; i < allpoints.size(); i++) {
			allpoints.get(i).x += 1;
		}
		this.row += 1;
	}
	
	public String toString() {
		return "[" + this.height + ", " + this.width + ", " + this.row + ", " + this.col + "]";
	}
}