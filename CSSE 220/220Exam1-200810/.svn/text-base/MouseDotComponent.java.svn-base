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

public class MouseDotComponent extends JComponent implements MouseListener {

	private ArrayList<Point2D.Double> points = new ArrayList<Point2D.Double>();
	private ArrayList<Point2D.Double> greenPoints = new ArrayList<Point2D.Double>();
	private static ArrayList<Ellipse2D.Double> circles = new ArrayList<Ellipse2D.Double>();

	private static final int RADIUS = 5; // Radius of each dot.
	double bigdistance = 0;
	Point2D.Double farpoint = new Point2D.Double(-10, -10);

	// These MouseListerner methods do not need to do anything in this program
	public void mouseClicked(MouseEvent arg0) {}

	public void mouseEntered(MouseEvent e) {}

	public void mouseExited(MouseEvent e) {}

	public void mouseReleased(MouseEvent e) {}

	public void mousePressed(MouseEvent e) {
		int num = this.points.size();

		if (e.getButton() != 3) {
			Point2D.Double p = new Point2D.Double(e.getX(), e.getY());
			points.add(p);

		} else {
			for (int i = 0; i < num; i++) {
				Point2D.Double p = this.points.get(i);
				Point2D.Double click = new Point2D.Double(e.getX(), e.getY());

				if (p.distance(click) < 5 && p.distance(this.points.get(0)) > 5) {
					greenPoints.add(p);
				}
			}
		}
		this.repaint();
	}

	// Auxiliary method called by PaintComponent to draw a dot.
	private static void drawDot(Graphics2D g2, Point2D.Double center,
			Color color) {
		Ellipse2D.Double e = new Ellipse2D.Double(center.x - RADIUS, center.y
				- RADIUS, 2 * RADIUS, 2 * RADIUS);
		g2.setColor(color);
		g2.fill(e);
		circles.add(e);
	}

	@Override
	public void paintComponent(Graphics g) {
		Graphics2D g2 = (Graphics2D) g;
		int num = this.points.size();

		// Draw the points, and lines between them.
		for (int i = 0; i < num; i++) {
			Point2D.Double p = this.points.get(i);
			if (i == 0) {
				drawDot(g2, p, Color.RED);
			} 
			else {
				if (p.distance(this.points.get(0)) > bigdistance) {
					bigdistance = p.distance(this.points.get(0));
					farpoint = p;
				} else
					drawDot(g2, p, Color.BLACK);
			}
			if (i > 0) {
				Point2D.Double p2 = points.get(i - 1);
				g2.setColor(Color.BLACK);
				g2.draw(new Line2D.Double(p.x, p.y, p2.x, p2.y));
			}
		}

		for (int i = 0; i < greenPoints.size(); i++) {
			drawDot(g2, greenPoints.get(i), Color.GREEN);
		}
		
		drawDot(g2, farpoint, Color.MAGENTA);
		if (num > 1)
			drawDot(g2, this.points.get(num - 1), Color.BLUE);
	}
}