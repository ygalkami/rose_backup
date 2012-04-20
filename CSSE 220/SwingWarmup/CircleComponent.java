import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Point2D;

import javax.swing.JComponent;
import javax.swing.JOptionPane;
import java.math.*;

public class CircleComponent extends JComponent {
	int Bradius;
	int Lradius;
	int Ncircles;
	
	public CircleComponent(int Bradius, int Lradius, int Ncircles){
		this.Bradius = Bradius;
		this.Lradius = Lradius;
		this.Ncircles = Ncircles;
	}
	
	@Override
	public void paintComponent(Graphics g){
		double x,y;
		
		Graphics2D g2 = (Graphics2D) g;
		
		for (int i=0; i<= Ncircles; i++){
			x = (this.getWidth() / 2 - ((Lradius) / 2)) + Bradius * Math.cos((2*Math.PI*i)/Ncircles);
			y = (this.getHeight() / 2 - ((Lradius) / 2)) + Bradius * Math.sin((2*Math.PI*i)/Ncircles);
			
			g2.draw(new Ellipse2D.Double(x, y, Lradius, Lradius));
		}

	}
}
