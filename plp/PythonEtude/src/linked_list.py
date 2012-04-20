# ----------------------------------------------------------------
# Linked List
# by Curt Clifton, March 2008
# ----------------------------------------------------------------
import doctest

def build_list(str):
    """Builds a doubly linked list from the given string, one character per
    node.

    >>> l = build_list('ABC')
    >>> for n in l.forward(): print n
    A
    B
    C
    >>> for n in l.reverse(): print n
    C
    B
    A
    """
    result = List()
    for c in str:
        result.add_tail(c)
    return result

class List:
    def __init__(self):
        self.head = _ListHeadNode()
        self.tail = _ListTailNode()
        self.head.set_next(self.tail)
        self.tail.set_previous(self.head)
    def add_head(self, element):
        self.head.add_element(element)
    def add_tail(self, element):
        self.tail.add_element(element)
    def forward(self):
        return self.head.forward()
    def reverse(self):
        return self.tail.reverse()

class _ListHeadNode:
    def set_next(self, node):
        self.next = node
    def add_element(self, element):
        node = _InternalListNode(element, self.next, self)
        self.next.previous = node
        self.next = node
    def forward(self):
        for n in self.next.forward():
            yield n
    def reverse(self):
        raise StopIteration

class _ListTailNode:
    def set_previous(self, node):
        self.previous = node
    def add_element(self, element):
        node = _InternalListNode(element, self, self.previous)
        self.previous.next = node
        self.previous = node
    def forward(self):
        raise StopIteration
    def reverse(self):
        for n in self.previous.reverse():
            yield n

class _InternalListNode:
    def __init__(self, element, next, previous):
        self.element = element
        self.next = next
        self.previous = previous
    def forward(self):
        yield self.element
        for n in self.next.forward():
            yield n
    def reverse(self):
        yield self.element
        for n in self.previous.reverse():
            yield n

if __name__ == '__main__':
    doctest.testmod()
