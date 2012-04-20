// BinaryNode class; stores a node in a tree.
//
// CONSTRUCTION: with (a) no parameters, or (b) an Object,
//     or (c) an Object, left child, and right child.
//
// *******************PUBLIC OPERATIONS**********************
// int size( )            --> Return size of subtree at node
// int height( )          --> Return height of subtree at node
// void printPostOrder( ) --> Print a postorder tree traversal
// void printInOrder( )   --> Print an inorder tree traversal
// void printPreOrder( )  --> Print a preorder tree traversal
// BinaryNode duplicate( )--> Return a duplicate tree

/**
 * Binary node class with recursive routines to compute size and height.
 */
final class BinaryNode {
	/**
	 * Default node constructor.
	 */
	public BinaryNode() {
		this(null, null, null, 0);
	}

	/**
	 * Constructs a binary node with the given parts.
	 * 
	 * @param theElement
	 *            The element to set.
	 * @param lt
	 *            The left tree to set.
	 * @param rt
	 *            The right tree to set.
	 */
	public BinaryNode(Object theElement, BinaryNode lt, BinaryNode rt, int depth) {
		this.element = theElement;
		this.left = lt;
		this.right = rt;
		this.depth = depth;
	}

	/**
	 * Return the size of the binary tree rooted at tree.
	 * 
	 * @param t
	 *            The binary tree rooted at tree.
	 * @return The size of the tree.
	 */
	public static int size(BinaryNode t) {
		if (t == null)
			return 0;
		else
			return 1 + size(t.left) + size(t.right);
	}

	/**
	 * Return the height of the binary tree rooted at tree.
	 * 
	 * @param t
	 *            The binary tree rooted at tree.
	 * @return The height of the tree.
	 */
	public static int height(BinaryNode t) {
		if (t == null)
			return -1;
		else
			return 1 + Math.max(height(t.left), height(t.right));
	}

	/**
	 * Print tree rooted at current node using preorder traversal.
	 */
	public void printPreOrder() {
		System.out.println(this.element); // Node
		if (this.left != null)
			this.left.printPreOrder(); // Left
		if (this.right != null)
			this.right.printPreOrder(); // Right
	}

	/**
	 * Print tree rooted at current node using postorder traversal.
	 */
	public void printPostOrder() {
		if (this.left != null)
			this.left.printPostOrder(); // Left
		if (this.right != null)
			this.right.printPostOrder(); // Right
		System.out.println(this.element); // Node
	}

	/**
	 * Print tree rooted at current node using inorder traversal.
	 */
	public void printInOrder() {
		if (this.left != null)
			this.left.printInOrder(); // Left
		System.out.println(this.element); // Node
		if (this.right != null)
			this.right.printInOrder(); // Right
	}
	
	//return the inorder traversal of the tree
	public String InOrder() {
		String s = "";
		if (this.left != null)
			s += this.left.InOrder();
		s += this.element.toString();
		if (this.right != null)
			s += this.right.InOrder();
		return s;
	}

	/**
	 * Return a reference to a node that is the root of a duplicate of the
	 * binary tree rooted at the current node.
	 * 
	 * @return Duplicate of the binary tree.
	 */
	public BinaryNode duplicate() {
		BinaryNode root = new BinaryNode(this.element, null, null, 0);

		if (this.left != null) // If there's a left subtree
			root.left = this.left.duplicate(); // Duplicate; attach
		if (this.right != null) // If there's a right subtree
			root.right = this.right.duplicate(); // Duplicate; attach
		return root; // Return resulting tree
	}

	/**
	 * Gets the element.
	 * 
	 * @return The node's element.
	 */
	public Object getElement() {
		return this.element;
	}

	/**
	 * Gets the left child.
	 * 
	 * @return A reference to the left child.
	 */
	public BinaryNode getLeft() {
		return this.left;
	}

	/**
	 * Gets the left child.
	 * 
	 * @return A reference to the right child.
	 */
	public BinaryNode getRight() {
		return this.right;
	}

	/**
	 * Sets the element to the given value.
	 * 
	 * @param x
	 *            The value to which to set the element.
	 */
	public void setElement(Object x) {
		this.element = x;
	}

	/**
	 * Sets the left tree to the given reference.
	 * 
	 * @param t
	 *            The reference to which to set the left tree.
	 */
	public void setLeft(BinaryNode t) {
		this.left = t;
	}

	/**
	 * Sets the right tree to the given reference.
	 * 
	 * @param t
	 *            The reference to which to set the right tree.
	 */
	public void setRight(BinaryNode t) {
		this.right = t;
	}
	
	public void setElement(String t) {
		this.element = t;
	}
	
	//return y posotion of node
	public int getHeight(BinaryNode t, int treeHeight, int windowHeight, int nodeSize){
		int partition = 0;
		int offset = 40;
		int totalSize = windowHeight - offset;
		if (treeHeight == 0)
			partition = 0;
		else
			partition = totalSize / treeHeight;
//		System.out.println(t.element.toString() + " " + t.height(t));
		return /*totalSize + ((-1) * */(t.depth) * partition + 10;
    }
	
	//return x position of node
	public int getWidth(int nodePosition, int nodeSize){
		int offset = 20;
    	int nodeWidth = nodeSize * (nodePosition + 1);
    	return nodeWidth + offset;
    }
	private Object element;

	private BinaryNode left;

	private BinaryNode right;
	public int depth = 0;
}
