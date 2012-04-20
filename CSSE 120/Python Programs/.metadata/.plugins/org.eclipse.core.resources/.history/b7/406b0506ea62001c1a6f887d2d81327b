#This program displays images specified in a text file
#Written by David Pick
from graphics import *
def main():
    win = GraphWin('blah', 1000, 1000)
    
    imgfile = raw_input("Enter the name of the file with the image names in it: ")
    sleeptime = float(raw_input("Enter an amount of time to wait inbetween slides: "))
    #Open File
    file = open(imgfile + ".txt", 'r')
    
    for i in range(4):
        curline = file.readline()
        curline = curline.strip()
        print curline
        #Display picture
        Image(Point(500, 500), curline)
        time.sleep(sleeptime)
    #Wait for mouse click then close
    win.getMouse()
    win.close()
main()
