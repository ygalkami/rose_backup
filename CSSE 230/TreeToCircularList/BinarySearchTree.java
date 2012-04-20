import java.util.ArrayList;

// Code by Mark Weiss.  
// Modified by CWA as described in the problem assignment.

// BinarySearchTree class
//
// CONSTRUCTION: with no initializer
//
// ******************PUBLIC OPERATIONS*********************
// void insert( x )       --> Insert x
// void remove( x )       --> Remove x
// void removeMin( )      --> Remove minimum item
// Comparable find( x )   --> Return item that matches x
// Comparable findMin( )  --> Return smallest item
// Comparable findMax( )  --> Return largest item
// boolean isEmpty( )     --> Return true if empty; else false
// void makeEmpty( )      --> Remove all items
// ******************ERRORS********************************
// Exceptions are thrown by insert, remove, and removeMin if warranted

// ******* Public methods added for this exam problem *********
// String printTreeInOrder() 
// String printListForward()  ---traverses circular list forward
// String printListForward()  --- traverses circular list backward
// void turnTreeIntoCircularList()   --- you must write this and any needed helper methods.


// Field added for this exercise: 
//   BinaryNode first (Points to beginning of circular linked list after nthe transformation.

/**
 * Implements an unbalanced binary search tree.
 * Note that all "matching" is based on the compareTo method.
 * @author Mark Allen Weiss
 */
public class BinarySearchTree<AnyType extends Comparable<? super AnyType>>
{
    /**
     * Construct the tree.
     */
    public BinarySearchTree( )
    {
        root = null;
    }

    /**
     * Insert into the tree.
     * @param x the item to insert.
     * @throws DuplicateItemException if x is already present.
     */
    public void insert( AnyType x )
    {
        root = insert( x, root );
    }

    /**
     * Remove from the tree..
     * @param x the item to remove.
     * @throws ItemNotFoundException if x is not found.
     */
    public void remove( AnyType x )
    {
        root = remove( x, root );
    }

    /**
     * Remove minimum item from the tree.
     * @throws ItemNotFoundException if tree is empty.
     */
    public void removeMin( )
    {
        root = removeMin( root );
    }

    /**
     * Find the smallest item in the tree.
     * @return smallest item or null if empty.
     */
    public AnyType findMin( )
    {
        return elementAt( findMin( root ) );
    }

    /**
     * Find the largest item in the tree.
     * @return the largest item or null if empty.
     */
    public AnyType findMax( )
    {
        return elementAt( findMax( root ) );
    }

    /**
     * Find an item in the tree.
     * @param x the item to search for.
     * @return the matching item or null if not found.
     */
    public AnyType find( AnyType x )
    {
        return elementAt( find( x, root ) );
    }

    /**
     * Make the tree logically empty.
     */
    public void makeEmpty( )
    {
        root = null;
    }

    /**
     * Test if the tree is logically empty.
     * @return true if empty, false otherwise.
     */
    public boolean isEmpty( )
    {
        return root == null;
    }

    /**
     * Internal method to get element field.
     * @param t the node.
     * @return the element field or null if t is null.
     */
    private AnyType elementAt( BinaryNode<AnyType> t )
    {
        return t == null ? null : t.element;
    }

    /**
     * Internal method to insert into a subtree.
     * @param x the item to insert.
     * @param t the node that roots the tree.
     * @return the new root.
     * @throws DuplicateItemException if x is already present.
     */
    protected BinaryNode<AnyType> insert( AnyType x, BinaryNode<AnyType> t )
    {
        if( t == null )
            t = new BinaryNode<AnyType>( x );
        else if( x.compareTo( t.element ) < 0 )
            t.left = insert( x, t.left );
        else if( x.compareTo( t.element ) > 0 )
            t.right = insert( x, t.right );
        else
            throw new DuplicateItemException( x.toString( ) );  // Duplicate
        return t;
    }

    /**
     * Internal method to remove from a subtree.
     * @param x the item to remove.
     * @param t the node that roots the tree.
     * @return the new root.
     * @throws ItemNotFoundException if x is not found.
     */
    protected BinaryNode<AnyType> remove( AnyType x, BinaryNode<AnyType> t )
    {
        if( t == null )
            throw new ItemNotFoundException( x.toString( ) );
        if( x.compareTo( t.element ) < 0 )
            t.left = remove( x, t.left );
        else if( x.compareTo( t.element ) > 0 )
            t.right = remove( x, t.right );
        else if( t.left != null && t.right != null ) // Two children
        {
            t.element = findMin( t.right ).element;
            t.right = removeMin( t.right );
        }
        else
            t = ( t.left != null ) ? t.left : t.right;
        return t;
    }

