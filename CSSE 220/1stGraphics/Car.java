import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.Shape;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Point2D;


public class Car {
	private int xLeft, yTop;
	public static int WIDTH = 60;
	public static int HEIGHT = WIDTH / 2;
	
	public Car(int x, int y){
		this.xLeft = x;
		this.yTop = y;
	}
	
	public void draw(Graphics2D g2){
		int cH = HEIGHT / 3; //component height
		
		Rectangle body = new Rectangle(xLeft, yTop + cH, WIDTH, cH);
		Ellipse2D.Double frontTire = new Ellipse2D.Double(xLeft + cH, yTop + 2*cH, cH, cH);
		Ellipse2D.Double rearTire = new Ellipse2D.Double(xLeft + 4*cH, yTop + 2*cH, cH, cH);
		Point2D.Double p1 = new Point2D.Double(xLeft + cH, yTop + cH);
		Point2D.Double p2 = new Point2D.Double(xLeft + 2*cH, yTop);
		Point2D.Double p3 = new Point2D.Double(xLeft + 4*cH, yTop);
		Point2D.Double p4 = new Point2D.Double(xLeft + 5*cH, yTop + cH);
		Line2D.Double frontWindshield = new Line2D.Double(p1, p2);
		Line2D.Double top = new Line2D.Double(p2, p3);
		Line2D.Double rearWindshield = new Line2D.Double(p3, p4);
		
		Shape [] parts = {body, frontWindshield, rearWindshield, frontTire, rearTire, top};
		
		for(Shape s : parts){
			g2.draw(s);
		}
	}
}
