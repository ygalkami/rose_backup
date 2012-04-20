#This program draws a pizza with n number of slices
#Written by David Pick
from graphics import *
from math import *

def pizza(center, radius, numslices):
    win = GraphWin()
    pizza = Circle(center, radius)
    pizza.draw(win)
    
    for i in range(numslices)
        x = int(100 + 70 * cos((2*pi*i)/numslices))
        y = int(100 + 70 * sin((2*pi*i)/numslices))
        slice = Line(center, Point(x, y))
        slice.draw(win)