import java.util.NoSuchElementException;

import weiss.nonstandard.Stack;
import weiss.nonstandard.Queue;
import weiss.nonstandard.ArrayStack;
import weiss.nonstandard.ArrayQueue;

// TreeIterator class; maintains "current position"
//
// CONSTRUCTION: with tree to which iterator is bound
//
// ******************PUBLIC OPERATIONS**********************
//     first and advance are abstract; others are final
// boolean isValid( )   --> True if at valid position in tree
// Object retrieve( )   --> Return item in current position
// void first( )        --> Set current position to first
// void advance( )      --> Advance (prefix)
// ******************ERRORS*********************************
// Exceptions thrown for illegal access or advance

/**
 * Tree iterator class.
 * 
 * @author Mark Allen Weiss
 */
abstract class TreeIterator {
	/**
	 * Construct the iterator. The current position is set to null.
	 * 
	 * @param theTree
	 *            the tree to which the iterator is permanently bound.
	 */
	public TreeIterator(BinaryTree theTree) {
		tree = theTree;
		current = null;
	}

	/**
	 * Set the current position to the first item, according to the traversal
	 * scheme.
	 */
	abstract public void first();

	/**
	 * Test if current position references a valid tree item.
	 * 
	 * @return true if the current position is not null; false otherwise.
	 */
	final public boolean isValid() {
		return current != null;
	}

	/**
	 * Return the item stored in the current position.
	 * 
	 * @return the stored item.
	 * @throws NoSuchElementException
	 *             if the current position is invalid.
	 */
	final public Object retrieve() {
		if (current == null)
			throw new NoSuchElementException("TreeIterator retrieve");
		return current.getElement();
	}

	/**
	 * Advance the current position to the next node in the tree, according to
	 * the traversal scheme. If the current position is null, then throw an
	 * exception. This is the alternate strategy, that we did not use for lists.
	 * 
	 * @throws NoSuchElementException
	 *             if the current position is null.
	 */
	abstract public void advance();

	/** The tree. */
	protected BinaryTree tree; // Tree

	/** Current position. */
	protected BinaryNode current; // Current position
}

// PostOrder class; maintains "current position"
// according to a postorder traversal
// 
// CONSTRUCTION: with tree to which iterator is bound
//
// ******************PUBLIC OPERATIONS**********************
// boolean isValid( ) --> True if at valid position in tree
// Object retrieve( ) --> Return item in current position
// void first( ) --> Set current position to first
// void advance( ) --> Advance (prefix)
// ******************ERRORS*********************************
// Exceptions thrown for illegal access or advance

/**
 * Postorder iterator class.
 * 
 * @author Mark Allen Weiss
 */
class PostOrder extends TreeIterator {
	/**
	 * Construct the iterator. The current position is set to null.
	 * 
	 * @param theTree
	 *            the tree to which the iterator is permanently bound.
	 */
	public PostOrder(BinaryTree theTree) {
		super(theTree);
		s = new ArrayStack<StNode>();
		s.push(new StNode(tree.getRoot()));
	}

	/**
	 * Set the current position to the first item, according to the postorder
	 * traversal scheme.
	 */
	@Override
	public void first() {
		s.makeEmpty();
		if (tree.getRoot() != null)
			s.push(new StNode(tree.getRoot()));
		try {
			advance();
		} catch (NoSuchElementException e) {
			// Empty tree
		}
	}

	/**
	 * Advance the current position to the next node in the tree, according to
	 * the postorder traversal scheme.
	 * 
	 * @throws NoSuchElementException
	 *             if iteration has been exhausted prior to the call.
	 */
	@Override
	public void advance() {
		if (s.isEmpty()) {
			if (current == null)
				throw new NoSuchElementException("PostOrder Advance");
			current = null;
			return;
		}

		StNode cnode;

		for (;;) {
			cnode = s.topAndPop();

			if (++cnode.timesPopped == 3) {
				current = cnode.node;
				return;
			}

			s.push(cnode);
			if (cnode.timesPopped == 1) {
				if (cnode.node.getLeft() != null)
					s.push(new StNode(cnode.node.getLeft()));
			} else // cnode.timesPopped == 2
			{
				if (cnode.node.getRight() != null)
					s.push(new StNode(cnode.node.getRight()));
			}
		}
	}

	/** An internal class for tree iterators. */
	protected static class StNode {
		/**
		 * The node.
		 */
		BinaryNode node;

		/**
		 * Number of times popped (for post-order iterator).
		 */
		int timesPopped;

		/**
		 * Constructs a stack node that hasn'tree been popped yet.
		 * 
		 * @param n
		 */
		StNode(BinaryNode n) {
			node = n;
			timesPopped = 0;
		}
	}

	/** An internal stack if visited nodes. */
	protected Stack<StNode> s; // The stack of StNode objects
}

// InOrder class; maintains "current position"
// according to an inorder traversal
// 
// CONSTRUCTION: with tree to which iterator is bound
//
// ******************PUBLIC OPERATIONS**********************
// boolean isValid( ) --> True if at valid position in tree
// Object retrieve( ) --> Return item in current position
// void first( ) --> Set current position to first
// void advance( ) --> Advance (prefix)
// ******************ERRORS*********************************
// Exceptions thrown for illegal access or advance

/**
 * Inorder iterator class.
 * 
 * @author Mark Allen Weiss
 */
class InOrder extends PostOrder {
	/**
	 * Construct the iterator. The current position is set to null.
	 * 
	 * @param theTree
	 *            the tree to which the iterator is permanently bound.
	 */
	public InOrder(BinaryTree theTree) {
		super(theTree);
	}

