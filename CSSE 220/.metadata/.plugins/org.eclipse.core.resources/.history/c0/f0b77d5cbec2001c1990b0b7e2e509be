import javax.swing.JFrame;


public class Dots {
   
   static final int FRAME_WIDTH = 500;
   static final int FRAME_HEIGHT = 300;

   public static void main(String[] args){
      JFrame frame = new JFrame();
 
      frame.setSize(FRAME_WIDTH, FRAME_HEIGHT);
      frame.setTitle("Dots");
      frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

      MouseDotComponent component = new MouseDotComponent();
      frame.add(component);
      component.addMouseListener(component);

      frame.setVisible(true);
      
   }

}
