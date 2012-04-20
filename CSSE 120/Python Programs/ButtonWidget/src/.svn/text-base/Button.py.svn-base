# Button class.  Written by Claude Anderson, Sept 30, 2007.
# Similar to the class developed in Zelle Section 10.6, but we add an enhancement:
#  If the user does not specify a button height or width (or specifies height and 
#    width that are too small, the constructor adjusts the size to the minimum height and width
#    needed to enclose the text.

# TODO: Enhance the __setRectDimensions method so that it actually does this resizing.

from graphics import  *

class Button:
	""" A Button widget similar to the one in Zelle 10.6, 
		but with the extra property of making sure the 
		Button's text fits inside the rectangle """
	MIN_HEIGHT = 38  # A button should be at least this tall, in order to comfortably surround the text.
	FONT_NAME = 'courier'  
	FONT_SIZE = 20
	CHAR_WIDTH = 16  # The width of a character (in pixels) of the chosen font face/size.
	EXTRA_HORZ_SPACE = 6  # Put in this much extra horizontal space so that 
                         # the label doesn't run into the end of the rectangle.
    
	def __init__(self, win, label, center):
		"""Initialize a Button with the given characteristics.
           If the default values for width and height are used, 
           these dimensions re shosen so the rectangle barely encloses the text."""
		self.label = label
		self.__setRectDimensions(center, label)
		self.__setRect(center)
		self.__setText(label, center)
		self.enable()
		self.rect.draw(win)
		self.text.draw(win)
      
	def enable(self):
		""" Enable this button so it responds to clicks """
		self.enabled = True
		self.rect.setWidth(3)
		self.text.setOutline('black')

	def __str__(self):
		return "Button: (%d, %d) %s" % (self.rect.getCenter.getX(), self.rect.getCenter.getY(), label)
 
	def disable(self):
		""" Disable this button so it does not respond to clicks """
		self.enabled = False
		self.rect.setWidth(1)
		self.text.setOutline('darkgrey')
      
	def clicked(self, clickPoint):
		"""" Is this button enabled, and is the clickPoint within the button? """
		return self.enabled and  \
		self.minX <= clickPoint.getX() <= self.maxX and \
		self.minY <= clickPoint.getY() <= self.maxY
         
	def getLabel(self):
		return self.label
        
	def __setRectDimensions(self, center, label):
		""" Internal method.  Called by the constructor. 
            If given height and width are large enough to enclose the text, use them.  
            If not, use dimensions that barely enclose the text """
          
		# TODO: Add code here to adjust width and height if they are too small to contain the text.
		textlen = len(label)
		textlen = textlen * 16
		print textlen
		centerX, centerY = center.getX(), center.getY()
		self.minX = centerX - (textlen + Button.EXTRA_HORZ_SPACE)/2     
		self.minY = centerY - Button.MIN_HEIGHT/2
		self.maxX = centerX + (textlen + Button.EXTRA_HORZ_SPACE)/2 #centerX + width/2     
		self.maxY = centerY + Button.MIN_HEIGHT/2
         
	def __setRect(self, center):
		""" Internal method.  Called by the constructor. 
            Create the rectangular border of the button """
		self.rect = Rectangle(Point(self.minX, self.minY), Point(self.maxX, self.maxY))
  
	def __setText(self, label, center):
		""" Internal method.  Called by the constructor. 
            Create the Text object for the button's label"""
		self.text = Text(center, label)
		self.text.setFace(Button.FONT_NAME)
		self.text.setSize(Button.FONT_SIZE)
     
     
if __name__ == '__main__':
	win = GraphWin("", 700, 400)
	b1 = Button(win, "Press Me", Point(100, 100))
	# note that the rectangle is too small.  You arte to fix the 
	# constructor so that the rectangle is always tall enough and wide enough.
   
	b2 = Button(win, "No. Press Me!", Point(300, 100))
	# You can barely see the rectangle, We do not specify width and height,
	# so the default value of zero is used for each.
   
	b3 = Button(win, "Big Button", Point(500, 300))
	# THis will not be resized, because it is already big enough.
   
	win.getMouse()  
	b1.disable()
	win.getMouse()  
	b1.enable()
	p = win.getMouse()
	for i in range(5):
		if b1.clicked(p):
			print "CLICKED B1"
		if b2.clicked(p):
			print "CLICKED B2"
		p = win.getMouse()
	win.close()
      
