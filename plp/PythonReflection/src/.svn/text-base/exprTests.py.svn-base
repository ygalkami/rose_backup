'''
Testing expressions.
by Curt Clifton, Sep 20, 2009
'''

import cheapParser
import expression

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

for e,s in zip(es,eStrs):
    print s, '==>', e.eval(), "of type", e.typecheck()
print

class PrettyPrinter(object):
    '''Pretty-prints an expression in Scheme notation.
    
    That is, returns a string in prefix notation with lots of parentheses.''' 
    def Literal(self, exp):
        return ''
    def If(self, exp):
        return ''
    def Add(self, exp):
        return ''
    def LT(self, exp):
        return ''
    
for e,s in zip(es,eStrs):
    print s, '<==>', e.accept(PrettyPrinter())
