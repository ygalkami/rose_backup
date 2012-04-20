import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;



public class SpellCheckerWindow extends JFrame {
	// Width of the frame.
	public static final int DEFAULT_FRAME_WIDTH = 600;

	// Height of the frame.
	public static final int DEFAULT_FRAME_HEIGHT = 500;

	// Dictionary to be used to check for misspelled words.
	public static final String DICTIONARY = "dictionary3.txt";

	// Dictionary to be used to check for misspelled words.
	public static final String DICTIONARY2 = "dictionary.txt";

	// Array list of corrections.
	public static ArrayList<String> corrections = new ArrayList<String>();

	String[] test = { "test", "this" };

	// text list.
	TextPanel textPanel;

	// Dictionary object.
	Dictionary dictionary;
	
	/**
	 * Creates the frame and adds all of the components.
	 */
	public SpellCheckerWindow() {
		this.setLayout(new FlowLayout());

		//creates the Menu Bar.  
		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		menuBar.add(createFileMenu());

		this.dictionary = new Dictionary(DICTIONARY);
		try {
			//this.dictionary.loadDictionary();
			//this.dictionary.loadDictionary(DICTIONARY2);
			this.dictionary.loadDictionary("special/english-words.10");
			this.dictionary.loadDictionary("special/english-words.20");
			this.dictionary.loadDictionary("special/english-words.35");
			this.dictionary.loadDictionary("special/english-words.40");
			this.dictionary.loadDictionary("special/english-words.50");
			this.dictionary.loadDictionary("special/english-words.55");
			this.dictionary.loadDictionary("special/english-words.60");
			this.dictionary.loadDictionary("special/english-words.70");
			
			this.dictionary.loadDictionary("special/english-upper.10");
			this.dictionary.loadDictionary("special/english-words.35");
			this.dictionary.loadDictionary("special/english-upper.40");
			this.dictionary.loadDictionary("special/english-upper.50");
			this.dictionary.loadDictionary("special/english-upper.60");
			this.dictionary.loadDictionary("special/english-upper.70");

			this.dictionary.loadDictionary("special/american-words.10");
			this.dictionary.loadDictionary("special/american-words.20");
			this.dictionary.loadDictionary("special/american-words.35");
			this.dictionary.loadDictionary("special/american-words.40");
			this.dictionary.loadDictionary("special/american-words.50");
			this.dictionary.loadDictionary("special/american-words.55");
			this.dictionary.loadDictionary("special/american-words.60");
			this.dictionary.loadDictionary("special/american-words.70");
			
			this.dictionary.loadDictionary("special/american-upper.50");
			this.dictionary.loadDictionary("special/american-upper.60");
			this.dictionary.loadDictionary("special/american-upper.70");

		} catch (FileNotFoundException e) {
			System.out.println("Dictionary not found");
		}

		this.textPanel = new TextPanel(this.dictionary);
		this.add(this.textPanel);

		//adds the buttons to the frame.  
		JPanel buttons = new ButtonPanel(this.textPanel, this.dictionary);
		this.add(buttons);

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		JFrame frame = new SpellCheckerWindow();
		frame.setSize(DEFAULT_FRAME_WIDTH, DEFAULT_FRAME_HEIGHT);
		frame.setTitle("Spell Checker");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);

	}

	//Adds options to the menu bar.  
	private JMenu createFileMenu() {
		// create the "Game" menu
		JMenu menu = new JMenu("File");
		menu.add(createOpenFileItem());

		return menu;
	}

	//Create the open file in the text box.  
	private JMenuItem createOpenFileItem() {
		JMenuItem item = new JMenuItem("Open File");
		class MenuItemListener implements ActionListener {
			public void actionPerformed(ActionEvent event) {
				JFileChooser fileChooser = new JFileChooser();
				fileChooser.setDialogTitle("CHOOSE YOUR FILE!");


				fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);

				int choice = fileChooser.showOpenDialog(null);
				if (choice == JFileChooser.APPROVE_OPTION) {
					File file = fileChooser.getSelectedFile();
					try {
						textPanel.setFile(file);
					} catch (FileNotFoundException e) {
						System.out.println("File Not Found");
					}
					textPanel.checkMissspellings();
				}
			}
		}
		ActionListener listener = new MenuItemListener();
		item.addActionListener(listener);
		return item;
	}
}
