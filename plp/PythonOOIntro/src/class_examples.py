# Some examples of classes.

# Basic syntax
class ClassName:
    """Doc string."""
    # 0 or more additional statements
    
class Attrib:
    """Example of class attributes."""
    x, y = 2, 13
    
print "Attrib:", Attrib.x, Attrib.y

class AttribWithFunc:
    """Example adding fn attribute."""
    def fact(n):
        result = 1
        for i in xrange(1, n+1):
            result *= i
        return result

print "fact:", AttribWithFunc.fact
# print "Calling fact:", AttribWithFunc.fact(5) # <-- error

class MakeMe:
    """Example for instantiation."""
    def __init__(self, x):
        self._x = x
        
one = MakeMe(1)
two = MakeMe(2)
print "One-two punch:", one._x, two._x

class CountDown:
    def __init__(self, n):
        self._n = n
    def tick(self):
        self._n -= 1
        if self._n <= 0:
            print 'BOOM!'

counter = CountDown(5)
for i in xrange(8):
    counter.tick()