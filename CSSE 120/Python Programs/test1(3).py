from graphics import *

def main():
    numboxes = raw_input("Enter the number of boxes you would like between 1 and 12: ")
    win = GraphWin('Boxes', 500, 500)

    for i in range(int(numboxes)):
        p1 = Point((5) + 35 * (i), 10)
        p2 = Point((25) + 35 * i, 100)
        print p1.getX(), p2.getX()
        box = Rectangle(p1, p2)
        box.draw(win)
main()
