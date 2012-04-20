import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;


public class OneButtonFrame2 extends JFrame {
	static final int Frame_WIDTH = 200;
	static final int Frame_HEIGHT = 100;
	
	public OneButtonFrame2() {
		JPanel pan = new JPanel();
		ColorToggleButton button = new ColorToggleButton("Click Here", Color.RED, Color.GREEN);
		pan.add(button);
		ColorToggleButton button2 = new ColorToggleButton("Click here", Color.BLUE, Color.ORANGE);
		pan.add(button2);
		button.addActionListener(button);
		this.add(pan);
	}
	public static void main(String[] args) {
		JFrame frame = new OneButtonFrame2();
		frame.setSize(Frame_WIDTH, Frame_HEIGHT);
		frame.setTitle("Button Tester");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
	}
}
