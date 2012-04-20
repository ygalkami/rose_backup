
public class Square extends Rectangle {
	
	private double size;
	
	public Square(Point lowerLeft, double width) {
		super(lowerLeft, new Point(lowerLeft.getX() + width, lowerLeft.getY() + width));
		this.size = width;
	}
	@Override
	public String toString() {
		return String.format("[Square: (%.2f, %.2f), %.2f", this.left, this.right, this.size);
	}

}
