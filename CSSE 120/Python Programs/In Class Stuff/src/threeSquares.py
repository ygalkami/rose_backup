# A simple GUI to draw squares
# by Curt Clifton, Sept. 13, 2007

from graphics import *

# Nearly constants
window_title = "Eat three squares a day!"
window_width = 800
window_height = 400
rectangle_count = 3
initial_prompt = "Click once to set the first corner " + \
                 "and again to set the opposite corner"

def main():
    window = GraphWin(window_title, window_width, window_height)
    # centers prompt message at bottom of window
    prompt = Text(Point(window_width / 2, window_height - 5), initial_prompt)
    prompt.draw(window)
    for i in range(rectangle_count):
        # gets first corner and draws it
        p1 = window.getMouse()
        p1.draw(window)
        # gets second corner
        p2 = window.getMouse()
        # draws the rectangle
        p1.undraw()
        rect = Rectangle(p1, p2)
        rect.draw(window)
        statistics = stat(rect)
        #-----------------------------------------------------------------------
        # CHANGE THE LOCATION OF THE MESSAGE SO IT IS CENTERED IN THE RECTANGLE
        #-----------------------------------------------------------------------
        message_loc = Point(rect.getCenter().getX(),rect.getCenter().getY())
        message = Text(message_loc, "%0.f, %0.f" % stat(rect))
        message.draw(window)
    prompt.setText("Click to exit")
    last_click = window.getMouse()
    window.close()

# Returns statistics about the given rectangle
def stat(r):
    x = r.getP2().getX() - r.getP1().getX()
    y = r.getP2().getY() - r.getP1().getY()
    area = x * y
    perimeter =  (x*2) + (y*2)
    print x, y
    return area, perimeter
    #pass

main()
exit()