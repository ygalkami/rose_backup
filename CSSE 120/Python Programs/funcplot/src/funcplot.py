#This program plots points from a file
#Written by David Pick

from graphics import *

win = GraphWin('Plot a Function', 720, 400)
filename = raw_input("Enter a filename to open: ")
#Open specififed file
file = open(filename + ".txt", 'r')

for i in range(720):
    #read lines
    curline = file.readline()
    x = int(curline[:3])
    y = eval(curline[9:16])
    #plot points
    dot = Point(x, y)
    dot.draw(win)