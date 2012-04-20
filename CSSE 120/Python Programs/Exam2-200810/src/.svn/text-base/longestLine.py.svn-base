# Your assignment is to fill in the details of the drawPointsAndLongestLine function

from graphics import *
import math

WIN_HEIGHT = 500
WIN_WIDTH = 500
CIRCLE_RADIUS = 6
pointList = []

# from a previous assignment
def distance (p1, p2):
	"""return the distance between p1 and p2"""
	xDist = p1.getX() - p2.getX()
	yDist = p1.getY() - p2.getY()
	return math.sqrt(xDist*xDist + yDist*yDist)

# from a previous assignment.  But now it returns a list: a point and a distance 
def farthestPointAndDistance(pointList, p):  
	"""return the point in pointList that is farthest from point p, and the max distance """
	maxDistance = 0
	maxPoint = None
 	for pt in pointList:
		dist = distance(p, pt)
		if dist > maxDistance:
			maxPoint = pt
			maxDistance = dist
	return maxPoint, maxDistance


def drawPointsAndLongestLine(win, pointList):
	"""draws all of the points in the pointList, and the longest line between two of the points."""
	for i in pointList:
		cir = Circle(i, 20)
		cir.draw(win)
	maxdistance = 0
	for i in pointList:
		for j in pointList:
			if distance(i, j) > maxdistance:
				maxdistance = distance(i, j)
				point1 = i
				point2 = j
				point1X = i.getX()
				point1Y = i.getY()
				point2X = j.getX()
				point2Y = j.getY()
	line = Line(Point(point1X, point1Y), Point(point2X, point2Y))
	line.draw(win)
	#print i.getX(), j.getX()
	
def main():
	pointLists = [[Point(40, 30), Point(300, 26), Point(300,400), Point(450, 175) ], \
				  [Point(20*i, i*i/2 + 10) for i in range(1,25)] + \
				  [Point(20*i, 20*i+20) for i in range(22, 0, -1) ], \
				  [Point(20*i, i*i/2 + 10) for i in range(1,25)] + \
				  [Point(20*i, 20*i+20) for i in range(1,23) ], \
				  [Point(20*i, i*i/2 + 10) for i in range(1,25)] + \
				  [Point(20*i, 20*i+20) for i in range(1,20) ] \
				  ]
 	print "After the display of each window, click in that winhdow to see the next window"
 	for pointList in pointLists:
 		win = GraphWin("Longest Line", WIN_WIDTH, WIN_HEIGHT)
 		drawPointsAndLongestLine(win, pointList)
  		p = win.getMouse()  
  		win.close()
	
if __name__ == '__main__':
	main()	