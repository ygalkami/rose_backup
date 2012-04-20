import javax.swing.JFrame;
import javax.swing.JOptionPane;

public class CircleOfCircles {
	static int Frame_WIDTH;
	static int Frame_HEIGHT;
	
	public static void main(String[] args) {
		JFrame frame = new JFrame();
		//frame.setSize(Frame_WIDTH, Frame_HEIGHT);
		frame.setTitle("Circle of Circles");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		String input;
		input = JOptionPane.showInputDialog("Big Circle Radius:");
		float Bradius = Float.parseFloat(input);
		input = JOptionPane.showInputDialog("Small Circle Radius:");
		float Lradius = Float.parseFloat(input);
		input = JOptionPane.showInputDialog("Number of Circles:");
		float Ncircles = Float.parseFloat(input);
		Frame_WIDTH = (int) (Bradius * 2  + Lradius * 2);
		Frame_HEIGHT = (int) (Bradius * 2 + Lradius * 2);
		frame.setSize(Frame_WIDTH, Frame_HEIGHT);
		CircleComponent c = new CircleComponent((int) Bradius, (int) Lradius, (int) Ncircles);

		frame.add(c);
		
		frame.setVisible(true);
	}
}
