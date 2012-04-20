import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;

import javax.swing.JComponent;


public class ColorSquareComponent extends JComponent {
	private Color fillcolor;
	
	public ColorSquareComponent(Color acolor){
		this.fillcolor = acolor;
	}
	
	@Override
	public void paintComponent(Graphics g){
		Graphics2D g2 = (Graphics2D) g;
		int SQUARE_WIDTH = 100;
		g2.setColor(this.fillcolor);
		
		Rectangle square = new Rectangle((this.getWidth() - SQUARE_WIDTH) / 2, (this.getHeight() - SQUARE_WIDTH) / 2, SQUARE_WIDTH, SQUARE_WIDTH);
		g2.fill(square);
	}
}

