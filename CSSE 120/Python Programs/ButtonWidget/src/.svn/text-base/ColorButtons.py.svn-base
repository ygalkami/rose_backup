# ColorButtons.  Wriotten By Claude Anderson.  Sept 30, 2007.
# Test the Button class, and illustrate lists of objects.

# TO DO:
#
#  1. Create the list of buttons, as described below.
#  2. Add (near the bottom of the window) a re-enable button
#     the re-enables all of the color butttons.

from graphics import *
from Button import  *

COLORLIST = ['red', 'blue', 'tomato', 'DarkOliveGreen4', 'SteelBlue2', 'MistyRose3', 'violet', 'orange', 'gold' ,'cyan']

winSize = 650
buttonSpacing =  Button.MIN_HEIGHT + 8 # vertical spacing between centers of color buttons.
rectInset = 30

win = GraphWin("", winSize, winSize)

rect=Rectangle(Point(rectInset, rectInset), Point(winSize - rectInset, winSize/3 - rectInset))
rect.draw(win) # Later this rectangle will be filled with various colors.

buttonList = [""] * len(COLORLIST)
print buttonList
# You should create a list of buttons; the label of each button should 
# be one of the strings frmo the colorList.  Specify the location of 
# each button, but not its size; the button constructor should
# figure out the appropriate size.
for i in range(len(COLORLIST)):
	buttonList[i] = Button(win, COLORLIST[i], Point(280, 210 + (38 * i)))

quitButton  = Button(win, "Quit", Point(50, winSize - Button.MIN_HEIGHT - 10))

Text(Point(winSize - 120,winSize - 2* Button.MIN_HEIGHT - 10 ), "For info on color names, do a ").draw(win)
Text(Point (winSize - 120, winSize - Button.MIN_HEIGHT - 10 ), "Google search for TK COLORS").draw(win)

# Add the "re-enable all" button and make it do just that.

# event loop:
while True:
	p = win.getMouse()
	for b in buttonList:
		if b.clicked(p):
			rect.setFill(b.getLabel())
			b.disable()
			break
	if quitButton.clicked(p):
   		break
win.close()


                     
                     