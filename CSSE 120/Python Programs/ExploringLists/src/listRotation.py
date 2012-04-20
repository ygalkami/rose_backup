# Integer list generation
#David Pick
listOfInt = [num for num in range (1,12,2)] 

left, right = 0, 1
top, bottom = 2, 3

def rotateFromRight(alist):
    """Rotates alist so that the rightmost element appears at the left end of 
    the list and the other elements are pushed toward the right end of the list"""
    temp = alist[-1]
    for i in range(len(alist) - 2, -1, -1):
        alist[i + 1] = alist[i]
    alist[0] = temp
    print alist

def rotateFromLeft(alist):
    """Rotates alist so that the leftmost element appears at the right end of 
    the list and the other elements are pushed toward the left end of the list"""
    temp = alist[0]
    for i in range(1, len(alist)):
        alist[i - 1] = alist[i]
        
    alist[len(alist)-1] = temp
    print alist
    
def rotateRow(alist, side):  
    """Rotates alist from side where side == left or side == right"""
    if side == left:
        rotateFromLeft(alist)
    elif side == right:
        rotateFromRight(alist)

        
def rotateAnyRow(alist, row, side):  
    """Rotates a given row of atable from side where side == left or side == right.
    row is given as an integer value. atable is a list of list of elements"""
    if side == left:
        temp = alist[row][0]
        for i in range(1, len(alist[row])):
            alist[row][i - 1] = alist[row][i]
        alist[len(alist[row])-1] = temp;
        #print alist
    elif side == right:
        temp = alist[row][-1]
        for i in range(len(alist[row]) - 2, -1, -1):
            alist[row][i + 1] = alist[row][i]
        alist[row][0] = temp
        #print alist
    return alist
        
  
        
def rotateFromTop(alist, col = 0):
    """Rotates a given column (col) of atable so that the topmost element 
    appears at the bottom of the column and the other elements are pushed toward
    the top of the column.  col is given as an integer value. atable is a list 
    of list of elements."""
    temp = alist[0][col]
    for i in range(1, len(alist)):
        alist[i - 1][col] = alist[i][col]
    alist[len(alist)-1][col] = temp;
    return alist
    
def rotateFromBottom(alist, col = 0):
    """Rotates a given column (col) of atable so that the bottommost element 
    appears at the top of the column and the other elements are pushed toward 
    the bottom of the column. col is given as an integer value. atable is a list 
    of list of elements."""
    temp = alist[-1][col]
    for i in range(len(alist) - 2, -1, -1):
        alist[i + 1][col] = alist[i][col]
    alist[0][col] = temp
   
        
def rotateAnyColumn(alist, col, side):  
    """Rotates a given column (col) of atable from side where side == top or 
    side == bottom.  col is given as an integer value. atable is a list 
    of list of elements."""
    if side == top:
        temp = alist[0][col]
        for i in range(1, len(alist)):
            alist[i - 1][col] = alist[i][col]
        alist[len(alist)-1][col] = temp;
    elif side == bottom:
        temp = alist[-1][col]
        for i in range(len(alist) - 2, -1, -1):
            alist[i + 1][col] = alist[i][col]
        alist[0][col] = temp
        

        
def genListOfList():
    """Generates a list of list of integers """
    LoL = [[num for num in range (1,12,2)],
           [num * 5 for num in range (1,12,2)],
           [num * num for num in range (1,12,2)],
           [-num for num in range (1,12,2)],
           [num * 2 for num in range (1,12,2)],
           [num /2 for num in range (1,12,2)]]
    return LoL
        
def printLoL(LoL):
    """Prints a list of lists in tabula form"""
    print
    for i in LoL:
        print i
            
def main():
    """ Uncomment the statements for the parts you 
    want to test: Use <Ctrl> + \ key combinations"""
    print "Original list of integers" 
    print listOfInt

    rotateFromRight(listOfInt)
    print "Just ran rotateFromRight()"
    print listOfInt

    rotateFromLeft(listOfInt)
    print "Just ran rotateFromLeft()"    
    print listOfInt

    rotateRow(listOfInt, right)
    print "Just ran rotateRow(listOfInt, right)"  
    print listOfInt 

    rotateRow(listOfInt, left)
    print "Just ran rotateRow(listOfInt, left)"  
    print listOfInt    

    listofIntList = genListOfList()
    print "Original list of list of integers" 
    printLoL(listofIntList)

    printLoL(rotateAnyRow(listofIntList, 5, right))
    print "Just ran rotateAnyRow(listofIntList, 5, right)"  
    #printLoL(listofIntList) 
    
    rotateFromTop(listofIntList)
    print "Just ran rotateFromTop(listofIntList)" 
    printLoL(listofIntList)  
  
    rotateFromBottom(listofIntList)
    print "Just ran rotateFromBottom(listofIntList)" 
    printLoL(listofIntList)

    rotateAnyColumn(listofIntList, 0, top)
    print "Just ran rotateAnyColumn(listofIntList, 0, top)" 
    printLoL(listofIntList)
    
if __name__ == "__main__":
    main()
