/* CounterThreads class.  
   Created by Claude Anderson, Modified January 4, 2008.
   Creates counters that can count up or down,
   under user control.  Illustrates threads.
 */

import javax.swing.*;  
import java.awt.*;
import java.awt.event.*;

public class CounterThreads {
  
  public static void main (String []args) {
    JFrame win = new JFrame();
    Container c = win.getContentPane(); 
    win.setSize(600, 250);
    c.setLayout(new GridLayout(2, 2, 10, 0));
    c.add(new CounterPane(200));
    c.add(new CounterPane(500));
    c.add(new CounterPane(50)); // this one will count fast!
    c.add(new CounterPane(1000));

    win.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    win.setVisible(true);  
   }
}

/* A CounterPane object has a counter (dsplayed in a JLabel) and 
   three buttons to control it.  Creates a thread whose counting 
   speed is set when the CounterPane is constructed.            */

class CounterPane extends JComponent implements Runnable {

  private int delay;    // sleep time before changing counter
  private int direction = 0; //  current increment of counter
  private JLabel display = new JLabel("0");
  
  // Constants to define counting directions:
  private static final int COUNT_UP    =   1; // Declaring these 
  private static final int COUNT_DOWN   = -1; // constants avoids
  private static final int COUNT_STILL  =  0; // "magic numbers"
  
  private static final int BORDER_WIDTH =  3;  
  private static final int FONT_SIZE    = 60;

  // Constructor.  The parameter is the sleep time 
  // between counter updates.  
  
  public CounterPane(int delay) {
    
    JButton upButton   = new JButton("Up");     // Note that these do
    JButton downButton = new JButton("Down");   // NOT have to be fields
    JButton stopButton = new JButton("Stop");   // of this class.

    this.delay = delay; // milliseconds to sleep
    
    this.setLayout(new GridLayout(2, 1, 5, 5)); 
       // top row for display, bottom for buttons.
       
    JPanel buttonPanel = new JPanel();
    buttonPanel.setLayout(new GridLayout(1, 3, 8, 1));
    display.setHorizontalAlignment(SwingConstants.CENTER);
    display.setFont(new Font(null, Font.BOLD, FONT_SIZE));
       // make the number display big!  
    
    this.add(display);
    this.add(buttonPanel);
    this.setBorder(BorderFactory.createLineBorder(Color.blue, 
                                                  BORDER_WIDTH));
    // Any Swing component can have a border.
    this.addButton(buttonPanel, upButton,   Color.orange, COUNT_UP);
    this.addButton(buttonPanel, downButton, Color.cyan,   COUNT_DOWN);
    this.addButton(buttonPanel, stopButton, Color.pink,   COUNT_STILL);
  
    Thread t = new Thread(this);
    t.start();
  }
  
  // Adds a control button to the panel, and creates an
  // actionlistener that sets the count direction.
  private void addButton(Container container, 
                         JButton button, 
                         Color color, 
                         final int dir) {
    container.add(button);
    button.setBackground(color);
    button.addActionListener(new ActionListener () { 
       public void actionPerformed(ActionEvent e) { 
         direction = dir; }});
  } 
  
  public void run() {
    try {
      do {
        Thread.sleep(delay);
        display.setText(Integer.parseInt(display.getText()) 
                        + direction  + "");
      } while (true);
    } catch (InterruptedException e) { }
  }
}

