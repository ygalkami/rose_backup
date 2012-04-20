# This sample file demonstrates some scope issues.

top_level_data = {'Cat' : "I'm in ur office urning ur salry.", 
                  'Walrus' : "Where's my bucket?" }

# Top level code in module refers top_level_data
print 'The cat says, "%(Cat)s"' % top_level_data
top_level_data['Dog'] = 'Oh Hai, I fixted ur pilloh.'
print 'The dog says, "%(Dog)s"' % top_level_data
print

x = 42

# Assignments in nested scopes create "shadows".
def fn1():
    x = 10
    print "x in fn1:", x
    
print "x before:", x
fn1()
print "x after:", x
print

# If there is no local variable, then search 
# goes into outer scope.
def fn2():
    print "x in fn2:", x
    
print "x before:", x
fn2()
print "x after:", x
print

# If we assign to a variable anywhere in function, then 
# all reference to that variable in the function are assumed
# to be to the shadowing local variable.
def fn3():
    print "x in fn3:", x  # <-- Error!    
    x = 15
    print "x in fn3:", x
    
print "x before:", x
fn3()
print "x after:", x
print

# Mutating a top-level variable is not the same as assigning to it!
def fn4():
    top_level_data['Elephant'] = "I needs 2 top off mah tank."
    
fn4()
print 'The elephant says, "%(Elephant)s"' % top_level_data
print
