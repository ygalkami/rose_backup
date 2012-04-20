import static java.lang.Math.PI;
import static java.lang.Math.sqrt;

public class Circle {
	
	private Point center;
	private double radius;
	/**
	 * Construct a circle with this center and radius
	 * @param c Center of the circle
	 * @param r radius of the circle
	 */
	public Circle(Point c, double r) {
		this.radius = r;
		this.center = new Point(c.getX(), c.getY());
	}
	/**
	 * return the area of the circle
	 * @return the area of the circle
	 */
	public double area() {
		return PI*this.radius*this.radius;
	}
	/**
	 * return the center of the circle as a point object
	 * @return the center of the circle as a point object
	 */
	public Point getCenter() {
		return this.center;
	}
	/**
	 * return the radius of the circle
	 * @return the radius of the circle
	 */
	public double getRadius() {
		return this.radius;
	}
	/**
	 * move the circle by dx in the x direction and dy in the y direction
	 * @param dx amount to move in the x direction
	 * @param dy amount to move in the y direction
	 */
	public void translate(double dx, double dy) {
		this.center.translate(dx, dy);
	}
	/**
	 * Returns a string representation of this circle
	 * @return a string representation of this circle
	 */
	@Override
	public String toString() {
		return String.format("Center: %.2f, %.2f \nRadius: %.2f", this.center.getX(), this.center.getY(), this.radius);
	}
	/**
	 * Return the distance between this circle and a circle r
	 * @param r another circle
	 * @return the distance between this circle and the circle r
	 */
	public double distance(Circle r) {
		return this.center.distance(r.center);
	}
	/**
	 * Does this circle and a circle r intersect
	 * @param r a second circle
	 * @return true if they intersect, and false if they don't
	 */
	public boolean intersects(Circle r) {
		if (this.distance(r) <= this.radius + r.radius || this.distance(r) <= r.radius + this.radius){
			return true;
	}
		else
			return false;
	}
	/**
	 * Does this circle intersect a rectangle r?
	 * @param r a rectangle
	 * @return true if they intersect, and false if they don't
	 */
	public boolean intersects(Rectangle r) {
		if (r.getCenter().distance(this.center) <= this.radius + sqrt(r.getWidth()*r.getWidth() + r.getHeight()*r.getHeight()))
			return true;
		else
			return false;
	}
	/**
	 * Is a point p inside of the circle
	 * @param p a point
	 * @return true if p is inside of this circle, false if it is not
	 */
	public boolean isInside(Point p){
		if (p.distance(this.center) < this.radius)
			return true;
		else
			return false;
	}
	/**
	 * return a rectangle that this circle is circumscriped in
	 * @return a rectangle that bounds this circle
	 */
	public Rectangle boundingbox() {
		double x1 = this.center.getX() - this.radius;
		double x2 = this.center.getX() + this.radius;
		double y1 = this.center.getY() - this.radius;
		double y2 = this.center.getY() + this.radius;
		
		return new Rectangle(new Point(x1, y1), new Point(x2, y2));
	}
	/**
	 * Is this circle equivaliant to another
	 * @return true if this circle and another are equivalent
	 */
	public boolean equals(Object other) {
		if (other == null)
			return false;
		if (!(other instanceof Circle))
			return false;
		Circle c = (Circle) other;
		
		return this.center.getX() == c.center.getX() && this.center.getY() == c.center.getY() && this.radius == c.radius;
	}
}
