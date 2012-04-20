import java.awt.Color;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Point2D;


public class Exploder extends Shrinker {
	
	protected double initalx = world.middleOfWorld().getX();
	protected double initaly = world.middleOfWorld().getY();
	
	public Exploder(BallEnvironment ballEnvironment) {
		super(ballEnvironment);
		this.growsize = Math.random() * 10 * this.radius;
		this.color = Color.WHITE;
		this.location.setLocation(initalx, initaly);
		this.change = .05;
	}
	
	public Exploder(double x, double y, BallEnvironment world) {
		super(world);
		this.growsize = Math.random() * 9 * this.radius + (this.radius);
		this.color = Color.WHITE;
		this.location.setLocation(x, y);
		this.change = .05;
	}
	
	@Override
	public void act() {
		if (world.isInsideWorldX(this.location) == false) 
			xVelocity = xVelocity * -1;
		else if (world.isInsideWorldY(this.location) == false)
			yVelocity = yVelocity * -1;
			
		location.setLocation(location.getX() + xVelocity, location.getY() + yVelocity);
		
		((Ellipse2D.Double)shape).x = location.getX();
		((Ellipse2D.Double)shape).y = location.getY();
		
		if (((Ellipse2D.Double)shape).height < growsize && paused == false) {
			((Ellipse2D.Double)shape).height += change;
			((Ellipse2D.Double)shape).width += change;
		}
		
		else if (((Ellipse2D.Double)shape).height > growsize && paused == false) {
			world.removeBall(this);
			new Exploder(this.location.getX() + this.radius, this.location.getY() + this.radius, world);
			new Exploder(this.location.getX() + this.radius, this.location.getY() + this.radius, world);
		}
	}
	
	

}