    /**
     * Internal method to remove minimum item from a subtree.
     * @param t the node that roots the tree.
     * @return the new root.
     * @throws ItemNotFoundException if t is empty.
     */
    protected BinaryNode<AnyType> removeMin( BinaryNode<AnyType> t )
    {
        if( t == null )
            throw new ItemNotFoundException( );
        else if( t.left != null )
        {
            t.left = removeMin( t.left );
            return t;
        }
        else
            return t.right;
    }    

    /**
     * Internal method to find the smallest item in a subtree.
     * @param t the node that roots the tree.
     * @return node containing the smallest item.
     */
    protected BinaryNode<AnyType> findMin( BinaryNode<AnyType> t )
    {
        if( t != null )
            while( t.left != null )
                t = t.left;

        return t;
    }

    /**
     * Internal method to find the largest item in a subtree.
     * @param t the node that roots the tree.
     * @return node containing the largest item.
     */
    private BinaryNode<AnyType> findMax( BinaryNode<AnyType> t )
    {
        if( t != null )
            while( t.right != null )
                t = t.right;

        return t;
    }

    /**
     * Internal method to find an item in a subtree.
     * @param x is item to search for.
     * @param t the node that roots the tree.
     * @return node containing the matched item.
     */
    private BinaryNode<AnyType> find( AnyType x, BinaryNode<AnyType> t )
    {
        while( t != null )
        {
            if( x.compareTo( t.element ) < 0 )
                t = t.left;
            else if( x.compareTo( t.element ) > 0 )
                t = t.right;
            else
                return t;    // Match
        }
        
        return null;         // Not found
    }
    
// print methods were added/modified by CWA.
    
    public String printTreeInOrder() {    
       return BinarySearchTree.printTree(root);
    }
    
   protected  static String printTree(BinaryNode root) {  // prints inorder.
       if (root == null) 
         return "";
       String leftTree = printTree(root.left);
       String leftSpace = (leftTree == "") ? "" : " " ; 
       String rightTree = printTree(root.right);
       String rightSpace = (rightTree == "") ? "" : " " ; 
       return leftTree + leftSpace + root.element + rightSpace + rightTree;
    }
   
    public String printListForward() {   
       String result = "";
       BinaryNode current=null;
       if (first != null) {
          current = first;
          while (current.right != first) {
             result += current.element + " ";
             current = current.right;
          }
          result += current.element;
       }
       return result;
    }
    
    public String printListBackward () {
       if (first == null)
          return "";
       BinaryNode current = first.left;
       String result = current.element + "";;
       while (current != first) {
           current = current.left;
           result = current.element + " " + result;  
       }
       return result;
    }
    
 // ADDED by CWA.
    
   /*
   Converts this BinarySearchTree into an ordered circular doubly-linked list.
   Pre: The "root" field is the root of the original tree.  ]
   Post: The "first" field is to point to the first node of the list.
   No new nodes are created in the process, and the element fields of the 
   existing nodes are not changed.  Of course you can change the left and right fields
   of the nodes.4
  */
   public void turnTreeIntoCircularList() {
	   if (this.root != null) {
		   ArrayList<BinaryNode> list = this.generateList(this.root);
		   
		   list.get(0).left = list.get(list.size() - 1);
		   list.get(list.size() - 1).right = list.get(0);
		   
		   for (int i = 0; i < list.size() - 1; i++) {
			   list.get(i).right = list.get(i + 1);
		   }
		   
		   for (int i = list.size() - 1; i > 0; i--) {
			   list.get(i).left = list.get(i - 1);
		   }
		   this.first = list.get(0);
	   }
   }
   
   
   public ArrayList<BinaryNode> generateList (BinaryNode start) {
	   ArrayList<BinaryNode> list = new ArrayList<BinaryNode>();
	   if (start.left != null)
		   this.addLists(list, this.generateList(start.left));
	   list.add(start);
	   if (start.right != null)
		   this.addLists(list, this.generateList(start.right));
	   return list;
   }
   
   public ArrayList<BinaryNode> addLists(ArrayList<BinaryNode> first, ArrayList<BinaryNode> second) {
	   for (BinaryNode node : second) {
		   first.add(node);
	   }
	   return first;
   }
   
   public void InsertLeft(BinaryNode current, BinaryNode insert) {
	   insert.right = current;
	   insert.left = current.left;
	   current.left = insert;
   }
   
   public void InsertRight(BinaryNode current, BinaryNode insert) {
	   insert.right = current.right;
	   insert.left = current;
	   current.right = insert;
   }
    

      /** The tree root. */
    protected BinaryNode<AnyType> root;
    protected BinaryNode<AnyType> first;
    



}

