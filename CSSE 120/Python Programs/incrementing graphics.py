def main():
    from graphics import *
    win = GraphWin('Boxes' , 800, 350)
    numboxes = 5
    for i in range(numboxes):
        box = Rectangle(Point(5 * numboxes, 100), Point(25 * numboxes, 100)
        box.draw(win)


main()
