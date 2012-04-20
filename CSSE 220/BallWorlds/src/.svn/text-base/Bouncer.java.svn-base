import java.awt.Color;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Point2D;


public class Bouncer extends Mover {

	protected BallEnvironment world;
	
	public Bouncer(BallEnvironment ballEnvironment) {
		super(ballEnvironment);
		this.color = Color.BLUE;
		
		this.world = ballEnvironment;
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
	}
	

}
