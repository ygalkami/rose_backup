#This program creates a polygon with n number of sides inscribed in a circle
from graphics import *
from math import *

def main():
    #Get number of sides
    numpoints = input("Enter an odd integer N that is at least 3: ")
    win = GraphWin('Polygon in Circle' , 500, 500)
    circle = Circle(Point(100, 100), 70)
    circle.draw(win)
    points = []
    #load points into an array and draw polygon
    for i in range(numpoints):
        x = int(100 + 70 * cos((2*pi*i)/numpoints))
        y = int(100 + 70 * sin((2*pi*i)/numpoints))
        points = points + [Point(x, y)]
        #poly = Polygon(points)
    poly = Polygon(points)
    poly.draw(win)
main()
