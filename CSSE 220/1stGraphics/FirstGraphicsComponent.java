import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;

import javax.swing.JComponent;

public class FirstGraphicsComponent extends JComponent {
	@Override
	public void paintComponent(Graphics g){
		Graphics2D g2 = (Graphics2D) g;
		
		Rectangle r = new Rectangle(50, 40, 20, 70);
		g2.draw(r);
		//for(int i=0; i<10; i++){
		r.translate(20, 30);
		g2.setColor(Color.GREEN);
		g2.fill(r);
		g2.setColor(Color.RED);
		g2.draw(r);
		Ellipse2D.Double e = new Ellipse2D.Double(200, 200, 40, 70);
		g2.fill(e);
		g2.draw(e);
		Line2D.Double line = new Line2D.Double(20, 300, 250, 100);
		g2.setColor(Color.MAGENTA);
		g2.draw(line);
		g2.drawString("My String", 10, 150);
		//}
	}
}
