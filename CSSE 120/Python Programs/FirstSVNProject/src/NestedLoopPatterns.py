from zellegraphics import *
import time

# CONSIDER: Your code works perfectly.
# CONSIDER: Please comment your code.

def rectangleOfStars(numRows, numCols):
    for i in range(numRows):
        line = ''
        for j in range(numCols):
            line = line + "*"
        print line
    print

def triangleOfStars(rows):
    for i in range(rows):
        print "*" * (i + 1)
    print

def triangleSameNumEachRow(numRows):
    for i in range(numRows + 1):
        print str(i) * i
    print
    
def triangleAllNumsEachRow(rows):
    for i in range(rows):
        line = ''
        for j in range(i + 1):
            line = line + str(j + 1)
        print line
    print
        
def triangleNumsRightJustified(rows):
    for i in range(rows + 1):
        spaces = " " * (rows - i)
        for j in range(i + 1):
            line = spaces + str(j) * (i)
        print line

    
def triangleNumsCentered(rows):
    for i in range(rows + 1):
        spaces = " " * (rows - i)
        for j in range(i + 1):
            line = spaces + (str(j) + " ") * (i)
        print line

 
def numbersConstantForward(rows, nums, occurrencesOFEachNumber):  
    for i in range(rows):
        line = ''
        for j in range(nums):
            line = line + str(j + 1) * occurrencesOFEachNumber
        print line


def numbersConstantBackward(rows, nums, occurrencesOFEachNumber):  
    for i in range(rows):
        line = ''
        for j in range(nums):
            line = line + str((nums + 1) - (j + 1)) * occurrencesOFEachNumber
        print line
        
def numbersIncreasingForward(rows, nums):
    for i in range(rows):
        line = ''
        for j in range(nums + 1):
            line = line + str(j) * j
        print line
   
   
def brickPyramid(n):
    win = GraphWin("Pyrimade of Triangles", 500, 500)
    x1 = 200
    x2 = 230
    y1 = 260
    y2 = 230
    
    for i in range(1,n):
        x1 = 200 - (i * 15)
        x2 = 230 - (i * 15)
        for j in range(1, i):
            brick = Rectangle(Point(x1, y1), Point(x2, y2))
            brick.draw(win)
            x1 = x1 + 30
            x2 = x2 + 30
        y1 = y1 + 30
        y2 = y2 + 30
    win.getMouse()
    win.close()
            
     

def main():
    rectangleOfStars(4, 11)
    rectangleOfStars(7, 11)
    rectangleOfStars(3, 10)
    triangleOfStars(6)
    triangleOfStars(5)
    triangleOfStars(9)
    triangleSameNumEachRow(7)
    triangleSameNumEachRow(8)
    triangleSameNumEachRow(3)
    triangleAllNumsEachRow(6)
    triangleAllNumsEachRow(3)
    triangleAllNumsEachRow(9)
    triangleNumsRightJustified(8)
    triangleNumsRightJustified(6)
    triangleNumsRightJustified(7)
    triangleNumsCentered(9)
    triangleNumsCentered(4)
    triangleNumsCentered(6)
    numbersConstantForward(4, 7, 3)
    numbersConstantForward(4, 9, 2)
    numbersConstantForward(5, 7, 3)
    numbersConstantBackward(4, 7, 3)
    numbersConstantBackward(5, 9, 4)
    numbersConstantBackward(6, 6, 2)
    numbersIncreasingForward(5, 6)
    numbersIncreasingForward(3, 7)
    numbersIncreasingForward(6, 4)
    brickPyramid(9)
    brickPyramid(7)
    brickPyramid(6)
    
main()