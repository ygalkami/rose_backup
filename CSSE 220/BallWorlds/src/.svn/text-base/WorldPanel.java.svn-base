import javax.swing.JPanel;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.event.*;

/**
 * A WorldPanel displays its associated World and the Balls in that World.
 *
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
public class WorldPanel extends JPanel implements MouseListener, MouseMotionListener, Runnable {

	/**
	 * Color of the selected Ball.
	 */
	public static final Color SELECTED_BALL_COLOR = Color.red;
	private static final short LEFT_MOUSE_BUTTON = 1;

	private World world;
	private Ball selectedBall = null;
	private int timeToSleep = 10; // milliseconds

	/**
	 * Makes this panel respond to mouse actions
	 * and repeatedly repaint itself.
	 *
	 * Also sets the size of this panel to the given size and
	 * associates this WorldPanel with the given World,
	 *
	 * @param size size of this panel.
	 * @param color Background color for this WorldPanel.
	 * @param world the World associated with this WorldPanel.
	 */
	public WorldPanel(Dimension size, Color color, World world) {
		this.setPreferredSize(size);
		this.setBackground(color);
		this.world = world;

		this.addMouseListener(this);
		this.addMouseMotionListener(this);
		
		new Thread(this).start();
	}

	/**
	 * Draws the World and its Balls.
	 *
	 * @param g the Graphics object onto which to draw.
	 */
	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);

		Graphics2D graphics = (Graphics2D) g;

		this.drawWorld(graphics);
		this.drawBalls(graphics);
	}

	/*
	 * Draws the World onto the given graphics object.
	 */
	private void drawWorld(Graphics2D graphics) {
		graphics.setColor(this.world.getColor());
		graphics.fill(this.world.getShape());
	}

	/*
	 * Draws the Balls onto the given graphics object.
	 */
	private void drawBalls(Graphics2D graphics) {
		this.world.drawBalls(graphics, this.selectedBall);
	}

	/**
	 * Sets the selected Ball to the Ball nearest the mouse point.
	 *
	 * @param event The MouseEvent that caused this method to be invoked.
	 */
	public void mousePressed(MouseEvent event) {
		this.selectedBall = this.world.nearestBall(event.getPoint());

		if (event.getButton() != WorldPanel.LEFT_MOUSE_BUTTON && this.selectedBall != null) {
			this.selectedBall.die();
		}
	}

	/**
	 * Sets the selected Ball to null (i.e., no Ball is selected).
	 *
	 * @param event The MouseEvent that caused this method to be invoked.
	 */
	public void mouseReleased(MouseEvent event) {
		if (event.getButton() == WorldPanel.LEFT_MOUSE_BUTTON) {
			this.selectedBall = null;
		}
	}

	/**
	 * Does nothing.
	 *
	 * @param event The MouseEvent that caused this method to be invoked.
	 */
	public void mouseEntered(MouseEvent event) {
		// Does nothing
	}

	/**
	 * Does nothing.
	 *
	 * @param event The MouseEvent that caused this method to be invoked.
	 */
	public void mouseExited(MouseEvent event) {
		// Does nothing
	}

	/**
	 * Toggles the nearest Ball between the paused and not-paused state.
	 *
	 * @param event The MouseEvent that caused this method to be invoked.
	 */
	public void mouseClicked(MouseEvent event) {
		Ball nearestBall = this.world.nearestBall(event.getPoint());
		if (nearestBall != null && event.getButton() == WorldPanel.LEFT_MOUSE_BUTTON) {
			nearestBall.pauseOrResume();
		}
	}

	/**
	 * For the selected Ball (if any), moves the Ball to the current mouse point.
	 *
	 * @param event The MouseEvent that caused this method to be invoked.
	 */
	public void mouseDragged(MouseEvent event) {
		if (this.selectedBall != null) {
			this.selectedBall.moveTo(event.getPoint());
		}
	}

	/**
	 * Does nothing.
	 *
	 * @param event The MouseEvent that caused this method to be invoked.
	 */
	public void mouseMoved(MouseEvent event) {
		// Does nothing
	}
	
	/**
	 * Repeatedly repaints this panel.
	 */
	public void run() {
		while (true) {
			try {
				Thread.sleep(this.timeToSleep);
				this.repaint();
			} catch (InterruptedException exception) {
				// If you can't sleep, no problem -- just continue.
			}
		}
	}
}
