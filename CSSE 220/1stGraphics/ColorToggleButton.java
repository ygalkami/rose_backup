import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;


public class ColorToggleButton extends JButton implements ActionListener {
	
	private Color firstColor, secondColor;
	
	public ColorToggleButton(String message, Color first, Color second){
		super(message);
		this.firstColor = first;
		this.secondColor = second;
		this.setBackground(first);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		if (this.getBackground() == this.firstColor)
			this.setBackground(this.secondColor);
		else
			this.setBackground(this.firstColor);
	}

}
