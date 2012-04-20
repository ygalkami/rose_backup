# We'll need to distribute to students. 
# Perhaps easiest to do it right in the project folder?

# I got a top speed of 6-7 presses per second.
# With None check shortcircuiting the others, I got better than 11 presses per
# second on my MacBook Pro. -- Curt

from zellekeygraphics import * 

# No doubt these are defined elsewhere, but I couldn't find them
# In each list the first entry is the keycode on Windows XP, the second on 
# Mac OS X, 10.4.11.
left_arrow = [37,8060956]
up_arrow = [38,8257566]
right_arrow = [39,8126493]
down_arrow = [40,8192031]
enter_key = [13,4980739]

win = GraphWin("Getting keyboard input!", 200, 200)
text = Text(Point(100, 50), "Click once here to set focus")
text.draw(win)
text = Text(Point(100, 80), "then use the arrows. ")
text.draw(win)
text = Text(Point(100, 110), "<enter> to quit. ")
text.draw(win)

counter = 0
while True:
    key = win.checkKey()
    if key == None:
        pass # avoids additional tests
    else:
        counter += 1
        if key in enter_key:
            break
        elif key in left_arrow:
            print "%d. Left" % (counter)
        elif key in right_arrow:
            print "%d. Right" % (counter)
        elif key in up_arrow:
            print "%d. Up" % (counter)
        elif key in down_arrow:
            print "%d. Down" % (counter)
        elif key != None:
            print "%d. Keycode %d was pressed" % (counter,key)
