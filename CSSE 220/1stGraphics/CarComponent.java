import java.awt.Graphics;
import java.awt.Graphics2D;
import javax.swing.JComponent;


public class CarComponent extends JComponent {
	@Override
	public void paintComponent(Graphics g){
		Graphics2D g2 = (Graphics2D) g;
		
		Car car1 = new Car(10, 10);
		int x = this.getWidth() - Car.WIDTH - 10;
		int y = this.getHeight() - Car.HEIGHT - 10;
		Car car2 = new Car(x, y);
		car1.draw(g2);
		car2.draw(g2);
		
		
	}
}
