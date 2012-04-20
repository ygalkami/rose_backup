import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JPanel;

public class ButtonPanel extends JPanel implements ActionListener {
	// text panel
	private TextPanel textPanel;

	// dictionary used to check misspelled words.
	private Dictionary dictionary;

	/**
	 * Creates the buttons
	 * 
	 * @param textPanel
	 *            where the text is stored.
	 * @param dictionary
	 *            used to check for misspellings.
	 */
	public ButtonPanel(TextPanel textPanel, Dictionary dictionary) {
		// Creates all of the action buttons
		JButton replace = new JButton("Replace");
		JButton replaceAll = new JButton("Replace All");
		JButton addToDictionary = new JButton("Add To Dictionary");
		JButton findNext = new JButton("Find Next");

		// sets all the buttons to not be focusable.
		replace.setFocusable(false);
		replaceAll.setFocusable(false);
		addToDictionary.setFocusable(false);
		findNext.setFocusable(false);

		// sets an action command for each button
		replace.setActionCommand("replace");
		replaceAll.setActionCommand("replaceAll");
		addToDictionary.setActionCommand("Add To Dictionary");
		findNext.setActionCommand("findNext");

		// adds and action listener to each button.
		replace.addActionListener(this);
		replaceAll.addActionListener(this);
		addToDictionary.addActionListener(this);
		findNext.addActionListener(this);

		// adds all the buttons.
		this.add(replace);
		this.add(replaceAll);
		this.add(findNext);
		this.add(addToDictionary);

		this.textPanel = textPanel;
		this.dictionary = dictionary;
	}

	public void actionPerformed(ActionEvent arg0) {
		// Makes the replace button replace the words in the text panel.
		if (arg0.getActionCommand().equals("replace")) {
			if(this.textPanel.indexOfMissspelledWord != -1){ //only do this action if there are misspelled words
				this.textPanel.replace();
				this.textPanel.highlightNextWord();
				if(textPanel.missspelledWordsList.size()<=0)
					textPanel.clearSuggestionList();			
			}
			
			// Makes the replace button replace all the same misspelled words in
			// the text panel.
		} else if (arg0.getActionCommand().equals("replaceAll")) {
			if(this.textPanel.indexOfMissspelledWord != -1){ //only do this action if there are misspelled words
				this.textPanel.replaceAll();
				this.textPanel.highlightNextWord();
				if(textPanel.missspelledWordsList.size()<=0){
					textPanel.clearSuggestionList();
					textPanel.clearHighlighting();
				}
			}

			// Makes the add to dictionary button add the "misspelled word" to
			// the dictionary.
		} else if (arg0.getActionCommand().equals("Add To Dictionary")) {
			if(this.textPanel.indexOfMissspelledWord != -1){ //only do this action if there are misspelled words
				this.dictionary.add(textPanel.missspelledWordsList.get(textPanel.indexOfMissspelledWord).toLowerCase());
				//System.out.println("adding: " + textPanel.missspelledWordsList.get(textPanel.indexOfMissspelledWord).toLowerCase());
				int newIndexOfMissspelledWord = textPanel.indexOfMissspelledWord;
				String wordToReplace = textPanel.missspelledWordsList.get(textPanel.indexOfMissspelledWord);
				int previousIndexInText = textPanel.missspelledWordsListPositions.get(textPanel.indexOfMissspelledWord);

				if(textPanel.missspelledWordsList.size() > 1){
					for(textPanel.indexOfMissspelledWord = 0; textPanel.indexOfMissspelledWord < textPanel.missspelledWordsList.size(); textPanel.indexOfMissspelledWord++){
						if(textPanel.missspelledWordsList.get(textPanel.indexOfMissspelledWord).equals(wordToReplace)){

							//we need to subtract a certain number of times from the index to account for removed words, but only those in front of where we are
							if(textPanel.missspelledWordsListPositions.get(textPanel.indexOfMissspelledWord) < previousIndexInText){
								newIndexOfMissspelledWord--;
							}
						}
					}
					
					textPanel.indexOfMissspelledWord = newIndexOfMissspelledWord - 1;

					this.textPanel.checkMissspellings(); 
					this.textPanel.highlightNextWord();
				}else{
					this.textPanel.checkMissspellings();
					this.textPanel.clearHighlighting();
					this.textPanel.clearSuggestionList();
				}				
			}
			
			// Makes the find next button find the next misspelled word.
		} else if (arg0.getActionCommand().equals("findNext")) {
			//System.out.println(textPanel.indexOfMissspelledWord);
			this.textPanel.highlightNextWord();
		}
	}
}
