#This program draws a pizza with n number of slices, a polygon inscribed in a circle, a star inscribed ina circle
#Written by David Pick
from graphics import *
from math import *

def main():
    win = GraphWin("", 400, 350)
    pizza(win, Point(50, 50), 40, 10)
    pizza(win, Point(150, 50), 45, 3)
    star(win, Point(250, 50), 35, 7, 3)
    polygon(win, Point(100, 200), 75, 7)
    star(win, Point(300, 200), 100, 17, 5)
    win.getMouse()
    win.close()

def pizza(win, center, radius, numslices):
    #draw circle
    pizza = Circle(center, radius)
    pizza.draw(win)
    
    #Draw Slices
    for i in range(numslices):
        x = int(pizza.getCenter().getX() + radius * cos((2*pi*i)/numslices))
        y = int(pizza.getCenter().getY() + radius * sin((2*pi*i)/numslices))
        slice = Line(center, Point(x, y))
        slice.draw(win)
        
def polygon(win, center, radius, numsides):
    #Get number of sides
    circle = Circle(center, radius)
    circle.draw(win)
    points = []
    #load points into an array and draw polygon
    for i in range(numsides):
        x = int(circle.getCenter().getX() + radius * cos((2*pi*i)/numsides))
        y = int(circle.getCenter().getY() + radius * sin((2*pi*i)/numsides))
        points = points + [Point(x, y)]
        #poly = Polygon(points)
    poly = Polygon(points)
    poly.draw(win)
    
def star(win, center, radius, numpoints, skip):
    #win = GraphWin('Star in Circle' , 500, 500)
    circle = Circle(center, radius)
    circle.draw(win)
    points = []
    #Create array and add points into it
    for i in range(numpoints):
        x = int(circle.getCenter().getX() + radius * cos((2*pi*i)/numpoints))
        y = int(circle.getCenter().getY() + radius * sin((2*pi*i)/numpoints))
        points = points + [Point(x, y)]
    #Draw lines skipping every other one
    temppoint = points[numpoints-skip]
    tline = Line(points[0], temppoint)
    tline.draw(win)
    temppoint = points[numpoints-(skip - 1)]
    for i in range(1,numpoints):
        templine = Line(points[i], temppoint)
        templine.draw(win)
        temppoint = points[i-(skip - 1)]
        
main()