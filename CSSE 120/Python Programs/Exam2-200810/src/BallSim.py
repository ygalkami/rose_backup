# This program simulates balls moving on a frictionless surface.
# Not yet implemented: collisions between balls
# by Curt Clifton, Sept. 29, 2007.

from graphics import *
from time import sleep
from random import randrange, random
from math import sqrt

# Nearly constants, tuning parameters to adjust the simulation.
# All length values in pixels unless otherwise noted.
CONTAINER_WIDTH, CONTAINER_HEIGHT = 800, 600
BALL_RADIUS = 15
BALL_COUNT = 20
TIME_STEP = 0.01 # in seconds
# The maximum initial magnitude of each velocity component.
MAX_VELOCITY_COMP = 1000.0 # in pixels per second
COLORS = ['red', 'orange', 'yellow', 'green', 'blue', 'purple', 'violet' ]

class Ball:
	def __init__(self, window):
		"""Randomly assigns the ball's initial values."""
		# Make the container the same dimensions as the window
		self.containerWidth = window.getWidth()
		self.containerHeight = window.getHeight()

		# Choose a random position and a random color for this ball
		xPos = randrange(BALL_RADIUS, self.containerWidth - BALL_RADIUS)
		yPos = randrange(BALL_RADIUS, self.containerHeight - BALL_RADIUS)
		self.image = Circle(Point(xPos, yPos), BALL_RADIUS)
		self.colorIndex = randrange(len(COLORS))
		self._setColor(COLORS[self.colorIndex])
		self.bouncecount = 0
		self.text = Text(Point(xPos, yPos), str(self.bouncecount))
		

		# Draw the ball and assign it a random velocity
		self.image.draw(window)
		self.text.draw(window)
		self.xVelocity = random() * MAX_VELOCITY_COMP * 2 - MAX_VELOCITY_COMP
		self.yVelocity = random() * MAX_VELOCITY_COMP * 2 - MAX_VELOCITY_COMP

	def timePasses(self, time):
		"""Updates the ball's state based on the specified number of seconds passing."""
		dx = self.xVelocity * time
		dy = self.yVelocity * time
		self.image.move(dx, dy)

		self.text.move(dx, dy)
		self._maybeBounce()
		self.text.setText(str(self.bouncecount))
#		bouncenum = Text(Point(self.image.getCenter().getX(), self.image.getCenter().getY()), str(self.bouncecount))
#		bouncenum.draw(window)
		
		
	def _maybeBounce(self):
		"""Checks to see if the ball needs to bounce, and performs the bounce if needed."""
		bounce = False
		if not self._inBoundsHorizontally():
			# Bounce off a left or right wall
			self.xVelocity *= -1.0
			bounce = True
			#self.bouncecount = self.bouncecount + 1
		if not self._inBoundsVertically():
			# Bounce of the floor or ceiling
			self.yVelocity *= -1.0
			bounce = True
			#self.bouncecount = self.bouncecount + 1
		if bounce:
			# Change color if there was a bounce
			self.bouncecount = self.bouncecount + 1
			self._nextColor()
			
			
	def _setColor(self, color):
		"""Set this ball's color to the color of the actual argument."""
		self.image.setFill(color)
		self.image.setOutline(color)

	def _nextColor(self):
		"""Sets this ball's color to the next color on the list."""
		self.colorIndex += 1
		self.colorIndex %= len(COLORS)
		self._setColor(COLORS[self.colorIndex])

	def _getPos(self):
		""" return the current center of the ball"""
		p = self.image.getCenter()
		x = p.getX()
		y = p.getY()
		return x, y

	def _inBoundsHorizontally(self):
		""" return True iff x coordinates of the entire ball are in  the container.""" 
		x, y = self._getPos()
		return BALL_RADIUS <= x < (self.containerWidth - BALL_RADIUS)

	def _inBoundsVertically(self):
		""" return True iff y coordinates of the entire ball are in  the container.""" 
		x, y = self._getPos()
		return BALL_RADIUS <= y < (self.containerHeight - BALL_RADIUS)
	def xpos(self):
		return self.image.getCenter().getX()
	
	def ypos(self):
		return self.image.getCenter().getY()
	
	def numbounces(self):
		return self.bouncecount
# end of Ball class definition

def simulate(window):
	"""Runs the simulation by looping through time one tick at a time"""
	
	# create the list of balls
	balls = []
	for i in range(BALL_COUNT):
		balls.append(Ball(window))
	lastClick = window.checkMouse()
	
	# keep simulating until the user clicks the mouse in the window.
	while lastClick == None:
		sleep(TIME_STEP)
		
		# move/bounce all of the balls.
		for b in balls:
			b.timePasses(TIME_STEP)
#			bouncenum = b.numbounces()
#			x = b.xpos()
#			y = b.ypos()
#			text = Text(Point(x, y), str(bouncenum))
#			text.draw(window)
			sleep(TIME_STEP)
#			text.undraw()
		lastClick = window.checkMouse()

def main():
	window = GraphWin('Rolling, Rolling, Rolling', CONTAINER_WIDTH, CONTAINER_HEIGHT)
	msg = Text(Point(CONTAINER_WIDTH/2, CONTAINER_HEIGHT - 10), 'Click to begin simulation')
	msg.draw(window)
	window.getMouse()
	msg.setText('Click to exit')
	simulate(window)
	window.close()

if __name__ == '__main__':
	main()