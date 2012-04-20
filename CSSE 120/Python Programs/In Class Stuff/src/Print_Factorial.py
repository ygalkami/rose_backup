def printfactorial(n, width):
    formatString = "%" + str(width) + "d"
    product = 1
    for i in range(1, n+1):
        product = product * i
    
    print formatString % (product)
    
#for i in range(15):
#    print "%2d" % (i),
#    printfactorial(i, 13)
    
def facttable(max, nwidth, factwidth):
    formatString = "%" + str(nwidth) + "d"
    
    for n in range(max):
        print formatString % (n),
        printfactorial(n, factwidth)
        
        
facttable(22, 2, 21)