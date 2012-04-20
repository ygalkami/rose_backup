class ThreadedBinaryNode<T> {
    
  T element;
  ThreadedBinaryNode<T> left, right;
  boolean isLeftThread, isRightThread;
  // When isLeftThread is true, it means that the left reference
  // is a thread; it points to the node's inorder predecessor.
  // When isRightThread is true, it means that the right reference
  // is a thread; it points to the node's inorder successor.

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
    String.format("(%13s %13s %13s %7b %6b)", 
      element,
        (left==null ? "null" : left.element.toString()),
        (right==null ? "null" : right.element.toString()),
        isLeftThread, isRightThread) ;
  }
}



