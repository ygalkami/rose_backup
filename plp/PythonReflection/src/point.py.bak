'''
Some examples of mucking with class and object internals.
by Curt Clifton, Sep 20, 2009.
'''
class Point(object):
    def __init__(self, x, y):
        self.x = x
        self.y = y
    def __add__(self, other):
        return Point(self.x + other.x, self.y + other.y)
    def display(self):
        return '[%d,%d]' % (self.x, self.y)

def f(self):
    'This is a method that claims to be an F'
    print self.display() + ': This is an F'
    
def anotherF(self):
    "This method doesn't give an F."
    print self.display() + ': This is not an F'

def gWhiz(self):
    "Better the Cheez-whiz"
    print self.display() + ": g-pers"

if __name__ == '__main__':
    print 'Demonstrates the "stock" behavior of Point instances:'
    p1 = Point(5,7)
    print p1.display()
    p2 = p1 + p1
    print p1.display()
    print p2.display()
    print
    
    print 'Recall the difference between a class attribute method and an object attribute method:'
    print Point.display
    print p1.display
    print

    #print 'What happens when we muck with the attributes of the Point class?'
    #print
    
    #print 'Is the method added late any different?'
    #print

    #print 'Can we replace the method?'
    #print
    
    #print 'Can we replace a method on a single instance?'
    #print
    
