import java.awt.Color;
import java.awt.geom.Ellipse2D;


public class Shrinker extends Bouncer {

	protected double shrinksize;
	protected double growsize;
	protected double change = .1;
	protected boolean shrinking = true;
	protected boolean paused = false;
	public Shrinker( BallEnvironment ballEnvironment ) {
		
		super( ballEnvironment );
		this.shrinksize = Math.random() * this.radius;
		this.growsize = Math.random() * 4 * this.radius;
		this.color = Color.MAGENTA;
	}
	
	@Override
	public void act( ) {
		if (world.isInsideWorldX(this.location) == false) 
			xVelocity = xVelocity * -1;
		else if (world.isInsideWorldY(this.location) == false)
			yVelocity = yVelocity * -1;
			
		location.setLocation(location.getX() + xVelocity, location.getY() + yVelocity);
		
		((Ellipse2D.Double)shape).x = location.getX();
		((Ellipse2D.Double)shape).y = location.getY();
		
		if (((Ellipse2D.Double)shape).height > shrinksize && shrinking == true && paused == false) {
			((Ellipse2D.Double)shape).height -= change;
			((Ellipse2D.Double)shape).width -= change;
		}
		else if (((Ellipse2D.Double)shape).height < shrinksize && shrinking == true && paused == false) {
			shrinking = false;
		}
		else if (((Ellipse2D.Double)shape).height < growsize && shrinking == false && paused == false) {
			((Ellipse2D.Double)shape).height += change;
			((Ellipse2D.Double)shape).width += change;
		}
		if (((Ellipse2D.Double)shape).height > growsize && paused == false) {
			shrinking = true;
			this.shrinksize = Math.random() * this.radius;
			this.growsize = Math.random() * 4 * this.radius;
		}			
	}
	
	@Override
	public void pauseOrResume() {
		if (moving == true) {
			this.xVelocity = tempx;
			this.yVelocity = tempy;
			this.act();
			this.moving = false;
			this.die = false;
			this.paused = false;
		}
		else if (moving == false) {
			this.xVelocity = 0;
			this.yVelocity = 0;
			this.die = true;
			this.moving = true;
			this.paused = true;
		}
			
	}
}
