import java.awt.Color;
import java.awt.geom.Ellipse2D;


public class DudThatMoves extends Dud {

	protected double xVelocity;
	protected double yVelocity;
	
	public DudThatMoves() {
		
	}

	public DudThatMoves(BallEnvironment ballEnvironment) {
		super(ballEnvironment);
		double speed = Math.random() * .7;
		double angle = Math.random() * 2 * Math.PI;
		xVelocity = speed * Math.cos(angle);
		yVelocity = speed * Math.sin(angle);
		this.color = Color.LIGHT_GRAY;
	}
	
	@Override
	public void act() {
		location.setLocation(location.getX() + this.xVelocity, location.getY() + this.yVelocity);
		
		((Ellipse2D.Double)shape).x = location.getX();
		((Ellipse2D.Double)shape).y = location.getY();
	}
	
}
