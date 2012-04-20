import java.awt.Graphics2D;
import java.awt.geom.Point2D;

/**
 * A CollectionOfBalls provides for the management of a collection of Balls.
 *
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
public interface CollectionOfBalls {
	/**
	 * Returns the Ball in this CollectionOfBall's World that is nearest the given point.
	 * Returns null if there are no Balls in this CollectionOfBall's World.
	 *
	 * @param p the point for which to find the nearest Ball
	 * @return the Ball in this CollectionOfBall's World that is nearest the given point
	 */
	public Ball nearestBall(Point2D p);

	/**
	 * Draws the Balls in this CollectionOfBall's World.
	 *
	 * @param graphics the object onto which to draw
	 * @param selectedBall the ball which has been selected (null if none)
	 */
	public void drawBalls(Graphics2D graphics, Ball selectedBall);
}
