import java.awt.Color;
import java.awt.Shape;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Point2D;


public class Dud extends Ball {
	
	protected Point2D.Double location;
	protected double radius;
	protected Color color;
	protected Shape shape;

	public Dud() {
		// TODO Auto-generated constructor stub
	}

	public Dud(BallEnvironment ballEnvironment) {
		super(ballEnvironment);
		double x = Math.random() * ballEnvironment.middleOfWorld().getX() * 2;
		double y = Math.random() * ballEnvironment.middleOfWorld().getY() * 2;
		this.location = new Point2D.Double(x, y);
		this.color = Color.ORANGE;
		this.radius = 10;
		this.shape = new Ellipse2D.Double(x - this.radius, y - this.radius, radius*2, radius*2);
		ballEnvironment.addBall(this);
	}

	public Color getColor() {
		// TODO Auto-generated method stub
		return this.color;
	}

	public Shape getShape() {
		// TODO Auto-generated method stub
		return this.shape;
	}

	public double distanceFrom(Point2D point) {
		// TODO Auto-generated method stub
		return Double.MAX_VALUE;
	}

	public void moveTo(Point2D point) {
		// TODO Auto-generated method stub

	}

	public void act() {
		// TODO Auto-generated method stub

	}

	public void die() {
		// TODO Auto-generated method stub

	}

	public void pauseOrResume() {
		// TODO Auto-generated method stub

	}

}
