/**
 * An Animate is an object that can:
 * <ul>
 *    <li> act (in any way it chooses) </li>
 *    <li> pause/resume its action </li>
 *    <li> die (remove itself from its World, hence no longer be asked to act). </li>
 * </ul>
 *
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
public interface Animate {

	/**
	 * Does anything the Animate object wishes.
	 * The act() method is called repeatedly by the World
	 * to which this Animate object belongs.
	 */
	public void act();

	/**
	 * Toggles between the "paused" and "not-paused" state.
	 * During the paused state, the act() method should do nothing.
	 */
	public void pauseOrResume();

	/**
	 * Removes the Animate object from its World.
	 * Thus, the Animate object is no longer asked to act
	 * and is no longer drawn.
	 */
	public void die();
}
