import java.awt.geom.Point2D;

/**
 * A Relocatable is an object that can be found and moved.
 *
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
 public interface Relocatable {

	/**
	 * Moves the Relocatable object to the given Point2D,
	 * by setting its position (part of its Shape) to the given Point2D.
	 *
	 * @param point the Point2D to which the Relocatable object should move.
	 */
	public void moveTo(Point2D point);

	/**
	 * Returns the distance that the Relocatable object is from the given Point2D.
	 *
	 * @param point the Point2D from which the distance is desired.
	 * @return the distance that the Relocatable object is from the given Point2D.
	 *
	 */
	public double distanceFrom(Point2D point);
}
