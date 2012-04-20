import java.awt.BorderLayout;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;

import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.border.EtchedBorder;
import javax.swing.border.TitledBorder;

/**
   This frame has a menu with commands to change the font 
   of a text sample.
*/
public class MenuFrame extends JFrame
{
   /**
      Constructs the frame.
   */
	
	
   public MenuFrame()
   {  

      // Construct menu      
      JMenuBar menuBar = new JMenuBar();     
      setJMenuBar(menuBar);
//      menuBar.setLayout(new GridLayout(2, 1));
      menuBar.add(createFileMenu());
      
      setSize(FRAME_WIDTH, FRAME_HEIGHT);
   }

   /**
      Creates the File menu.
      @return the menu
   */
   public JMenu createFileMenu()
   {
      JMenu menu = new JMenu("File");
      menu.add(createEasyItem());
      menu.add(createMediumItem());
      menu.add(createExpertItem());
      menu.add(createNewGameItem());
      menu.add(createFileExitItem());
      menu.setMnemonic(KeyEvent.VK_F);
      return menu;
   }

   /**
      Creates the File->Exit menu item and sets its action listener.
      @return the menu item
   */
   public JMenuItem createFileExitItem()
   {
      JMenuItem item = new JMenuItem("Exit");      
      class MenuItemListener implements ActionListener
      {
         public void actionPerformed(ActionEvent event)
         {
            System.exit(0);
         }
      }      
      ActionListener listener = new MenuItemListener();
      item.addActionListener(listener);
      item.setMnemonic(KeyEvent.VK_X);
      return item;
   }
   
   public JMenuItem createEasyItem()
   {
      JMenuItem item = new JMenuItem("Easy");      
      class MenuItemListener implements ActionListener
      {
         public void actionPerformed(ActionEvent event)
         {
           Window.newGame(Window.easy, Window.easybombs, Window.easyboard);
           Window.frame_Easy.show();
           Window.frame_Medium.hide();
           Window.frame_Expert.hide();
           
         }
      }      
      ActionListener listener = new MenuItemListener();
      item.addActionListener(listener);
      item.setMnemonic(KeyEvent.VK_E);
      return item;
   }
   
   public JMenuItem createMediumItem()
   {
      JMenuItem item = new JMenuItem("Medium");      
      class MenuItemListener implements ActionListener
      {
         public void actionPerformed(ActionEvent event)
         {
           Window.newGame(Window.medium, Window.mediumbombs, Window.mediumboard);
           Window.frame_Easy.hide();
           Window.frame_Medium.show();
           Window.frame_Expert.hide();
         }
      }      
      ActionListener listener = new MenuItemListener();
      item.addActionListener(listener);
      item.setMnemonic(KeyEvent.VK_M);
      return item;
   }
   
   public JMenuItem createExpertItem()
   {
      JMenuItem item = new JMenuItem("Expert");      
      class MenuItemListener implements ActionListener
      {
         public void actionPerformed(ActionEvent event)
         {
           Window.newGame(Window.expert, Window.expertbombs, Window.expertboard);
           Window.frame_Easy.hide();
           Window.frame_Medium.hide();
           Window.frame_Expert.show();
         }
      }      
      ActionListener listener = new MenuItemListener();
      item.addActionListener(listener);
      item.setMnemonic(KeyEvent.VK_T);
      return item;
   }
   
   public JMenuItem createNewGameItem()
   {
      JMenuItem item = new JMenuItem("New Game");      
      class MenuItemListener implements ActionListener
      {
         public void actionPerformed(ActionEvent event)
         {
           Window.newGame(Window.easy, Window.easybombs, Window.easyboard);
           Window.newGame(Window.medium, Window.mediumbombs, Window.mediumboard);
           Window.newGame(Window.expert, Window.expertbombs, Window.expertboard);
           
         }
      }      
      ActionListener listener = new MenuItemListener();
      item.addActionListener(listener);
      item.setMnemonic(KeyEvent.VK_N);
      return item;
   }

   private static final int FRAME_WIDTH = 300;
   private static final int FRAME_HEIGHT = 400;
}


