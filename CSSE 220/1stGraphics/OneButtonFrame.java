import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;


public class OneButtonFrame extends JFrame implements ActionListener {
	static final int Frame_WIDTH = 200;
	static final int Frame_HEIGHT = 100;
	
	private JButton button;
	
	public OneButtonFrame() {
		this.button = new JButton("Click Here");
		this.add(button);
		this.button.setBackground(Color.RED);
		this.button.addActionListener(this);
	}
	public static void main(String[] args) {
		JFrame frame = new OneButtonFrame();
		frame.setSize(Frame_WIDTH, Frame_HEIGHT);
		frame.setTitle("Button Tester");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
	}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		if (this.button.getBackground() == Color.RED)
			this.button.setBackground(Color.GREEN);
		else
			this.button.setBackground(Color.RED);
	}
}
