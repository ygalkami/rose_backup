class T:
    """True"""
    def _and(self, other):
        return other
    
    def _or(self, other):
        return self
    
    def _not(self):
        return F()
    
    def _if(self, consequent, alternate):
        return consequent()
    
    def __str__(self):
        return "True"
    
class F:
    """False"""
    def _and(self, other):
        return self
    
    def _or(self, other):
        return other
    
    def _not(self):
        return T()
    
    def _if(self, consequent, alternate):
        return alternate()
    
    def __str__(self):
        return "False"
    
if __name__ == '__main__':
    t, f = T(), F()
    
    print "Testing and: "
    print t._and(t)
    print t._and(f)
    print f._and(t)
    print f._and(f)
    print
    
    print "Testing or: "
    print t._or(t)
    print t._or(f)
    print f._or(t)
    print f._or(f)
    print
    
    print "Testing not: "
    print t._not()
    print f._not()
    print
    
    def thenPart():
        print "then part"
    
    def elsePart():
        print "else part"
        
    t._if(thenPart, elsePart)
    f._if(thenPart, elsePart)
    
    print "Testing conditions"
    t._or(t)._and(f)._if(thenPart, elsePart)