# This module uses the scope module with import:
import scope

# Having imported scope, we can access its "attributes" 
# using dot notation
print 'The walrus says, "%(Walrus)s"' % scope.top_level_data
print "scope's x is:", scope.x
print

# Top-level variables in this module don't shadow those in
# 'scope' because of the dot notation for accessing them.
x = 10
print "My x:", x
print "scope's x is:", scope.x
print

# For mutable objects, we can create local aliases.
top_level_data = {}
top_level_data['Walrus'] = "I has a cellular"
print 'The walrus says, "%(Walrus)s"' % scope.top_level_data
print