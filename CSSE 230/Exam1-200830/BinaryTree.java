// You should not have to use this class for anything.  
// I use it for generating test cases.

// BinaryTree class; stores a binary tree.
//
// CONSTRUCTION: with (a) no parameters or (b) an object to
//    be placed in the root of a one-element tree.
//
// *******************PUBLIC OPERATIONS**********************
// Various tree traversals, size, height, isEmpty, makeEmpty.
// Also, the following tricky method:
// void merge( Object root, BinaryTree t1, BinaryTree t2 )
//                        --> Construct a new tree
// *******************ERRORS*********************************
// Error message printed for illegal merges.

/**
 * BinaryTree class that illustrates the calling of BinaryNode recursive
 * routines and merge.
 */
public class BinaryTree {
	/**
	 * Default constructor.
	 */
	public BinaryTree() {
		this.root = null;
	}

	/**
	 * Constructs a 1-node binary tree with the given item.
	 * 
	 * @param rootItem
	 *            The item to place at the root.
	 */
	public BinaryTree(Object rootItem) {
		this.root = new BinaryNode(rootItem, null, null);
	}

	/**
	 * Sensible constructor that takes a new root and two existing trees.
	 * 
	 * @param rootItem
	 * @param left
	 *            must not be null
	 * @param right
	 *            must not be null
	 */
	public BinaryTree(Object rootItem, BinaryTree left, BinaryTree right) {
		if (left == null) {
			throw new NullPointerException("left subtree was null");
		}
		if (right == null) {
			throw new NullPointerException("right subtree was null");
		}
		if (left == right || left.root == right.root && left.root != null) {
			throw new IllegalArgumentException(
					"left and right subtrees are non-empty and aliased.");
		}
		this.root = new BinaryNode(rootItem, left.root, right.root);
	}

	/**
	 * Prints the tree's contents using a pre-order traversal.
	 */
	public void printPreOrder() {
		if (this.root != null)
			this.root.printPreOrder();
	}

	/**
	 * Prints the tree's contents using an in-order traversal.
	 */
	public void printInOrder() {
		if (this.root != null)
			this.root.printInOrder();
	}

	/**
	 * Prints the tree's contents using a post-order traversal.
	 */
	public void printPostOrder() {
		if (this.root != null)
			this.root.printPostOrder();
	}

	/**
	 * Resets the tree.
	 */
	public void makeEmpty() {
		this.root = null;
	}

	/**
	 * Checks if the tree is empty.
	 * 
	 * @return Whether or not the tree is empty.
	 */
	public boolean isEmpty() {
		return this.root == null;
	}

	/**
	 * Merge routine for BinaryTree class. Forms a new tree from rootItem, t1
	 * and t2. Does not allow t1 and t2 to be the same. Correctly handles other
	 * aliasing conditions.
	 * 
	 * @param rootItem
	 *            The item at the root.
	 * @param t1
	 *            The tree to use as the left tree.
	 * @param t2
	 *            The tree to use as the right tree.
	 */
	public void merge(Object rootItem, BinaryTree t1, BinaryTree t2) {
		if (t1.root == t2.root && t1.root != null) {
			System.err.println("leftTree==rightTree; merge aborted");
			return;
		}

		// Allocate new node
		this.root = new BinaryNode(rootItem, t1.root, t2.root);

		// Ensure that every node is in one tree
		if (this != t1)
			t1.root = null;
		if (this != t2)
			t2.root = null;
	}

	/**
	 * Returns the size of the tree.
	 * 
	 * @return The size of the tree
	 */
	public int size() {
		return BinaryNode.size(this.root);
	}

	/**
	 * Returns the height of the tree.
	 * 
	 * @return The height of the tree
	 */
	public int getHeight() {
		return BinaryNode.height(this.root);
	}

	/**
	 * Returns the root of the tree.
	 * 
	 * @return The root of the tree
	 */
	public BinaryNode getRoot() {
		return this.root;
	}

	BinaryNode root;  // not private; package friendly.

	/**
	 * Quick test driver.
	 * 
	 * @param args
	 */
	static public void main(String[] args) {
		BinaryTree t1 = new BinaryTree("1");
		BinaryTree t3 = new BinaryTree("3");
		BinaryTree t5 = new BinaryTree("5");
		BinaryTree t7 = new BinaryTree("7");
		BinaryTree t2 = new BinaryTree();
		BinaryTree t4 = new BinaryTree();
		BinaryTree t6 = new BinaryTree();

		t2.merge("2", t1, t3);
		t6.merge("6", t5, t7);
		t4.merge("4", t2, t6);

		System.out.println("t4 should be perfect 1-7; t2 empty");
		System.out.println("----------------");
		System.out.println("t4");
		t4.printInOrder();
		System.out.println("----------------");
		System.out.println("t2");
		t2.printInOrder();
		System.out.println("----------------");
		System.out.println("t4 size: " + t4.size());
		System.out.println("t4 height: " + t4.getHeight());
	}

	/**
	 * @return the string formed by an in-order traversal of the nodes in this
	 *         tree
	 */
	public String inOrder() {
		StringBuilder result = new StringBuilder();
		InOrder iter = new InOrder(this);
		iter.first();
		while (iter.isValid()) {
			result.append(iter.retrieve());
			iter.advance();
		}
		return result.toString();
	}
}