import static java.lang.Math.max;
import static java.lang.Math.min;

public class Rectangle {
	
	protected double right, top, bottom, left;
	/**
	 * Construct a rectangle from these points
	 * @param p1 one corner of the rectangle.
	 * @param p2 a second corner of the rectangle.
	 */
	public Rectangle(Point p1, Point p2){
		this.left = min(p1.getX(), p2.getX());
		this.right = max(p1.getX(), p2.getX());
		this.top = max(p1.getY(), p2.getY());
		this.bottom = min(p1.getY(), p2.getY());
	}
	/**
	 * Is this rectangle equivalent to another one?
	 * @param other the other rectangle
	 * @return true if the rectangles are equivilent
	 */
	public boolean equals(Object other) {
		if (other == null)
			return false;
		if (!(other instanceof Rectangle))
			return false;
		
		Rectangle r = (Rectangle) other;
		
		return this.left == r.left && this.right == r.right && this.top == r.top && this.bottom == r.bottom;
	}
	/**
	 * Returns the width of the rectangle
	 * @return the width of the rectangle
	 */
	public double getWidth() {
		return this.right - this.left;
	}
	/**
	 * Returns the height of the rectangle.
	 * @return the height of the rectangle.
	 */
	public double getHeight() {
		return this.top - this.bottom;
	}
	/**
	 * Returns the area of the rectangle
	 * @return the area of the rectangle
	 */
	public double getArea() {
		return this.getWidth() * this.getHeight();
	}
	/**
	 * returns the center of the rectangle as a Point object
	 * @return the center of the rectangle as a point object
	 */
	public Point getCenter() {
		return new Point((this.left + this.right) / 2, (this.top + this.bottom) / 2);
	}
	/**
	 * Does rectangle r intersect this rectangle?
	 * @param r the second rectangle
	 * @return true if the rectangles intersect, false if they don't
	 */
	public boolean intersects(Rectangle r) {
		return !(this.left > r.right || r.left > this.left || this.bottom > r.top || r.bottom > this.top);
	}
	/**
	 * Returns a String representation of this Point
	 * @return a String representation of this Point
	 */
	@Override
	public String toString() {
		//return String.format("[Point: %.2f, %.2f]", , );
		return String.format("Left: %.2f \nRight: %.2f \nTop: %.2f \nBottom: %.2f", this.left, this.right, this.top, this.bottom);
	}
	/**
	 * Moves this rectangle by dx in the x-direction <br />
	 * and by dy in the y-direction
	 * @param dx amount to move in the x-direction
	 * @param dy amount to move in the y-direction
	 */
	public void translate(double dx, double dy) {
		this.left += dx;
		this.right += dx;
		this.top += dy;
		this.bottom += dy;
	}
	/**
	 * is this rectangle inside of rectangle p
	 * @param p the other rectangle
	 * @return true if this rectangle is inside of p, false if it isn't
	 */
	public boolean isInisde(Point p) {
		if (p.getX() > this.left && p.getX() < this.right && p.getY() < this.top && p.getY() > this.bottom)
			return true;
		else
			return false;
	}
	/**
	 * return the rectangle created by having this rectangle intersting another rectangle r
	 * @param r the rectangle interesting this rectangle
	 * @return a rectangle created by the two intersecting rectangles
	 */
	public Rectangle intersection(Rectangle r) {
		double x1 = 0, x2 = 0, y1 = 0, y2 = 0;
		if (this.intersects(r) == false) {
			return null;
		}
		if (this.right >= r.right)
			x2 = r.right;
		if (r.right >= this.right)
			x2 = this.right;
		if (this.left >= r.left)
			x1 = this.left;
		if (r.left >= this.left)
			x1 = r.left;
		if (this.top >= r.top)
			y1 = r.top;
		if (r.top >= this.top)
			y1 = this.top;
		if (this.bottom >= r.bottom)
			y2 = this.bottom;
		if (r.bottom >= this.bottom)
			y2 = r.bottom;
	
		return new Rectangle(new Point(x1, y1), new Point(x2, y2));
	}
	/**
	 * Return the boundingbox of the rectangle
	 * @return the boundingbox of the rectangle
	 */
	public Rectangle boundingbox() {
		return this;
	}
	
	
}
