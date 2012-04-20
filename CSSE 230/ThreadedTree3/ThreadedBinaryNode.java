class ThreadedBinaryNode<T> {
    
  T element;
  ThreadedBinaryNode<T> left, right;
  boolean isLeftThread, isRightThread;
  // When isLeftThread is true, it means that the left reference
  // is a thread; it points to the node's inorder predecessor.
  // When isRightThread is true, it means that the right reference
  // is a thread; it points to the node's inorder successor.
  
  // NOTE:  You are not allowed to add any additional fields to this class.

  ThreadedBinaryNode(T theElement) {
    this(theElement, null, null, true, true);
  }

   ThreadedBinaryNode(T theElement, ThreadedBinaryNode<T> lt,
                      ThreadedBinaryNode<T> rt) {
    this(theElement, lt, rt, true, true);
  }

  ThreadedBinaryNode(T theElement, ThreadedBinaryNode<T> lt,
                     ThreadedBinaryNode<T> rt, boolean rThread, boolean lThread) {
    element = theElement;
    left = lt;
    right = rt;
    isLeftThread = lThread;
    isRightThread = rThread;
  }

// Written the way it is to facilitate debugging.
  public String toString()  {
    return
    String.format("(%13s %13s %13s %7b %6b %13s)", 
      element,
        (left==null ? "null" : left.element.toString()),
        (right==null ? "null" : right.element.toString()),
        isLeftThread, isRightThread,
        (getParent()==null ? "null" : getParent().element.toString()));
  }
  
  public ThreadedBinaryNode<T> inOrderSuccessor() {
     if (this.isRightThread)
         return this.right;
     ThreadedBinaryNode<T> t  = this.right;
     while (!t.isLeftThread)
         t = t.left;
     return t;
  }
  
  public ThreadedBinaryNode<T> inOrderPredecessor() {
	 if (this.isLeftThread)
	   return this.left;
	 ThreadedBinaryNode<T> t  = this.left;
	 while (!t.isRightThread)
	    t = t.right;
	 return t;
  }
  
  
  // return the parent of this node.
  // If this node is the root of its tree, its parent will be null.
  // The worst-case running time of code must be proportional to the height of the tree.
  //
  // I.e. you are not allowed to traverse the whole tree looking for the parent.
  // If you look carefully at several trees, you will see that the threads make 
  //    it possible to do this, but you may need a clever idea.
  //
  // You are not allowed to add any fields to this class.
  // You should only add code to this method.
  
  public ThreadedBinaryNode<T> getParent() {
	  ThreadedBinaryNode temp = this;
	  
	  while(!temp.isLeftThread)
		  temp = temp.left;
	  if (temp.left != null && temp.left.right.equals(this))
		  return temp.left;
	  temp = this;
	  while(!temp.isRightThread)
		  temp = temp.right;
	  if (temp.right != null && temp.right.left.equals(this))
		  return temp.right;
	  return null;
  }
}