	/**
	 * Advance the current position to the next node in the tree, according to
	 * the inorder traversal scheme.
	 * 
	 * @throws NoSuchElementException
	 *             if iteration has been exhausted prior to the call.
	 */
	@Override
	public void advance() {
		if (s.isEmpty()) {
			if (current == null)
				throw new NoSuchElementException("InOrder advance");
			current = null;
			return;
		}

		StNode cnode;

		for (;;) {
			cnode = s.topAndPop();

			if (++cnode.timesPopped == 2) {
				current = cnode.node;
				if (cnode.node.getRight() != null)
					s.push(new StNode(cnode.node.getRight()));
				return;
			}

			// First time through
			s.push(cnode);
			if (cnode.node.getLeft() != null)
				s.push(new StNode(cnode.node.getLeft()));
		}
	}
}

// PreOrder class; maintains "current position"
// according to a preorder traversal
// 
// CONSTRUCTION: with tree to which iterator is bound
//
// ******************PUBLIC OPERATIONS**********************
// boolean isValid( ) --> True if at valid position in tree
// Object retrieve( ) --> Return item in current position
// void first( ) --> Set current position to first
// void advance( ) --> Advance (prefix)
// ******************ERRORS*********************************
// Exceptions thrown for illegal access or advance

/**
 * Preorder iterator class.
 * 
 * @author Mark Allen Weiss
 */
class PreOrder extends TreeIterator {
	/**
	 * Construct the iterator. The current position is set to null.
	 * 
	 * @param theTree
	 *            the tree to which the iterator is permanently bound.
	 */
	public PreOrder(BinaryTree theTree) {
		super(theTree);
		s = new ArrayStack<BinaryNode>();
		s.push(tree.getRoot());
	}

	/**
	 * Set the current position to the first item, according to the preorder
	 * traversal scheme.
	 */
	@Override
	public void first() {
		s.makeEmpty();
		if (tree.getRoot() != null)
			s.push(tree.getRoot());
		try {
			advance();
		} catch (NoSuchElementException e) {
			// Empty tree
		}
	}

	/**
	 * Advance the current position to the next node in the tree, according to
	 * the preorder traversal scheme.
	 * 
	 * @throws NoSuchElementException
	 *             if iteration has been exhausted prior to the call.
	 */
	@Override
	public void advance() {
		if (s.isEmpty()) {
			if (current == null)
				throw new NoSuchElementException("PreOrder Advance");
			current = null;
			return;
		}

		current = s.topAndPop();

		if (current.getRight() != null)
			s.push(current.getRight());
		if (current.getLeft() != null)
			s.push(current.getLeft());
	}

	/** An internal stack of visited nodes */
	private Stack<BinaryNode> s; // Stack of TreeNode objects
}

// LevelOrder class; maintains "current position"
// according to a level-order traversal
// 
// CONSTRUCTION: with tree to which iterator is bound
//
// ******************PUBLIC OPERATIONS**********************
// boolean isValid( ) --> True if at valid position in tree
// Object retrieve( ) --> Return item in current position
// void first( ) --> Set current position to first
// void advance( ) --> Advance (prefix)
// ******************ERRORS*********************************
// Exceptions thrown for illegal access or advance

/**
 * Level-order iterator class.
 * 
 * @author Mark Allen Weiss
 */
class LevelOrder extends TreeIterator {
	/**
	 * Construct the iterator. The current position is set to null.
	 * 
	 * @param theTree
	 *            the tree to which the iterator is permanently bound.
	 */
	public LevelOrder(BinaryTree theTree) {
		super(theTree);
		q = new ArrayQueue<BinaryNode>();
		q.enqueue(tree.getRoot());
	}

	/**
	 * Set the current position to the first item, according to the level-order
	 * traversal scheme.
	 */
	@Override
	public void first() {
		q.makeEmpty();
		if (tree.getRoot() != null)
			q.enqueue(tree.getRoot());
		try {
			advance();
		} catch (NoSuchElementException e) {
			// Empty tree
		}
	}

	/**
	 * Advance the current position to the next node in the tree, according to
	 * the level-order traversal scheme.
	 * 
	 * @throws NoSuchElementException
	 *             if iteration has been exhausted prior to the call.
	 */
	@Override
	public void advance() {
		if (q.isEmpty()) {
			if (current == null)
				throw new NoSuchElementException("LevelOrder advance");
			current = null;
			return;
		}

		current = q.dequeue();

		if (current.getLeft() != null)
			q.enqueue(current.getLeft());
		if (current.getRight() != null)
			q.enqueue(current.getRight());
	}

	/** An internal queue of visited nodes */
	private Queue<BinaryNode> q; // Queue of TreeNode objects
}

/**
 * A test program for tree iterators.
 */
public class TestTreeIterators {
	/**
	 * Test program
	 * 
	 * @param args
	 *            ignored
	 */
	public static void main(String[] args) {
		BinaryTree t = new BinaryTree();

		testItr("PreOrder", new PreOrder(t)); // Test empty tree

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

		t = t4;

		testItr("Preorder", new PreOrder(t));
		testItr("Postorder", new PostOrder(t));
		testItr("Inorder", new InOrder(t));
		testItr("Level order", new LevelOrder(t));
	}

	/**
	 * Prints out the type of the iteration, then runs the given iterator,
	 * printing its returned values.
	 * 
	 * @param type
	 * @param itr
	 */
	public static void testItr(String type, TreeIterator itr) {
		try {
			System.out.print(type + ":");
			for (itr.first(); itr.isValid(); itr.advance())
				System.out.print(" " + itr.retrieve());
			System.out.println();
			itr.advance();
		} catch (NoSuchElementException e) {
			System.out.println(e + " (as expected)");
		}
	}
}
