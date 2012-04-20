# An object-oriented etude on binary trees.
# by Curt Clifton, March 13, 2008

import doctest

def build_tree(preord, inord):
    """Tree factory.
    
    Builds a binary tree from the given preorder and inorder traversal strings.
    
    >>> t = build_tree('', '')
    >>> for n in t.preorder(): print n
    >>> for n in t.inorder(): print n
    >>> for n in t.postorder(): print n
    >>> for n in t.levelorder(): print n
    >>> t = build_tree('A', 'A')
    >>> for n in t.preorder(): print n
    A
    >>> for n in t.inorder(): print n
    A
    >>> for n in t.postorder(): print n
    A
    >>> for n in t.levelorder(): print n
    A
    >>> t = build_tree('ABC', 'BAC')
    >>> for n in t.preorder(): print n
    A
    B
    C
    >>> for n in t.inorder(): print n
    B
    A
    C
    >>> for n in t.postorder(): print n
    B
    C
    A
    >>> for n in t.levelorder(): print n
    A
    B
    C
    >>> t = build_tree('ABC', 'BCA')
    >>> for n in t.preorder(): print n
    A
    B
    C
    >>> for n in t.inorder(): print n
    B
    C
    A
    >>> for n in t.postorder(): print n
    C
    B
    A
    >>> for n in t.levelorder(): print n
    A
    B
    C
    >>> t = build_tree('THEQUICKLAZYFOX', 'QIUCEHLAZKFYTXO')
    >>> for n in t.preorder(): print n
    T
    H
    E
    Q
    U
    I
    C
    K
    L
    A
    Z
    Y
    F
    O
    X
    >>> for n in t.inorder(): print n
    Q
    I
    U
    C
    E
    H
    L
    A
    Z
    K
    F
    Y
    T
    X
    O
    >>> for n in t.postorder(): print n
    I
    C
    U
    Q
    E
    Z
    A
    L
    F
    Y
    K
    H
    X
    O
    T
    >>> for n in t.levelorder(): print n
    T
    H
    O
    E
    K
    X
    Q
    L
    Y
    U
    A
    F
    I
    C
    Z
    >>> t = build_tree('AQUICHE', 'UQIAHCE')
    >>> t = build_tree('UNCOPYRIGHTABLE', 'OCPNRYIUTHAGLBE')
    >>> t = build_tree('AMBIDEXTROUS', 'MIDBEARTUOXS')
    >>> t = build_tree('FLOWCHARTING', 'OWARNGITHCLF')
    >>> t = build_tree('LUMBERJACK', 'EBMRULCAKJ')
    """
    if len(preord) != len(inord):
        raise ValueError('Invalid tree specification: unequal traversal lengths')
    if len(preord) == 0:
        return BinaryTreeNullNode()
    element = preord[0]
    try:
        left_size = inord.index(element)
    except ValueError:
        raise ValueError("Impossible tree specification")
    left = build_tree(preord[1:left_size+1], inord[0:left_size])
    right = build_tree(preord[left_size+1:], inord[left_size+1:])
    return BinaryTreeNode(element, left, right)

# -----------------------------------------------------------------------------
# Concrete, user classes
class BinaryTreeNode:
    """An internal binary tree node.
    
    Internal nodes have an element and two children.  Leaf nodes are represented
    as internal nodes with two BinaryTreeNullNodes for children."""
    def __init__(self, element, left_subtree, right_subtree):
        self.element = element
        self.left = left_subtree
        self.right = right_subtree
        
    def preorder(self):
        """Generates a pre-order traversal of the tree rooted at this node.
        
        >>> t = BinaryTreeNode('A', BinaryTreeLeafNode('B'), BinaryTreeLeafNode('C'))
        >>> for n in t.preorder(): print n
        A
        B
        C
        >>> t = BinaryTreeLeftyNode('A', BinaryTreeLeafNode('B'))
        >>> for n in t.preorder(): print n
        A
        B
        >>> t = BinaryTreeRightyNode('A', BinaryTreeLeafNode('B'))
        >>> for n in t.preorder(): print n
        A
        B
        >>> t = BinaryTreeLeafNode('A')
        >>> for n in t.preorder(): print n
        A
        >>> t = BinaryTreeNullNode()
        >>> for n in t.preorder(): print n
        """
        yield self.element
        for n in self.left.preorder():
            yield n
        for n in self.right.preorder():
            yield n

    def postorder(self):
        """Generates a post-order traversal of the tree rooted at this node.
        
        >>> t = BinaryTreeNode('A', BinaryTreeLeafNode('B'), BinaryTreeLeafNode('C'))
        >>> for n in t.postorder(): print n
        B
        C
        A
        >>> t = BinaryTreeLeftyNode('A', BinaryTreeLeafNode('B'))
        >>> for n in t.postorder(): print n
        B
        A
        >>> t = BinaryTreeRightyNode('A', BinaryTreeLeafNode('B'))
        >>> for n in t.postorder(): print n
        B
        A
        >>> t = BinaryTreeLeafNode('A')
        >>> for n in t.postorder(): print n
        A
        >>> t = BinaryTreeNullNode()
        >>> for n in t.postorder(): print n
        """
        for n in self.left.postorder():
            yield n
        for n in self.right.postorder():
            yield n
        yield self.element

    def inorder(self):
        """Generates a in-order traversal of the tree rooted at this node.
        
        >>> t = BinaryTreeNode('A', BinaryTreeLeafNode('B'), BinaryTreeLeafNode('C'))
        >>> for n in t.inorder(): print n
        B
        A
        C
        >>> t = BinaryTreeLeftyNode('A', BinaryTreeLeafNode('B'))
        >>> for n in t.inorder(): print n
        B
        A
        >>> t = BinaryTreeRightyNode('A', BinaryTreeLeafNode('B'))
        >>> for n in t.inorder(): print n
        A
        B
        >>> t = BinaryTreeLeafNode('A')
        >>> for n in t.inorder(): print n
        A
        >>> t = BinaryTreeNullNode()
        >>> for n in t.inorder(): print n
        """
        for n in self.left.inorder():
            yield n
        yield self.element
        for n in self.right.inorder():
            yield n

    def levelorder(self):
        """Generates a level-order traversal of the tree rooted at this node.
        
        >>> t = BinaryTreeNode('A', BinaryTreeLeafNode('B'), BinaryTreeLeafNode('C'))
        >>> for n in t.levelorder(): print n
        A
        B
        C
        >>> t = BinaryTreeLeftyNode('A', BinaryTreeLeafNode('B'))
        >>> for n in t.levelorder(): print n
        A
        B
        >>> t = BinaryTreeRightyNode('A', BinaryTreeLeafNode('B'))
        >>> for n in t.levelorder(): print n
        A
        B
        >>> t = BinaryTreeLeafNode('A')
        >>> for n in t.levelorder(): print n
        A
        >>> t = BinaryTreeNullNode()
        >>> for n in t.levelorder(): print n
        """
        queue = _LevelOrderQueue(self)
        return queue
    
    def _get_internal_children(self):
        return self.left._internal_node() + self.right._internal_node()

    def _internal_node(self):
        return [self]
    
    def __str__(self):
        return '(' + self.element + ')'

