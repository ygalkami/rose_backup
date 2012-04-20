import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.geom.Ellipse2D;

import javax.swing.JComponent;


public class MouseDotComponent extends JComponent implements MouseListener {
	
	private int x = 100, y = 50;
	public static final int RADIUS = 5;
	
	

	public void mouseClicked(MouseEvent arg0) {}

	public void mouseEntered(MouseEvent arg0) {}

	public void mouseExited(MouseEvent arg0) {}

	public void mousePressed(MouseEvent arg0) {
		this.x = arg0.getX();
		this.y = arg0.getY();
		this.repaint();
	}

	public void mouseReleased(MouseEvent arg0) {}
	
	public void paintComponent(Graphics g){
		Graphics2D g2 = (Graphics2D) g;
		g2.fill(new Ellipse2D.Double(this.x - this.RADIUS, this.y - this.RADIUS, 2*this.RADIUS, 2*this.RADIUS));
	}
}
