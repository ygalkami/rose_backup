import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;


public class ButtonTester {
	static final int Frame_WIDTH = 200;
	static final int Frame_HEIGHT = 100;
	
	public static void main(String[] args) {
		JFrame frame = new JFrame();
		frame.setSize(Frame_WIDTH, Frame_HEIGHT);
		frame.setTitle("Button Tester");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		JButton button = new JButton("Click here");
		button.addActionListener(new ClickListener());
		frame.add(button);
		
		frame.setVisible(true);
		
	}
}

class ClickListener implements ActionListener {
	
	public void actionPerformed(ActionEvent e){
		System.out.println("Clicked!");
	}
}