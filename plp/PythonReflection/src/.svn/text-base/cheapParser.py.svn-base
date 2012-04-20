'''
This is a really quick and dirty parser for expressions.
by Curt Clifton, Sep 20, 2009
'''
from expression import *

def parse(e):
    '''Takes a space-delimited, post-fix expression as a string and returns 
    an Expression object.
    
    There's no error checking.  Get the syntax right or suffer the consequences.
    '''
    stack = []
    for p in e.split(' '):
        if p == '+':
            right = stack.pop()
            left = stack.pop()
            stack.append(Add(left,right))
        elif p == '<':
            right = stack.pop()
            left = stack.pop()
            stack.append(LT(left,right))
        elif p == 'if':
            alt = stack.pop()
            cons = stack.pop()
            cond = stack.pop()
            stack.append(If(cond,cons,alt))
        elif p == 't':
            stack.append(BoolLiteral(True))
        elif p == 'f':
            stack.append(BoolLiteral(False))
        else:
            # assume it's a integer, since that's all that remains
            stack.append(IntLiteral(int(p)))
    return stack[0]