# A partial implementation of a binary tree class.
# by Curt Clifton, March 12, 2008

class BinaryTreeNode:
    def __init__(self, element, left=None, right=None):
        self.element = element
        self.left = left
        self.right = right
    
    def __iter__(self):
        """Returns a pre-order iterator on this tree."""
        return _BinaryTreePreOrderIterator(self)
    
    def preorder(self):
        """Returns a pre-order iterator for the tree rooted here."""
        yield self.element
        if self.left != None:
            for childNodeElement in self.left.preorder():
                yield childNodeElement
        if self.right != None:
            for e in self.right.preorder():
                yield e

class _BinaryTreePreOrderIterator:
    def __init__(self, node):
        self.stack = []
        self.stack.append(node)
            
    def next(self):
        if len(self.stack) == 0:
            raise StopIteration
        node = self.stack.pop()
        if node.right != None:
            self.stack.append(node.right)
        if node.left != None:
            self.stack.append(node.left)
        return node.element
            
if __name__ == '__main__':
    t = BinaryTreeNode('Curt', BinaryTreeNode('Jim', BinaryTreeNode('Francis'), BinaryTreeNode('Gladys')), BinaryTreeNode('Connie'))
    print "Preorder traversal using iterator:"
#    for n in t:
#        print n      
    for n in t.preorder():
        print n