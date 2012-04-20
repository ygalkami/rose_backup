import javax.swing.JFrame;

public class AnimatedBallViewer {  
   
   static final int FRAME_WIDTH = 600;
   static final int FRAME_HEIGHT = 500;

   public static void main(String[] args){
      JFrame frame = new JFrame();
 
      frame.setSize(FRAME_WIDTH, FRAME_HEIGHT);
      frame.setTitle("BallAnimation");
      frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

      AnimatedBallComponent component = new AnimatedBallComponent();
      frame.add(component);

      frame.setVisible(true);          // This class has the usual stuff,
      new Thread(component).start();   // except this last line of code.
   }
}