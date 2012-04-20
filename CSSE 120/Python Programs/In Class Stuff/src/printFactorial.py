def printFactorial(n, width):
    formatString = "%"+str(width)+"d"
    product = 1
    for i in range(1, n+1):
        product = product * n
    print formatString % (product)
    
# Single uses:
printFactorial(5, 6)
printFactorial(15, 20)

# make a table
print "FACTORIAL TABLE"

for i in range(15):
    print "%2d" % (i),
    printFactorial(i,13)
    
print "FACTORIAL TABLE WITH FUNCTION"

def factTable(max, nWidth, factWidth):
    formatString = "%" + str(nWidth) + "d"
    for n in range(max):
        print formatString % (n),
        printFactorial(n, factWidth)

factTable(22, 2, 21)