class BinaryTreeNullNode:
    """An external binary tree node.
    
    External tree nodes have no element and no children."""
    def preorder(self):
        return BinaryTreeNullNode._EmptyIterable()

    postorder = inorder = levelorder = preorder
    
    def _get_internal_children(self):
        return []

    def _internal_node(self):
        return []

    def __str__(self):
        return '[]'
    
    class _EmptyIterable:
        def __iter__(self):
            return self
        def next(self):
            raise StopIteration
    
# Adds an class attribute with the null node singleton:
BinaryTreeNullNode.instance = BinaryTreeNullNode()

# -----------------------------------------------------------------------------
# These utility subclasses make manual construction of trees slightly more
# user friendly.  They aren't necessary for the assignment.
class BinaryTreeLeafNode(BinaryTreeNode):
    """A childless binary tree node."""
    def __init__(self, element):
        BinaryTreeNode.__init__(self, element, 
                                BinaryTreeNullNode.instance, 
                                BinaryTreeNullNode.instance)


class BinaryTreeLeftyNode(BinaryTreeNode):
    """A binary tree node with just a left child."""
    def __init__(self, element, left_subtree):
        BinaryTreeNode.__init__(self, element, left_subtree, 
                                BinaryTreeNullNode.instance)


class BinaryTreeRightyNode(BinaryTreeNode):
    """A binary tree node with just a right child."""
    def __init__(self, element, right_subtree):
        BinaryTreeNode.__init__(self, element, BinaryTreeNullNode.instance, 
                                right_subtree)

# -----------------------------------------------------------------------------
# Helper classes
class _LevelOrderQueue:
    """A queue for level-order traversals of BinaryTreeNodes.
    
    This queue implements an iterator that enqueues the children of the head
    tree node in the queue, then returns the head element of the node.  By 
    enqueueing the root of a tree, then iterating over the queue, we get a 
    level-order traversal.
    """
    def __init__(self, tree_node):
        self.tail = _QueueTail()
        self.head = self.enqueue(tree_node)
        
    def enqueue(self, tree_node):
        item = _QueueItem(tree_node, self.tail, self)
        self.tail.add_previous(item)
        return item
        
    def __iter__(self):
        return self
    
    def next(self):
        result, self.head = self.head.next_helper()
        return result
    
    def __str__(self):
        return '<' + str(self.head)
    
class _QueueTail:
    def __init__(self):
        self.previous_item = self
        
    def next_helper(self):
        """Stops the iteration when the tail of the queue is reached."""
        raise StopIteration
    
    def add_previous(self, previous_item):
        """Makes room in the queue for the given item."""
        self.previous_item.set_next_item(previous_item)
        self.previous_item = previous_item
        
    def set_next_item(self, ignored):
        pass
    
    def __str__(self):
        return '>'
    
class _QueueItem:
    def __init__(self, tree_node, next_item, containing_queue):
        self.tree_node = tree_node
        self.next_item = next_item
        self.containing_queue = containing_queue

    def next_helper(self):
        """Enqueues all the internal children of the node at the head of this
        queue, then returns the element of the head node plus the the next item
        in the queue.
        """
        for n in self.tree_node._get_internal_children():
            self.containing_queue.enqueue(n)
        return self.tree_node.element, self.next_item
    
    def set_next_item(self, next_item):
        self.next_item = next_item
    
    def __str__(self):
        return str(self.tree_node.element) + ',' + str(self.next_item)

# -----------------------------------------------------------------------------
if __name__ == '__main__':
    doctest.testmod()
    
    # Test exceptions
    try:
        build_tree('A','')
    except ValueError:
        # Expected
        pass
    else:
        print 'No exception when building tree from uneven traversal lengths.'
        
    try:
        build_tree('ABCD','CDAB')
    except ValueError:
        # Expected
        pass
    else:
        print 'No exception when building impossible tree.'
        
    
