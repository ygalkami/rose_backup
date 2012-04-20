import javax.swing.JFrame;
import java.util.ArrayList;
import java.awt.Color;
import java.awt.Shape;
import java.awt.Dimension;
import java.awt.geom.Point2D;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.Point;
import javax.swing.JOptionPane;
import java.util.ConcurrentModificationException;

/**
 * A World simulates a "world" that contain various kinds of "balls"
 * (and possibly other objects).
 *
 * <p>
 * A World constructs its visual elements:
 * <ul>
 *    <li> a ButtonsPanel by which the user can create Balls </li>
 *    <li> a WorldPanel which displays the constructed Balls </li>
 * </ul>
 * A World adds those visual elements to the frame that the World is given.
 *
 * <p>
 * A World manages its Balls, including animating them by calling each Ball's
 * <i>act</i> method repeatedly.
 *
 * <p>
 * A World manages its HotSpots (other objects that the World creates).
 *
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
public class World implements BallEnvironment, BumperEnvironment, CollectionOfBalls, Drawable, Runnable {

	private int maxX;
	private int maxY;
	private Shape shape;
	private Color color;
	private ArrayList<Ball> balls;

	private int buttonsPanelWidth = 150; // pixels
	private int timeToSleep = 5;         // milliseconds
	private static boolean hasShownErrorMessage = false;

	/**
	 * Sets the World's Shape (and related data) and Color to the given values.
	 *
	 * <p>
	 * Constructs the visual elements of this World:
	 * <ul>
	 *    <li> a ButtonsPanel by which the user can create Balls </li>
	 *    <li> a WorldPanel which displays the constructed Balls </li>
	 * </ul>
	 *
	 * Adds those visual elements to the frame that it is given.
	 *
	 * <p>
	 * Starts a Thread that repeatedly asks each Ball to act.
	 *
	 * @param size Size of this World (including its ButtonPanel).
	 * @param color Color of this World.
	 * @param ballWorldFrame JFrame to which the visual elements of this World are to be added.
	 */
	public World(Dimension size, Color color, JFrame ballWorldFrame) {
		Dimension worldPanelSize;
		Dimension buttonsPanelSize;
		
		this.maxX = size.width - this.buttonsPanelWidth;
		this.maxY = size.height;
		
		worldPanelSize = new Dimension(this.maxX, this.maxY);
		buttonsPanelSize = new Dimension(this.buttonsPanelWidth, size.height);
		
		this.shape = new Rectangle(new Point(0, 0), worldPanelSize);
		this.color = color;

		this.balls = new ArrayList<Ball>();
		
		ballWorldFrame.add(new WorldPanel(worldPanelSize, color, this));
		ballWorldFrame.add(new ButtonsPanel(buttonsPanelSize, this));

		new Thread(this).start();
	}
	
	/**
	 * Adds the given Ball to this World.
	 *
	 * @param ballToAdd the Ball to add to the World.
	 */
	public synchronized void addBall(Ball ballToAdd) {
		this.balls.add(ballToAdd);
	}

	/**
	 * Removes the given Ball from this World.
	 *
	 * @param ballToRemove the Ball to remove from the World.
	 */
	public synchronized void removeBall(Ball ballToRemove) {
		this.balls.remove(ballToRemove);
	}

	/**
	 * Returns true if the given point's x-coordinate is inside this World.
	 *
	 * @param p the point whose x-coordinate to check
	 * @return true if the given point's x-coordinate is inside this World.
	 */
	public boolean isInsideWorldX(Point2D p) {
		return ( (p.getX() > 0)  &&  (p.getX() < this.maxX) );
	}

	/**
	 * Returns true if the given point's y-coordinate is inside this World.
	 *
	 * @param p the point whose y-coordinate to check
	 * @return true if the given point's y-coordinate is inside this World.
	 */
	public boolean isInsideWorldY(Point2D p) {
		return ( (p.getY() > 0)  &&  (p.getY() < this.maxY));
	}

	/**
	 * Returns a new Point2D that is at the middle of this World.
	 *
	 * @return a new Point2D that is at the middle of this World.
	 */
	public Point2D middleOfWorld() {
		return new Point2D.Double(this.maxX / 2.0, this.maxY / 2.0);
	}

	/**
	 * Returns the Ball in this World that is nearest the given point.
	 * Returns null if there are no Balls in this World.
	 *
	 * @param p the point for which to find the nearest Ball.
	 * @return the Ball in this World that is nearest the given point.
	 */
	public synchronized Ball nearestBall(Point2D p) {
		double minDistance = 0;
		double distance = 0;
		Ball closest = null;

		for (Ball ball : this.balls) {
			distance = ball.distanceFrom(p);
			if (closest == null || distance <= minDistance) {
				closest = ball;
				minDistance = distance;
			}
		}
		return closest;
	}

	/**
	 * Draws the Balls in this World.
	 *
	 * @param graphics the object onto which to draw.
	 * @param selectedBall the ball which has been selected (null if none).
	 */
	public synchronized void drawBalls(Graphics2D graphics, Ball selectedBall) {
		Color color;
		Shape shape;
		
		for (Ball ball : this.balls) {
			
			color = ball.getColor();
			shape = ball.getShape();
			
			if (color == null) {
				this.showNullPointerMessage("Color", ball);
				continue;
			}
			if (shape == null) {
				this.showNullPointerMessage("Shape", ball);
				continue;
			}
			
			try {
				if (ball == selectedBall) {
					graphics.setColor(WorldPanel.SELECTED_BALL_COLOR);
				} else {
					graphics.setColor(ball.getColor());
				}

				graphics.fill(ball.getShape());
				
			} catch (Exception exception) {
				try {
					exception.printStackTrace();
					Thread.sleep(10000);  		// Print error messages slowly
				} catch (InterruptedException e) {
					// If you can't sleep, no problem -- just continue.
				}
			}
		}
	}
	
	// Display an error message explaining that the Ball's color/shape was null
	// so it could not be drawn.
	// Show the message only once.
	private void showNullPointerMessage(String nullAttribute, Ball ball) {
		
		if (!World.hasShownErrorMessage) {
			
			World.hasShownErrorMessage = true;

			String message = "I could not draw this Ball of type "
				+ ball.getClass().getName()
				+ " because its " + nullAttribute + " is null.\n";
			
			JOptionPane.showMessageDialog(null, message, "Null pointer exception", JOptionPane.ERROR_MESSAGE);
		}
	}

	/**
	 * Returns the Shape (which contains position and size) of this World.
	 *
	 * @return the Shape of this World.
	 */
	public Shape getShape() {
		return this.shape;
	}

	/**
	 * Returns the Color of this World.
	 *
	 * @return the Color of this World.
	 */
	public Color getColor() {
		return this.color;
	}

	/**
	 * Repeatedly asks each Ball to act.
	 */
	public void run() {
		while (true) {
			try {
				Thread.sleep(this.timeToSleep);
				this.act();
			} catch (InterruptedException exception) {
				// If you can't sleep, no problem -- just continue.
			}
		}
	}

	/*
	 * Asks each Ball to act.
	 */
	private synchronized void act() {
		try {
			for (Ball ball : this.balls) {
				ball.act();
			}
		} catch (ConcurrentModificationException exception) {
			// If the list is modified while acting, proceed anyhow
		}
	}
}
