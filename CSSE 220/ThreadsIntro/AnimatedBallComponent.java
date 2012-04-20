import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.geom.Ellipse2D;
import java.util.ArrayList;
import javax.swing.JComponent;


public class AnimatedBallComponent extends JComponent 
                   implements Runnable, MouseListener {
   
   private ArrayList<Ball> balls = new ArrayList<Ball>();
   private boolean moving = true;
   public static final long DELAY = 30;
   public static final int ITERATIONS = 300;

   public AnimatedBallComponent() {
      super();
      balls.add(new Ball(40, 50, 8, 5, Color.BLUE));
      balls.add(new Ball(500, 400, -3, -6, Color.RED));
      balls.add(new Ball(30, 300, 4, -3, Color.GREEN));
      this.addMouseListener(this);
   }

   public void run() {
      for (int i=0; i<ITERATIONS; i++) {
         if (moving){
            for (Ball b:balls)
               b.move();
            this.repaint();
         }
         try {
            Thread.sleep(DELAY);
         } catch (InterruptedException e) {}
      }
   }
   
   public void paintComponent(Graphics g){
      Graphics2D g2 = (Graphics2D)g;
      for (Ball b:balls)
         b.fill(g2);
   }
   
   public void mousePressed (MouseEvent arg0) {
      moving = !moving;
   }
   public void mouseReleased(MouseEvent arg0) {}
   public void mouseClicked(MouseEvent arg0) {}
   public void mouseEntered(MouseEvent arg0) {}
   public void mouseExited(MouseEvent arg0) {}
}

class Ball {
   private double velX, velY;
   private Ellipse2D.Double ellipse;
   private Color color;
   private static final double radius = 15;
   
   public Ball(double cx, double cy, double vx, double vy, Color c){
      this.velX = vx;        
      this.velY = vy;
      this.color = c;
      this.ellipse = new Ellipse2D.Double (
          cx-radius, cy-radius, 2*radius, 2*radius);
   }
   
   public void fill (Graphics2D g2) {
      g2.setColor(this.color);
      g2.fill(this.ellipse);
   } 
   
   public void move (){
      this.ellipse.x += this.velX;
      this.ellipse.y += this.velY;
   }   
}