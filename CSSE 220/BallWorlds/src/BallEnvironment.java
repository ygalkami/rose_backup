import java.awt.geom.Point2D;

/**
 * A BallEnvironment manages the Balls in an associated World.
 * It does so by providing methods that allow Balls to be added and removed
 * to that World, along with other methods that relate to those Balls.
 *
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
public interface BallEnvironment {

	/**
	 * Adds the given Ball to this BallEnvironment's World.
	 *
	 * @param ballToAdd the Ball to add to this BallEnvironment's World
	 */
	public void addBall(Ball ballToAdd);

	/**
	 * Removes the given Ball from this BallEnvironment's World.
	 *
	 * @param ballToRemove the Ball to remove from this BallEnvironment's World
	 */
	public void removeBall(Ball ballToRemove);

	/**
	 * Returns true if the given point's x-coordinate is inside
	 * this BallEnvironment's World.
	 *
	 * @param p the point whose x-coordinate to check
	 * @return true if the given point's x-coordinate is inside
	 *              this BallEnvironment's World
	 */
	public boolean isInsideWorldX(Point2D p);

	/**
	 * Returns true if the given point's y-coordinate is inside
	 * this BallEnvironment's World.
	 *
	 * @param p the point whose y-coordinate to check
	 * @return true if the given point's y-coordinate is inside
	 *              this BallEnvironment's World
	 */
	public boolean isInsideWorldY(Point2D p);

	/**
	 * Returns a new Point2D that is at the middle of this BallEnvironment's World.
	 *
	 * @return a new Point2D that is at the middle of this BallEnvironment's World
	 */
	public Point2D middleOfWorld();
}

