/**
 * A Ball is an abstract class that does nothing -- it is just a convenient name
 * for a "generic" ball, that is, any Drawable, Relocatable, Animate object.
 *
 * <p>
 * Specific kinds of Balls are expected to do other things like move on their own,
 * bounce, shrink and grow in size, explode, and be draggable by the mouse.
 *
 * <p>
 * Specific kinds of Balls should extend this class, simply so that
 * they can be declared to be a Ball in classes that refer to a generic Ball.
 *
 * <p>
 * A Ball must have a constructor that:
 * <ul>
 *   <li> Takes a BallEnvironment object and
 *   <li> Uses that BallEnvironment object to add the Ball to its World
 *        (otherwise, the Ball is not displayed).
 * </ul>
 *
 * <p>
 * <b>
 * Students: you should NOT add any code to this abstract Ball class.
 * Instead, write classes that extend this Ball class.
 * </b>
 *
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
public abstract class Ball implements Drawable, Relocatable, Animate {
	
	/**
	 * Does nothing.
	 * 
	 * However, a comment is in place that would make this constructor:
	 * 
	 * Displays a warning message, since this constructor should never
	 * be invoked -- a Ball always needs a BallEnvironment passed to it.
	 */
	public Ball() {
		super();
		/* -- Commented out --
		String message = "Warning: The system has constructed a Ball using a constructor that has no arguments.\n";
		message += "This is a violation of a note in the UML class diagram\n";
		message += "that says that every Ball must have a constructor that:\n";
		message += "  1. Takes a BallEnvironment object and \n";
		message += "  2. Uses that BallEnvironment object to add the Ball to its World.";
			
		JOptionPane.showMessageDialog(null, message, "Warning -- wrong constructor called", JOptionPane.WARNING_MESSAGE);
		*/
	}
	
	/**
	 * Adds itself to its World (otherwise, the Ball is not displayed).
	 *
	 * This stub does nothing. Specific kinds of Balls should override
	 * this constructor so that it accomplishes the above.
	 *
	 * @param ballEnvironment The BallEnvironment for all the Balls in this Ball's World.
	 */
	public Ball(@SuppressWarnings("unused") BallEnvironment ballEnvironment) {
		// Does nothing, should be overridden.
	}
}
