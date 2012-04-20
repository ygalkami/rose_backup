import java.awt.Font;
import java.awt.Graphics;
import java.awt.geom.Ellipse2D;
import java.util.HashMap;

import javax.swing.JFrame;
import javax.swing.JPanel;

/**
 * A wrapper class for binary trees that can display the wrapped tree in a
 * window.
 * 
 * @author Curt Clifton. Created Jan 24, 2008.
 */
public class DisplayableBinaryTree extends JPanel{

	private int width;

	private int height;

	private BinaryTree tree;
	private String inorder;
	public int label = 0;
	HashMap<String, Integer> points = new HashMap<String, Integer>();


	/**
	 * Constructs a new displayable binary tree, set to default to the given
	 * window size for display.
	 * 
	 * @param tree
	 * @param windowWidth
	 *            in pixels
	 * @param windowHeight
	 *            in pixels
	 */
	public DisplayableBinaryTree(BinaryTree tree, int windowWidth,
			int windowHeight) {
		this.width = windowWidth - 20;
		this.height = windowHeight - 70;
		this.tree = tree;
		this.inorder = tree.inOrder();
	}

	/**
	 * Creates a new window, using the current size information stored in this,
	 * and renders the current state of the tree wrapped by this.
	 */
	public void display() {
		JFrame frame = new JFrame();
		frame.setSize(this.height, this.width);
		frame.setContentPane(new DisplayableBinaryTree( this.tree, this.height, this.width ));
		frame.setVisible(true);
	}
	
	public void paint(Graphics g) {
		InOrder TreeIterator = new InOrder(this.tree);
		CharSequence test = "-";
//		test = '-';
		TreeIterator.advance();
		
		int fontsize = 0;
		int radius = 0;
		
		//calculate fontsize and radius size
		if (this.width > this.height)
			radius = this.width / this.tree.size() / 2;
		else
			radius = this.height / this.tree.size() / 2;
		
		fontsize = this.width/this.tree.size() / 2 - g.getFontMetrics().getHeight();
		if (fontsize < 8)
			fontsize = 8;
		Font font = new Font("Arial", 0, 14);//fontsize);
		
		//draw circles, node elements
		for (int i = 0; i < this.tree.size(); i++) {
			BinaryNode temp = TreeIterator.current;
			String node = temp.getElement().toString();
			int x = this.tree.root.getWidth(i, radius);
			int y = this.tree.root.getHeight(temp, this.tree.getHeight(), this.height, radius);
//			System.out.println(node + " y: " + y);
			int yadjust = g.getFontMetrics().getHeight();
			int xadjust = g.getFontMetrics().getWidths()[0];
			
			g.setFont(font);
			g.drawString(node.substring(0, 1), x + radius / 4, y + radius / 2 + radius / 4);
			g.drawOval(x, y, radius, radius);
//			System.out.println(node);
//			System.out.println(points.toString());
			if (points.get(node) != null){
                temp.setElement(node + label);
                String New = temp.getElement().toString();
                points.put(New, x);
                label++;
          }
			else{
                points.put(node, x);
          }
			TreeIterator.advance();
		}
		drawline(g, this.tree.root, radius);
	}
	
	//Recursive method to draw lines based on their parents
	public void drawline(Graphics g, BinaryNode current, int radius) {
		int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
		
		x1 = points.get(current.getElement()) + radius / 2;
		y1 = current.getHeight(current, this.tree.getHeight(), this.height, radius) + radius;
		
		//draw line to left subtree
		if (current.getLeft() != null) {
			x2 = points.get(current.getLeft().getElement()) + radius / 2;
			y2 = current.getLeft().getHeight(current.getLeft(), this.tree.getHeight(), this.height, radius);
			g.drawLine(x1, y1, x2, y2);
			drawline(g, current.getLeft(), radius);
			g.drawLine(x2, y2, x2 + 5, y2 - 10);
		}
		//draw line to right subtree
		if (current.getRight() != null) {
			x2 = points.get(current.getRight().getElement()) + radius / 2;
			y2 = current.getRight().getHeight(current.getRight(), this.tree.getHeight(), this.height, radius);
			g.drawLine(x1, y1, x2, y2);
			drawline(g, current.getRight(), radius);
			g.drawLine(x2, y2, x2 - 5, y2 - 10);
		}			
	}
	
	/**
	 * Sets the default size for the next window displayed.
	 * 
	 * @param windowWidth
	 *            in pixels
	 * @param windowHeight
	 *            in pixels
	 */
	public void setSize(int windowWidth, int windowHeight) {
		this.width = windowWidth - 20;
		this.height = windowHeight - 70;
	}

}