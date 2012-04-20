from graphics import *
wind = GraphWin("An Alien Face", 200, 200)

head = Oval(Point(5,10), Point(100, 150))
head.draw(wind)

#leftEye = Line(Point(25,70), Point(45, 90))
leftEye = Circle(Point(25, 79), 10)
leftEye.setFill('yellow')
leftEye.setOutline('red')
leftEye.draw(wind)

rightEye = leftEye.clone()
rightEye.move(55,0)
#rightEye = Line(Point(85,70), Point(65, 90))

rightEye.draw(wind)

mouth = Rectangle(Point(30, 130), Point(80, 125))
mouth.setFill('red')
mouth.draw(wind)

message = Text(Point(80, 160), "Hello Class")
message.draw(wind)
message.move(-25, 0)

wind.getMouse()