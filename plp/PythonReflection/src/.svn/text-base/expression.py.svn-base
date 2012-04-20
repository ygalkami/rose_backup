'''
Example of the expression problem.
by Curt Clifton, Sep 20, 2009.
'''

# Quick and dirty enumeration:
INT, BOOL = range(2)

class Expression(object):
    def eval(self):
        'Evaluates this expression.' 
        raise NotImplementedError('not implemented')
    def typecheck(self):
        'Type checks this expression, returning its type, or raising an exception.'
        raise NotImplementedError('not implemented')
    def accept(self, visitor):
        '''Calls back to the appropriate method of the given visitor, depending of the
        sort of expression this is.'''
        raise NotImplementedError('not implemented')

class Literal(Expression):
    def __init__(self, value, exemplar):
        if type(value) != type(exemplar):
            raise ValueError("Trying to create a literal with an argument of the wrong type")
        self.value = value
    def eval(self):
        return self.value
    def accept(self, visitor):
        return visitor.Literal(self)
    
class IntLiteral(Literal):
    def __init__(self, value):
        Literal.__init__(self, value, 0)
    def typecheck(self):
        return INT

class BoolLiteral(Literal):
    def __init__(self, value):
        Literal.__init__(self, value, True)
    def typecheck(self):
        return BOOL

class If(Expression):
    def __init__(self, cond, cons, alt):
        self.cond = cond
        self.cons = cons
        self.alt = alt
    def eval(self):
        if self.cond.eval():
            return self.cons.eval()
        else:
            return self.alt.eval()
    def typecheck(self):
        if self.cond.typecheck() != BOOL:
            raise TypeError('condition not a boolean')
        t = self.cons.typecheck()
        if t != self.alt.typecheck():
            raise TypeError('two branches of if are of different types')
        return t 
    def accept(self, visitor):
        return visitor.If(self)


class BinaryOp(Expression):
    def __init__(self, left, right):
        self.left = left
        self.right = right

class Add(BinaryOp):
    def __init__(self, left, right):
        BinaryOp.__init__(self, left, right)
    def eval(self):
        return self.left.eval() + self.right.eval()
    def typecheck(self):
        if self.left.typecheck() != INT or self.right.typecheck() != INT:
            raise TypeError('both arguments for addition must be ints')
        return INT
    def accept(self, visitor):
        return visitor.Add(self)
    
class LT(BinaryOp):
    def __init__(self, left, right):
        BinaryOp.__init__(self, left, right)
    def eval(self):
        return self.left.eval() < self.right.eval()
    def typecheck(self):
        if self.left.typecheck() != INT or self.right.typecheck() != INT:
            raise TypeError('both arguments for less than must be ints')
        return BOOL
    def accept(self, visitor):
        return visitor.LT(self)
        

