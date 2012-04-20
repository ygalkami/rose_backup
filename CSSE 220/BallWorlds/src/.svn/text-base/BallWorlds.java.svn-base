import java.awt.Dimension;
import java.awt.Color;
import java.util.ArrayList;

/**
 * The BallWorlds application is a Swing application that simulates "worlds"
 * that contain various kinds of "balls" (and possibly other objects).
 *
 * <p>
 * The BallWorlds class contains the <i>main</i> method for the BallWorlds application
 * and hence is the starting point for that application.
 *
 * It constructs the Worlds and the frame in which they will be displayed.
 * 
 * <p>
 * This exercise is based on an exercise from Lynn Andrea Stein's Rethinking CS101 project.
 *  
 * @author David Mutchler, Salman Azhar and others, January 2005.
 */
public class BallWorlds {
	
	/* Default number, sizes and colors for the Worlds. */
	private static int numberOfWorlds = 3;
	
	private static Dimension world1Size = new Dimension(850, 250);
	private static Dimension world2Size = new Dimension(1000, 450);
	private static Dimension world3Size = new Dimension(700, 250);
	
	private static Color world1Color = new Color(0, 255, 126);
	private static Color world2Color = new Color(0, 255, 0);
	private static Color world3Color = new Color(0, 225, 0);
	
	/**
	 * Does nothing.
	 */
	public BallWorlds() {
		// Does nothing
	}
	
	/**
	 * The BallWorlds application starts here in <i>main</i>.
	 * It constructs the Worlds and the frame in which they will be displayed.
     *
     * @param args Array of command-line arguments
     */
    public static void main(String[] args) {	
    	BallWorldsFrame frame;
    	
    	frame = new BallWorldsFrame();  
    	 	
    	BallWorlds.makeWorlds(BallWorlds.numberOfWorlds, frame);
    	
        frame.setVisible(true);
    }
    
    /*
     * Makes the given number of Worlds, giving each the given frame.
     * Rotates between 3 preassigned sizes and colors for the Worlds.
     */
    private static void makeWorlds(int numberOfWorlds, BallWorldsFrame frame) {
    	ArrayList<Dimension> dimensions = new ArrayList<Dimension>();
    	ArrayList<Color> colors = new ArrayList<Color>();
    	
    	dimensions.add(BallWorlds.world1Size);
    	dimensions.add(BallWorlds.world2Size);
    	dimensions.add(BallWorlds.world3Size);
    	
    	colors.add(BallWorlds.world1Color);
    	colors.add(BallWorlds.world2Color);
    	colors.add(BallWorlds.world3Color);
    	
    	for (int k = 0; k < numberOfWorlds; ++k) {
    		new World(dimensions.get(k % 3), colors.get(k % 3), frame);
    	}
    }
}
