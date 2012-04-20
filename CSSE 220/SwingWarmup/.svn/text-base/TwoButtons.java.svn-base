import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class TwoButtons extends JFrame{
		static final int Frame_WIDTH = 200;
		static final int Frame_HEIGHT = 100;
		
		public TwoButtons() {
			JPanel pan = new JPanel();
			TwoButtonsToggle button = new TwoButtonsToggle("Toggle Me", Color.RED, Color.GREEN);
			pan.add(button);
			TwoButtonsToggle button2 = new TwoButtonsToggle("Toggle Other", Color.BLUE, Color.ORANGE);
			pan.add(button2);
			button.addActionListener(button2);
			button2.addActionListener(button);
			this.add(pan);
		}
		public static void main(String[] args) {
			JFrame frame = new TwoButtons();
			frame.setSize(Frame_WIDTH, Frame_HEIGHT);
			frame.setTitle("Button Tester");
			frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			frame.setVisible(true);
		}
	}


