import javax.swing.JPanel;
import java.awt.Dimension;

/**
 * A ButtonsPanel constructs and adds a BallButton for each type of Ball in BallWorlds.
 *
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
public class ButtonsPanel extends JPanel {
	
	/**
	 * Array of the class names that are "standard" (hence expected).
	 */
	public static final String[] STANDARD_BALLS = {
		"Dud", "DudThatMoves", "Mover", "Bouncer", "Shrinker", "Exploder", "SpecialBall"
	};
	
	/**
	 * Constructs and adds a BallButton for each type of Ball in BallWorlds.
	 * Each BallButton is given the BallEnvironment associated with the World
	 * that contains this ButtonsPanel.
	 * Also sets the size of this panel to the given size.
	 *
	 * @param size size of this panel.
	 * @param ballEnvironment the BallEnvironment associated with the World that contains this ButtonsPanel
	 */
	public ButtonsPanel(Dimension size, BallEnvironment ballEnvironment) {
		this.setPreferredSize(size);
		
		// Add buttons for all the standard types of Balls.
		
		for (String ballType : STANDARD_BALLS) {
			this.add(new BallButton(ballType, ballEnvironment));
		}

		// XXX It would be best to have code here that dynamically finds
		// non-standard Ball types and adds buttons for them.
	}
}