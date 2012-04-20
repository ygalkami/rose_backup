from boolean import *

class Nat:    """Models natural numbers"""
    def __init__(self, p):
        self._pred = p
    def succ(self):
        return Nat(self)
    def pred(self):
        return self._pred
    def add(self, other):
        return self.pred().add(other.succ())
    def lt(self, other):
        return self._pred.lt(other.pred())
    def isZero(self):
        return F()
    def __str__(self):
        return "|" + str(self.pred())
    
class Zero(Nat):
    def __init__(self):
        pass
    def pred(self):
        return self
    def add(self, other):
        return other
    def lt(self, other):
        return other.isZero()._not()
    def isZero(self):
        return T()
    def __str__(self):
        return ""

if __name__ == '__main__':
    zero = Zero()
    one = zero.succ()
    two = one.succ()
    three = two.succ()
    print "1 + 2: ", one.add(two)
    print "2 + 3: ", two.add(three)
    print "2 - 3: ", two.lt(three)