import java.awt.Color;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Point2D;


public class SpecialBall extends Mover {
	
	protected double Dangle = 0;
	protected double Rangle;
	protected double Bradius;
	protected Point2D.Double center;
	
	public SpecialBall(BallEnvironment ballEnvironment) {
		super(ballEnvironment);
		this.color = Color.CYAN;
		
		this.Bradius = 100;
		this.radius = 10;
		double x = ballEnvironment.middleOfWorld().getX();
		double y = ballEnvironment.middleOfWorld().getY();
		this.location = new Point2D.Double(x, y);
		this.center = new Point2D.Double(x, y);
	}
	
	public SpecialBall(double x, double y, BallEnvironment ballEnvironment) {
		super(ballEnvironment);
		this.color = Color.CYAN;
		
		this.Bradius = 30;
		this.radius = 10;
		this.location = new Point2D.Double(x, y);
		this.center = new Point2D.Double(x, y);
	}
	
	@Override
	public void act() {
		  this.Rangle = Dangle * (Math.PI / 180);
		  
		  double bigx = this.center.getX() + this.Bradius * Math.cos(this.Rangle);
		  double bigy = this.center.getY() + this.Bradius * Math.sin(this.Rangle);
		  double smallx = bigx + this.radius * Math.cos(20 * this.Rangle);
		  double smally = bigy + this.radius * Math.sin(20 * this.Rangle);
		  
		  location.setLocation(smallx, smally);
		  
		  ((Ellipse2D.Double)shape).x = location.getX();
		  ((Ellipse2D.Double)shape).y = location.getY();
		  
		  if (Dangle < 360) {
			  Dangle++;
		  }
		  else if (this.radius + this.Bradius < world.middleOfWorld().getY()) {
			  Dangle = 0;
			  this.radius += 2;
			  this.Bradius += 7;
		  }
		  else if (this.radius + this.Bradius > world.middleOfWorld().getY()) {
			  this.die();
			  new SpecialBall(Math.random() * world.middleOfWorld().getX() + (this.radius + this.Bradius), world.middleOfWorld().getY(), world);
			  new SpecialBall(Math.random() * world.middleOfWorld().getX() + (this.radius + this.Bradius), world.middleOfWorld().getY(), world);
		  }
		  
	}
	
	@Override
	public void pauseOrResume() {
		if (moving == true) {
			this.act();
			this.moving = false;
		}
		else
			location.setLocation(location.getX(), location.getY());
			this.moving = true;
	}

}