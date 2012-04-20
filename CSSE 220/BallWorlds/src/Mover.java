import java.awt.Color;
import java.awt.Shape;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Point2D;


public class Mover extends DudThatMoves {
	protected Point2D location;
	protected double xVelocity;
	protected double yVelocity;
	protected double tempx;
	protected double tempy;
	protected boolean moving = false;
	protected boolean die = false;
	protected BallEnvironment world;

	public Mover(BallEnvironment ballEnvironment) {
		super(ballEnvironment);
		double speed = Math.random() * .7;
		double angle = Math.random() * 2 * Math.PI;
		
		this.xVelocity = tempx = speed * Math.cos(angle);
		this.yVelocity = tempy = speed * Math.sin(angle);
		
		this.color = Color.BLACK;
		
		double x = ballEnvironment.middleOfWorld().getX();
		double y = ballEnvironment.middleOfWorld().getY();
		this.location = new Point2D.Double(x, y);
		
		this.world = ballEnvironment;
	}

	@Override
	public void act() {
		location.setLocation(location.getX() + this.xVelocity, location.getY() + this.yVelocity);
		
		((Ellipse2D.Double)shape).x = location.getX();
		((Ellipse2D.Double)shape).y = location.getY();
		
	}
	
	@Override
	public double distanceFrom(Point2D p) {
		double xdist = p.getX() - this.location.getX();
		double ydist = p.getY() - this.location.getY();
		
		return Math.sqrt((xdist * xdist) + (ydist * ydist));
	}
	
	@Override
	public void pauseOrResume() {
		if (moving == true) {
			this.xVelocity = tempx;
			this.yVelocity = tempy;
			this.act();
			this.moving = false;
			this.die = false;
		}
		else if (moving == false) {
			this.xVelocity = 0;
			this.yVelocity = 0;
			this.die = true;
			moving = true;
		}
			
	}
	
	@Override
	public void moveTo(Point2D point) {
		location.setLocation(point.getX(), point.getY());
	}
	
	@Override
	public void die() {
		world.removeBall(this);
	}
}
