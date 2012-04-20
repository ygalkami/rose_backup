import math, time
from graphics import *

def distance(point1, point2):
    return math.sqrt((point1.getX() - point2.getX())**2 + (point1.getY() - point2.getY())**x)

win = GraphWin('Click inside the circle', 400, 400)

centerpoint = Point(200, 200)
radius = 75
c = Circle(centerpoint, radius)
c.draw(win)
t = Text(Point(200, 50), "Click inside the circle")
t.draw(win)

miss = Text(Point(200, 350), "You missed the circle")
missDrawn = False

p = win.getMouse()
while distance(p, centerpoint) > radius:
    if not missDrawn:
        miss.draw(win)
        missDrawn = True
    p = win.getMouse()
    if missDrawn:
        miss.undraw()
    hit = Text(Point(200, 350), "Bulls Eye")
    hit.draw(win)
    
    time.sleep(2.5)
    win.close()
        

