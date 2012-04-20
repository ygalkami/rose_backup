import java.util.Stack;

/**
 * This is a tree factory.
 * 
 * @author Curt Clifton. Created Jan 24, 2008.
 */
public final class BuildTree {

	/**
	 * Generates a binary tree where each node in a pre-order traversal of the
	 * tree contains a single character drawn in-order from charElements.  For
	 * each of those nodes, the corresponding element in childCodes indicates the
	 * number of children, where L means one left child, R means one right child,
	 * and 0 and 2 mean zero and two children respectively.
	 *
	 * @param charElements
	 * @param childCodes
	 * @return the binary tree
	 */
	private int count = 0;
	public static BinaryTree preOrderBuild(CharSequence charElements,
			CharSequence childCodes) {
		BinaryTree tree = new BinaryTree();
		tree.root = buildhelper(charElements, childCodes, 0);
		
		return tree;
	}
	
	public static BinaryNode buildhelper(CharSequence charElements, CharSequence childCodes, int count) {
		
		if (charElements.length() == 0)
			return null;
		else {
			//every time recursive method is called, shrink charsequence
			BinaryNode temp = new BinaryNode("" + charElements.charAt(0), null, null, count);
			count++;
			if (childCodes.charAt(0) == '2') {
				temp.setLeft(buildhelper(charElements.subSequence(1, charElements.length()), childCodes.subSequence(1, childCodes.length()), count));
				temp.setRight(buildhelper(charElements.subSequence(temp.size(temp), charElements.length()), childCodes.subSequence(temp.size(temp), childCodes.length()), count));
			}
			else if (childCodes.charAt(0) == 'L') {
				temp.setRight(null);
				temp.setLeft(buildhelper(charElements.subSequence(1, charElements.length()), childCodes.subSequence(1, childCodes.length()), count));
			}
			else if (childCodes.charAt(0) == 'R') {
				temp.setLeft(null);
				temp.setRight(buildhelper(charElements.subSequence(temp.size(temp), charElements.length()), childCodes.subSequence(temp.size(temp), childCodes.length()), count));
			}
			else if (childCodes.charAt(0) == '0') {
				temp.setLeft(null);
				temp.setRight(null);
			}
			
			return temp;
		}
	}

}