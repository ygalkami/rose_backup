import java.awt.geom.Point2D;
import java.util.ArrayList;
import java.util.HashMap;


public class Block {
	public int width;
	public int height;
	public int row;
	public int col;
	public int relativeWidth;
	public int relativeHeight;
	
	public Block(int height, int width, int row, int col){
		this.width = width;
		this.height = height;
		this.col = col;
		this.row = row;
		this.relativeWidth = col + width;
		this.relativeHeight = row + height;
	}

	public boolean equals(Block block) {
		if (block.row == this.row && block.col == this.col && block.height == this.height && block.width == this.width)
			return true;
		return false;
	}
	
	public boolean contains(Point2D.Double point) {
		if (this.row <= point.x && (this.row + this.height) > point.x && this.col <= point.y && (this.col + this.width) > point.y)
			return true;
		return false;
	}
	
	public void Move(int row, int col) {
		this.row = row;
		this.col = col;
	}
	
	public String toString() {
		return "[" + this.height + ", " + this.width + ", " + this.row + ", " + this.col + "]";
	}
}