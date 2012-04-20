/* CounterThreadsRadio class.  
   Created by Claude Anderson, January 4, 2008.
   Creates counters that can count up or down,
   under user control.  Illustrates threads.
   There are more RadioButton methods that you might want to explore.
 */

import javax.swing.*;  
import java.awt.*;
import java.awt.event.*;

public class CounterThreadsRadioButtons {
  
  public static void main (String []args) {
    JFrame win = new JFrame();
    Container c = win.getContentPane(); 
    win.setSize(600, 250);
    c.setLayout(new GridLayout(2, 2, 10, 0));
    c.add(new CounterPaneRadio(200));
    c.add(new CounterPaneRadio(500));
    c.add(new CounterPaneRadio(50)); // this one will count fast!
    c.add(new CounterPaneRadio(1000));

    win.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    win.setVisible(true);  
   }
}

/* A CounterPane object has a counter (dsplayed in a JLabel) and 
   three buttons to control it.  Creates a thread whose counting 
   speed is set when the CounterPane is constructed.            */

class CounterPaneRadio extends JComponent implements Runnable {

  private int delay;         // sleep time before changing counter;
  private int direction = 0; //  current increment of counter
  private JLabel display = new JLabel("0");
  private static final int COUNT_UP    =   1; // Declaring these 
  private static final int COUNT_DOWN   = -1; // constants avoids
  private static final int COUNT_STILL  =  0; // "magic numbers"
  private static final int BORDER_WIDTH =  3; // in the code. 
  private static final int FONT_SIZE    = 60;

  // Constructor.  The parameter is the sleep time 
  // between counter updates.  
  
  public CounterPaneRadio(int delay) {
    
    JRadioButton upButton   = new JRadioButton("Up");
    JRadioButton downButton = new JRadioButton("Down");
    JRadioButton stopButton = new JRadioButton("Stop");
    
    ButtonGroup group = new ButtonGroup();
    group.add(upButton);
    group.add(downButton);
    group.add(stopButton);
    stopButton.setSelected(true);

    this.delay = delay; // milliseconds to sleep
    
    this.setLayout(new GridLayout(2, 1, 5, 5)); 
       // top row for display, bottom for buttons.
       
    JPanel buttonPanel = new JPanel();
    display.setHorizontalAlignment(SwingConstants.CENTER);
    display.setFont(new Font(null, Font.BOLD, FONT_SIZE));
       // make the number display big!  
    
    this.add(display);
    this.add(buttonPanel);
    this.setBorder(BorderFactory.createLineBorder(Color.blue, 
                                                  BORDER_WIDTH));
        // Any Swing component can have a border.
    this.addButton(buttonPanel, upButton,   COUNT_UP);
    this.addButton(buttonPanel, downButton, COUNT_DOWN);
    this.addButton(buttonPanel, stopButton, COUNT_STILL);
  
    Thread t = new Thread(this);
    t.start();
   }
  
  // Adds a control button to the panel, and creates an
  // actionlistener that sets the count direction.
  private void addButton(Container container, 
                         JRadioButton button, 
                         final int dir) {
    container.add(button);
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

