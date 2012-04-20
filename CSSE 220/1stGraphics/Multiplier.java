import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;


public class Multiplier extends JFrame implements ActionListener {

	static final int Frame_WIDTH = 180;
	static final int Frame_HEIGHT = 120;

	private JTextField multiplier;
	private JTextField multiplicand;
	private JLabel product;
	
	public Multiplier () {
	     try {

	         UIManager

	               .setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");

	      } catch (ClassNotFoundException e) {

	         e.printStackTrace();

	      } catch (InstantiationException e) {// if the look and feel is not

	         // supported, don't worry about it.

	      } catch (IllegalAccessException e) {

	      } catch (UnsupportedLookAndFeelException e) {

	      }
		JButton button = new JButton("Multiply");
		this.product = new JLabel("0");
		this.multiplier = new JTextField("0");
		this.multiplicand = new JTextField("0");
		JPanel panel = new JPanel();
		panel.setLayout(new GridLayout(4, 2));
		this.add(panel);
		
		panel.add(new JLabel("Multiplicand"));
		panel.add(this.multiplicand);
		panel.add(new JLabel("Multiplier"));
		panel.add(this.multiplier);
		panel.add(new JLabel("Product"));
		panel.add(this.product);
		panel.add(button);
		
		this.multiplicand.setHorizontalAlignment(JTextField.RIGHT);
		this.multiplier.setHorizontalAlignment(JTextField.RIGHT);
		this.product.setHorizontalAlignment(JLabel.RIGHT);
		
		button.addActionListener(this);
		
	}
	public void actionPerformed(ActionEvent e) {
		int first = Integer.parseInt(this.multiplicand.getText());
		int second = Integer.parseInt(this.multiplier.getText());
		
		this.product.setText(String.format("%,d", first * second));

	}
	
	public static void main(String[] args){
		JFrame frame = new Multiplier();
		frame.setSize(Frame_WIDTH, Frame_HEIGHT);
		frame.setTitle("Multiplier");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
	}

}
