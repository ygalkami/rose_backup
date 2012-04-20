# Examples involving lists 
# Session 16 of CSSE 120
# By <name1> and <name2>

# modules imported
from graphics import *
import time
import math

# color list generation
colorList = [color_rgb(r,0,255-r) for r in range (0,255,2)] + \
            [color_rgb(255-r,r,0) for r in range (0,255,2)] + \
            [color_rgb(r,255-r,r) for r in range (0,255,2)] + \
            [color_rgb(255,r,255-r) for r in range (0,255,2)]  
            
window = GraphWin("Examples with list", 950, 600)            

def moveAllElementsBy(list, dx, dy):
   for obj in list:
      obj.move(dx, dy) 

def colorAll(list, color):
   for obj in list:
      obj.setFill(color)

def moveThoseColors(win):
   rectList = []
   for i in range(5):
      rect = Rectangle(Point(i*50, 10), Point(i*50+40, 50))
      rect.draw(win)
      rectList.append(rect)

   for c in colorList:
      time.sleep(.02)
      moveAllElementsBy(rectList, 1, 1)
      colorAll(rectList, c)
   time.sleep(1)

def doubleAll(list):
    """ returns a list of numbers that are twice 
    those in the original list. """
    result = []
    for i in list:
        result.append(i * 2)
    return result

def doubleAllToo(list):
   def double(n):
      return n*2
   return map(double, list)

def largestInList(numlist):  # A nonempty list of numbers
    """ returns the largest number in list numList. """
    largestSoFar = numlist[0]
    #print str(numlist) + " Start of problem area"
    for i in range(len(numlist)):
        if largestSoFar > numlist[i]:
            largestSoFar = largestSoFar
        else:
            largestSoFar = numlist[i]
    return largestSoFar

def secondLargest(numList): # numList contains at least 2 numbers, all different
    """ returns the second largest number in list numList. """  
    print numList  
    largest = second = numList[0]
    for i in numList:
        if largest > i:
            largest = largest
        else:
            largest = i
    
    numList.remove(largest)
    
    return largestInList(numList)


  
def distance (p1, p2):
    """return the distance between p1 and p2"""
    xDist = p1.getX() - p2.getX()
    yDist = p2.getY() - p2.getY()
    return math.sqrt(xDist*xDist + yDist*yDist)

def farthestPoint(pointList, p):  
    """return the point in pointList that is farthest from point p """
    maxDistance = 0
    maxPoint = None
    for i in pointList:
        if maxPoint > i.getX() and maxPoint > i.getY():
            maxPoint = maxPoint
        else:
            maxPoint = i.getX(), i.getY()
    return maxPoint
  
   
def main():
    #moveThoseColors(window)
#    print doubleAll([3, 4, 5, 0, 1, 2])
#    print doubleAllToo([3, 4, 5, 0, 1, 2])
#    print "Largest integer is %d" % (largestInList([3, 5, 8, 2, 1, 7, 4, 6]))   
#    print "Largest integer is %d" % (largestInList([-1, -6, -5, -3, -2]))
    print "Second Largest is %d" % (secondLargest([3, 5, 8, 2, 1, 7, 4, 6]))
    
    p = farthestPoint([Point(4, 7), Point(5, 6), Point(-1, 3), Point(6, 1)], Point(2,2))
    if p == None:
        print p
    else:
        print "(",p.getX(), ",", p.getY(),")"
    p = farthestPoint([], Point(2,2))
    if p == None:
        print p
    else:
        print "(",p.getX(), ",", p.getY(),")"    
    
    # close window after mouse clicked and exit program
    window.getMouse()
    window.close()
    exit()
    
    
if __name__ == "__main__":
    main()

   
