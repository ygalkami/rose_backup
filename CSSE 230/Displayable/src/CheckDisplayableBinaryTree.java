/* This is a preliminary program to assist in the grading
 * of the displayableBinaryTree assignment.  If you have
 * written your code to meet the specifications, you should be 
 * able to copy this into the directory with your source files,
 * compile it, and run it. 
 **/

import java.io.BufferedReader;
import java.io.InputStreamReader;

/**
 * Provided test class.
 * 
 * @author unknown. Created Jan 24, 2008.
 */
class CheckDisplayableBinaryTree {

	private final static int windowWidth = 600;

	private final static int windowHeight = 800;

	private static int count = 0;

	private static int max = 12;

	/**
	 * Runs the test display code.
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		try {
			int i = 0;
			boolean inOrderCorrect = true;
			BufferedReader in = new BufferedReader(new InputStreamReader(
					System.in));

			for (i = 0; i <= max; i++) {
				TreePair tp = treeFactory(i, false);
				if (!tp.bTree.inOrder().equals(inOrder(i))) {
					inOrderCorrect = false;

					System.err.println("InOrder mismatch for tree " + i
							+ ": Correct: " + inOrder(i) + " Yours: "
							+ tp.bTree.inOrder());
				}
			}

			if (inOrderCorrect) {
				System.out.println("All inOrder traversals correct");
			}

			while (true) {
				System.out.println();
				System.out
						.println("Enter a number to choose the tree to display [0 - "
								+ max + " (blank line to exit) ] ");
				String inString = in.readLine();
				if (inString == null || inString.equals(""))
					return;

				try {
					int num = Integer.parseInt(inString);
					TreePair tp = treeFactory(num, true);
					System.out.println("Tree " + num + " - inOrder(): "
							+ tp.bTree.inOrder() + "\n");
					tp.dbTree.display();
					tp.dbTree.setSize((int) (200 + 500 * Math.random()),
							(int) (300 + 600 * Math.random()));
					tp.dbTree.display();
				} catch (InternalError e) {
					System.out
							.println("You must run this in an environment that does windows in order to test the display part.");
				}

			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}

	}

	private static String inOrder(int index) {
		switch (index) {
		case 0:
			return "A";
		case 1:
			return "BAC";
		case 2:
			return "GFEDCBA";
		case 3:
			return "ACEGIKLJHFDB";
		case 4:
			return "CBDAGFHEKJLINOQPRUTSM";
		case 5:
			return "CBDAGFHEKJLINOQPRUwvxzyTSM";
		case 6:
			return "CBDAGFHEKJLINOQPRUwvz102y54637xTSM";
		case 7:
			return "CBDAGFHEKJLINOQPRUwvxz213054698a7bcdefgyTSM";
		case 8:
			return "GDHBAEICF";
		case 9:
			return "HDIBJEKALFMCGNO";
		case 10:
			return "HDIBJEKALFMCNGOxHDIBJEKALFMCNGO";
		case 11:
			return "HDIBJEKALFMCNGOxHDIBJEKALFMCNGOyHDIBJEKALFMCNGOxHDIBJEKALFMCNGO";
		case 12:
			return "DLTPHBIQUMEAFNVRJCKSWOG";
		}
		return null;
	}

	/**
	 * Constructs a test tree and its displayable wrapper based on the given
	 * test index.
	 *
	 * @param index
	 * @param printing if true, then prints trace information
	 * @return the test tree and its displayable wrapper
	 */
	public static TreePair treeFactory(int index, boolean printing) {
		String s1 = "";
		String s2 = "";
		switch (index) {
		case 0:
			s1 = "A";
			s2 = "0";
			break;
		case 1:
			s1 = "ABC";
			s2 = "200";
			break;
		case 2:
			s1 = "ABCDEFG";
			s2 = "LLLLLL0";
			break;
		case 3:
			s1 = "ABCDEFGHIJKL";
			s2 = "RLRLRLRLRLR0";
			break;

		case 4:
			s1 = "ABCDEFGHIJKLMNOPQRSTU";
			s2 = "220022002200LRR20RLL0";
			break;
		case 5:
			s1 = "ABCDEFGHIJKLMNOPQRSTUvwxyz";
			s2 = "220022002200LRR20RLLR20RL0";
			break;
		case 6:
			s1 = "ABCDEFGHIJKLMNOPQRSTUvwxyz01234567";
			s2 = "220022002200LRR20RLLR20L2R20022000";
			break;
		case 7:
			s1 = "ABCDEFGHIJKLMNOPQRSTUvwxyz0123456789abcdefg";
			s2 = "220022002200LRR20RLLR20RLR220020R2200RRRRR0";
			break;
		case 8:
			s1 = "ABDGHCEIF";
			s2 = "2L2002R00";
			break;
		case 9:
			s1 = "ABDHIEJKCFLMNGO";
			s2 = "222002002200200";
			break;
		case 10:
			s1 = "xABDHIEJKCFLMGNOABDHIEJKCFLMGNO";
			s2 = "2222002002200200222002002200200";
			break;
		case 11:
			s1 = "yxABDHIEJKCFLMGNOABDHIEJKCFLMGNOxABDHIEJKCFLMGNOABDHIEJKCFLMGNO";
			s2 = "222220020022002002220020022002002222002002200200222002002200200";
			break;
		case 12:
			s1 = "ABDHLPTEIMQUCFJNRVGKOSW";
			s2 = "22RLRL0LRLR02RLRL0LRLR0";
			break;
		default:
			System.out.println("Invalid index specified for TreeFactory");
			break;
		}
		if (printing) {
			System.out.println("Constructing tree - parameters\n============\n"
					+ s1 + "\n" + s2 + "\n");
		}
		return newTree(s1, s2);
	}

	/**
	 * Creates a tree pair using the given pre-order listing of elements and
	 * child codes.
	 * @see BuildTree#preOrderBuild(CharSequence, CharSequence)
	 *
	 * @param elements
	 * @param childCodes
	 * @return the tree pair
	 */
	public static TreePair newTree(String elements, String childCodes) {
		count++;
		BinaryTree tree = BuildTree.preOrderBuild(elements, childCodes);
		DisplayableBinaryTree dbTree = new DisplayableBinaryTree(tree,
				windowWidth + 100 * (count % 6), windowHeight + 100
						* (count % 3));
		return new TreePair(tree, dbTree);
	}

}

/**
 * A helper class to associate trees and displays in a way that the test code
 * can use.
 */
class TreePair {

	/**
	 * The binary tree.
	 */
	public final BinaryTree bTree;

	/**
	 * The displayable binary tree wrapping the tree.
	 */
	public final DisplayableBinaryTree dbTree;

	/**
	 * Constructs a tree pair.
	 *
	 * @param bTree
	 * @param dbTree
	 */
	public TreePair(BinaryTree bTree, DisplayableBinaryTree dbTree) {
		this.bTree = bTree;
		this.dbTree = dbTree;
	}
}
