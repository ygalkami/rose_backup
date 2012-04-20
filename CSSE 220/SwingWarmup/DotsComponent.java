import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Point2D;
import java.util.ArrayList;

import javax.swing.JComponent;
import java.util.ArrayList;

public class DotsComponent extends JComponent implements MouseListener {
	
	private int x = -50, y = -50;
	public static final int RADIUS = 5;
	static ArrayList<Point2D> points = new ArrayList<Point2D>();

	public void mouseClicked(MouseEvent arg0) {}

	public void mouseEntered(MouseEvent arg0) {}

	public void mouseExited(MouseEvent arg0) {}

	public void mousePressed(MouseEvent arg0) {
		points.add(new Point2D.Double(arg0.getX(), arg0.getY()));
		this.repaint();
	}

	public void mouseReleased(MouseEvent arg0) {}
	
	public void paintComponent(Graphics g){
		Graphics2D g2 = (Graphics2D) g;
		for (int i=0; i<points.size(); i++) {
			g2.fill(new Ellipse2D.Double(points.get(i).getX() - this.RADIUS, points.get(i).getY() - this.RADIUS, 2*this.RADIUS, 2*this.RADIUS));
			if (i < 1){
				
			}
			else	
				g2.draw(new Line2D.Double(points.get(i).getX(), points.get(i).getY(), points.get(i-1).getX(), points.get(i-1).getY()));
		}
		
	}
}