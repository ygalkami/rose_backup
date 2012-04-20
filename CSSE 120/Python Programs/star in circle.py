#This program creates a star with n number of points inscribed in a circle
#Written by David Pick
from graphics import *
from math import *

def main():
    #Get number of points
    numpoints = input("Enter an odd integer N that is at least 3: ")
    win = GraphWin('Star in Circle' , 500, 500)
    circle = Circle(Point(100, 100), 70)
    circle.draw(win)
    points = []
    #Create array and add points into it
    for i in range(numpoints):
        x = int(100 + 70 * cos((2*pi*i)/numpoints))
        y = int(100 + 70 * sin((2*pi*i)/numpoints))
        points = points + [Point(x, y)]
    #Draw lines skipping every other one
    temppoint = points[numpoints-2]
    tline = Line(points[0], temppoint)
    tline.draw(win)
    temppoint = points[numpoints-1]
    for i in range(1,numpoints):
        templine = Line(points[i], temppoint)
        templine.draw(win)
        temppoint = points[i-1]
main()
