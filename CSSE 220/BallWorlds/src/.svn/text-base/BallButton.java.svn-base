import javax.swing.JButton;
import javax.swing.JOptionPane;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.lang.reflect.Modifier;
import java.lang.reflect.Constructor;

/**
 * Pressing a BallButton constructs a Ball of the type
 * whose name appears on the BallButton.
 *
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
public class BallButton extends JButton implements ActionListener {

	private String ballType;
	private BallEnvironment ballEnvironment;
	
	private static final int ERROR_ClassNotFound = 1;
	private static final int ERROR_ClassIsNotABall = 2;
	private static final int ERROR_ClassIsAbstract = 3;
	private static final int ERROR_NoConstructor = 4;
	private static final int ERROR_CouldNotConstructBall = 5;

	/**
	 * Associates a type of Ball and a BallEnvironment with this button,
	 * labels this button with the type of Ball, and arranges
	 * for this button to respond to its own button-presses.
	 *
	 * @param ballType the type of Ball to be created by pressing this button
	 * @param ballEnvironment the BallEnvironment for all Balls created by pressing this button
	 */
	public BallButton(String ballType, BallEnvironment ballEnvironment) {
		super(ballType);

		this.ballType = ballType;
		this.ballEnvironment = ballEnvironment;

		this.addActionListener(this);
	}

	/**
	 * Creates a Ball of the type whose name appears on this BallButton.
	 *
	 * @param event the Event that caused this method to be invoked
	 *              (usually, pressing this BallButton)
	 */
	public void actionPerformed(ActionEvent event) {
		try {
			// Get the Class for the Ball

			Class<?> ballClass = Class.forName(this.ballType);

			// Make sure that it is a Ball class and not abstract.
			
			if (! Ball.class.isAssignableFrom(ballClass)) {
				this.showErrorMessage(BallButton.ERROR_ClassIsNotABall);
				return;
			}
			if (Modifier.isAbstract(ballClass.getModifiers())) {
				this.showErrorMessage(BallButton.ERROR_ClassIsAbstract);
				return;
			}

			// Construct the Ball, via the constructor that takes a BallEnvironment.
			// Don't add the ball to the World -- leave that to the Ball itself.

			Constructor<?> constructor;

			Class[] parameters = {BallEnvironment.class};
			constructor = ballClass.getConstructor(parameters);
			@SuppressWarnings("unused") Ball ball = (Ball) constructor.newInstance(this.ballEnvironment);

		} catch (ClassNotFoundException exception) {
			this.showErrorMessage(BallButton.ERROR_ClassNotFound);

		} catch (NoSuchMethodException exception) {
			this.showErrorMessage(BallButton.ERROR_NoConstructor);

		} catch (Exception exception) {
			exception.printStackTrace();
			this.showErrorMessage(BallButton.ERROR_CouldNotConstructBall);
		}
	}
	
	/*
	 * Displays an error message appropriate for the given error type.
	 */
	private void showErrorMessage(int errorType) {
		String message, error;
		
		switch (errorType) {
			
			case ERROR_ClassNotFound: // there is no class with this button's name
				message = "There is no " + this.ballType + " class in this project.\n"
					+ "Did you forget to implement it?\n"
					+ "Or did you misspell it? (Case matters!)";

				error = "Error: class does not exist";
				break;
			
			case ERROR_ClassIsNotABall: // the class with this button's name is not a Ball
				message = "The " + this.ballType + " class does not extend Ball.\n"
					+ "Did you forget to declare it to do so?\n";

				error = "Error: class is not a Ball";
				break;
				
			case ERROR_ClassIsAbstract: // the class with this button's name is abstract
				message = "Your " + this.ballType + " class is abstract.\n"
					+ "It must NOT be abstract -- you really must implement all the methods\n"
					+ "exactly as specified in Drawable, Relocatable and Animate. Please do so.\n";

				error = "Error: class is abstract";
				break;
			
			case ERROR_NoConstructor: // the class with this button's name does not have an appropriate constructor
				message = "I cannot create a " + this.ballType + " unless the " + this.ballType
					+ " class has a constructor that has a single parameter of type BallEnvironment.\n"
					+ "Your " + this.ballType + " class lacks such a constructor.  Please add one.\n"
					+ "That constructor should add the Ball to its World (otherwise, the Ball is not displayed).\n";

				error = "Error: class lacks an appropriate constructor";
				break;
				
			case ERROR_CouldNotConstructBall: // I could not create the Ball, for unknown reasons.
				message = "I cannot construct a " + this.ballType + ".\n"
					+ "Perhaps something is wrong with the code in your constructor?\n"
					+ "Examine the error message in the output window and get help as needed.";

				error = "Error: could not construct the Ball";
				break;
			
			default:
				// Should never get here.
				message = "Unknown error message type."
					+ "Please show this message and your " + this.ballType + " class to your instructor.\n";

				error = "Error: unknown error message type";
		}

		JOptionPane.showMessageDialog(null, message, error, JOptionPane.ERROR_MESSAGE);
	}

}
