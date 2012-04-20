# Examples for Session 15 class

from graphics import *
import time
import math


colorList = [color_rgb(r,0,255-r) for r in range (0,255,2)] + \
            [color_rgb(255-r,r,0) for r in range (0,255,2)] + \
            [color_rgb(r,255-r,r) for r in range (0,255,2)] + \
            [color_rgb(255,r,255-r) for r in range (0,255,2)]  

def moveAllElementsBy(list, dx, dy):
   for obj in list:
      obj.move(dx, dy) 

def colorAll(list, color):
   for obj in list:
      obj.setFill(color)

def moveThoseColors():
   win = GraphWin("", 950, 600)
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
   """ Returns a list of numbers that are twice those in the orioginal list."""
   return None

def doubleAllToo(list):
    return None

def largestInList(numList):  # A nonempty list of numbers
   """ Returns the largest number in the list."""
   return None

def secondLargest(numList): # numList contains at least 2 numbers, all different
   """ returns the second largest number in the list"""
   return None
 
def distance (p1, p2):
   xDist = p1.getX() - p2.getX()
   yDist = p2.getY() - p2.getY()
   return math.sqrt(xDist*xDist + yDist*yDist)

def farthestPoint(pointList, p):  
   """return the point in PointList that is farthest from point p"""
   return None
   

if __name__ == "__main__":
   # moveThoseColors()
   print doubleAll([3, 4, 5, 0, 1, 2])
   print doubleAllToo([3, 4, 5, 0, 1, 2])
   print largestInList([3, 5, 8, 2, 1, 7, 4, 6])   
   print largestInList([-1, -6, -5, -3, -2])
   p = farthestPoint([Point(4, 7), Point(5, 6), Point(-1, 3), Point(6, 1)], Point(2,2))
   if p == None:
      print p
   else:
      print "(", p.getX(), ",", p.getY(), ")"
   p = farthestPoint([], Point(2,2))
   if p == None:
      print p
   else:
      print "(", p.getX(), ",", p.getY(), ")"

   

   
