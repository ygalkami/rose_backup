"""
Demonstrates overriding of dispatch behavior to solve the expression problem.

Based on a design by Jonathan Woodworth.
by Curt Clifton, Sep 21, 2009
"""
import cheapParser
import expression

class Visitor(object):
    """
    Provides a default implementation of visitor that can be extended
    to implement new operations.
    """
    def __call__(self, expression, *args, **kwargs):
        """
        Applying a visitor class, or subclass, to an expression causes
        a call-back to the visitor object method with the same name as
        the expression object's class.
        
        Variable arity 'args' and keyword arguments, 'kwargs', allow subclasses
        to pass along auxiliary data.
        """
        return self._dispatch(expression)(self, expression, *args, **kwargs)
    def _dispatch(self, expression):
        """
        Looks for a method defined on the class of self (typically defined 
        in a subclass) with the name kind.  Returns that unbound method.
        """
        kind = expression.__class__
        visitorDict = self.__class__.__dict__
        ## CONSIDER: This doesn't allow "inheritance" of implementation, but it
        # could if we checked kind.__base__ until match
        # was found.
        if kind.__name__ in visitorDict:
            return visitorDict[kind.__name__]
        else:
            self._default(kind.__name__)
    def _default(self, kind):
        """
        If a visitor subclass tries to process an expression kind for
        which it defines no handler, then this method will be invoked.
        """
        raise Exception('%s: no case for %s' % (self.__class__.__name__, kind))

class PrettyPrinter(Visitor):
    # CONSIDER: Have to define IntLiteral and BoolLiteral separately, even though
    # code is the same, because inherited _dispatch method doesn't consider 
    # hierarchy.
    def IntLiteral(self, exp):
        return exp.value
    def BoolLiteral(self, exp):
        return exp.value
        

eStrs = []
eStrs.append('3')
eStrs.append('t')
eStrs.append('f')
eStrs.append('3 4 +')
eStrs.append('3 4 <')
eStrs.append('4 3 <')
eStrs.append('3 4 + 35 +')
eStrs.append('3 4 35 + +')
eStrs.append('3 4 + 35 + 41 <')
eStrs.append('3 4 + 35 + 43 <')
eStrs.append('3 4 < 0 1 if')
eStrs.append('4 3 < 0 1 if')
es = map(cheapParser.parse, eStrs)

pp = PrettyPrinter()
for e, s in zip(es, eStrs):
    print s, "<==>", pp(e)
