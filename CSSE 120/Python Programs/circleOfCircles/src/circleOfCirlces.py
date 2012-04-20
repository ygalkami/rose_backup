#This program creates a circle of circles
#Written by David Pick

from graphics import *
from math import *

def circleOfCircles(win, N, Bcenter, Bradius, Lradius):
    
    for i in range(N):
        #calculate center of little circles
        x = int(Bcenter.getX() + Bradius * cos((2*pi*i)/N))
        y = int(Bcenter.getY() + Bradius * sin((2*pi*i)/N))
        
        #draw little circles
        Lcircle = Circle(Point(x, y), Lradius)
        Lcircle.draw(win)
        