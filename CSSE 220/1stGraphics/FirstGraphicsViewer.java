import javax.swing.JFrame;


public class FirstGraphicsViewer {

	static final int Frame_WIDTH = 300;
	static final int Frame_HEIGHT = 500;
	
	public static void main(String[] args) {
		JFrame frame = new JFrame();
		frame.setSize(Frame_WIDTH, Frame_HEIGHT);
		frame.setTitle("First Graphics");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		FirstGraphicsComponent c = new FirstGraphicsComponent();
		frame.add(c);
		
		frame.setVisible(true);
	}
	
	
	
}
