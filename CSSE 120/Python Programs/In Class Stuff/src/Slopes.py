# slope.py
# This program calculates the slope of two line that
# best fit two points

from graphics import Point

def main():
    print "This program calculates the slope of a line.\n"
    try:
        x1, y1 = input("Enter x1, y1 coordinates of a point on the line (comma-separated): ")
        x2, y2 = input("Enter x2, y2 coordinates of another point on the line (comma separated): ")

        deltaY = y2 - y1
        deltaX = x2 - x1
        slope = deltaY / float(deltaX)
        print "\nThe slope of the line is %0.3f." % (slope)
    except ZeroDivisionError:
        print "Found division by 0"
        print "The line has inifinte slope"
    except NameError:
        print "You did not enter correct coordinates"
    except SyntaxError:
        print "Your Syntax is wrong"
    except:
        print "It didn't work"

main()
