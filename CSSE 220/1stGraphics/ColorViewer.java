import java.awt.Color;
import javax.swing.JFrame;
import javax.swing.JOptionPane;


public class ColorViewer {
	static final int Frame_WIDTH = 300;
	static final int Frame_HEIGHT = 500;
	
	public static void main(String[] args) {
		JFrame frame = new JFrame();
		frame.setSize(Frame_WIDTH, Frame_HEIGHT);
		frame.setTitle("Color Viewer");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		String input;
		input = JOptionPane.showInputDialog("Red(0.0 - 1.0):");
		float red = Float.parseFloat(input);
		input = JOptionPane.showInputDialog("Green(0.0 - 1.0):");
		float green = Float.parseFloat(input);
		input = JOptionPane.showInputDialog("Blue(0.0 - 1.0):");
		float blue = Float.parseFloat(input);
		Color theColor = new Color(red, green, blue);
		
		ColorSquareComponent c = new ColorSquareComponent(theColor);
		frame.add(c);
		
		frame.setVisible(true);
	}
}
