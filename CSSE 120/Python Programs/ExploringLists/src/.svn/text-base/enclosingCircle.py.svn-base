# Draws the smallest circle that encloses a list of points
# By David Pick

from graphics import *
from Button import *
from math import *

WIN_HEIGHT = 400
WIN_WIDTH = 500
pointList = []
win = GraphWin("Smallest Enclosing Circle", WIN_HEIGHT, WIN_WIDTH)
b1 = Button(win, "Draw Circle", Point(150, 300), 20, 10)
b1.enable() 
b2 = Button(win, "Exit", Point(350, 300), 20, 10)  
b2.enable() 

def drawEnclosingCircle(center, radius):
    """Uses the center point (center) and radius of the enclosing circle to 
    draw the circle.  Display the center poing so that it looks different from
    all other points"""
    circle = Circle(center, radius)
    circle.draw(win)
def smallestEnclosingCircle(plist):
    """returns the center and radius of the smallest circle that has one
    of the points in plist (the list of points) as its center, and all of 
    the points in plist on its boundary or in its interior.  """
    # TO DO: complete this function, change the return statement to reflect what
    # what needs to be returned.
    maxpoint = pointList[0]
    Distance1 = 0
    Distance2 = 0
    for i in pointList:
        for j in pointList:
            if distance(i, j) > Distance1:
                maxpoint1 = i
                maxpoint2 = j
                Distance1 = distance(i, j)

    Xcenter = (maxpoint1.getX() + maxpoint2.getX()) / 2
    Ycenter = (maxpoint1.getY() + maxpoint2.getY()) / 2
    centerpoint = None
    radius = 0
    Distance2 = Distance1
    for i in pointList:
        if distance(i, Point(Xcenter, Ycenter)) < Distance2:
            centerpoint = i
            Distance2 = distance(i, Point(Xcenter, Ycenter))
            radius = (Distance1 / 2) + Distance2
    return centerpoint, radius
    
def collectPoints(plist):
    """Accumulates and displays the point returned by each mouse click in a  
    list plist.  Exits when either button b1 or button b2 is clicked. Note: 
    the point returned when either of these buttons is clicked is not drawn 
    or accumulated"""
    while True:
        p = win.getMouse()
        if b1.clicked(p):
            b1.disable()
            center, radius = smallestEnclosingCircle(plist)
            drawEnclosingCircle(center, radius)
            # TO DO: call the appropriate function to draw the smallest enclosing circle
            break
        elif b2.clicked(p):
            break
        else:
            # DO DO: Add the point to the list of points
            # TO DO: Display the point
            print "clicked"
            pointList.append(p)
            p.draw(win)
            print p.getX(), p.getY()

def distance(p1, p2):
    """return the distance between p1 and p2"""
    xDist = p1.getX() - p2.getX()
    yDist = p1.getY() - p2.getY()
    return sqrt(xDist*xDist + yDist*yDist)

def farthestPoint(pointList, p):  
    """return the point in pointList that is farthest from point p """
    maxDistance = 0
    maxPoint = None
    for i in pointList:
        if distance(Point(i.getX(), i.getY()), Point(p.getX(), p.getY())) < maxDistance:
            maxPoint = maxPoint
        else:
            maxPoint = i.getX(), i.getY()
    return maxPoint
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

def main():
    collectPoints(pointList)  
    p = win.getMouse()  
    if b2.clicked(p):  
        win.close()
    
if __name__ == '__main__':
    main()    