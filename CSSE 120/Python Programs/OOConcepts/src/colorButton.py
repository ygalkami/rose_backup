# Begin to implement the colorButton class  from here  
# colorButton class.  Written by David Pick, 10/12/07
# This class extends the button class using inheritance to change the colors of the buttons created with the button class
from buttonWidget import *
from random import randrange

#------------------------------------------------------
# Implement your colorButton class here
#------------------------------------------------------
#colorList = ['red', 'green', 'blue', 'yellow', 'darkgray']
class ColorButton(Button):
    def __init__(self, win, label, center, colorList):
        self.colorlist = colorList
        Button.__init__(self, win, label, center)
        
    def disable(self):
        Button.disable(self)
        self.rect.setFill(self.colorlist[0])
        self.rect.setOutline(self.colorlist[1])
    def enable(self):
        Button.enable(self)
        self.rect.setOutline(self.colorlist[2])
        self.rect.setFill(self.colorlist[3])

def buttonTest(win, text):
   b1 = Button(win, "Click Me!", Point(200, 100))
   b2 = Button(win, "No. Click Me!", Point(400, 100))
   b3 = Button(win, "Quit", Point(600, 100))
   #b4 = ColorButton(win, "test", Point(200, 200), colorList)
   
   b4.enable()
   b2.disable()       
   p = win.getMouse()
   
   while True:
    if b1.clicked(p):
        b1.disable()
        b2.enable()
        text.setText("You clicked " + str(b1))
    if  b2.clicked(p):
        b2.disable()
        b1.enable()
        text.setText("You clicked " + str(b2))        
    if  b3.clicked(p):
         break
    p = win.getMouse()

def colorButtonTest(win, text):
    colorList = ['red', 'green', 'blue', 'darkgray']
    b1 = ColorButton(win, "test", Point(100,100), ['red', 'green', 'blue', 'darkgray'])
    b2 = ColorButton(win, "Button 2", Point(210, 100), ['blue', 'purple', 'green', 'black'])
    b3 = ColorButton(win, "Button 3", Point(350, 100), ['gray', 'purple', 'green', 'blue'])
    b4 = ColorButton(win, "Quit", Point(450, 100), ['darkgray', 'blue', 'green', 'red'])
    
    b1.enable()
    b2.disable()
    b3.disable()
    
    p = win.getMouse()
    
    while True:
        if b1.clicked(p):
            b1.disable()
            b2.enable()
            b3.enable()
        if b2.clicked(p):
            b1.enable()
            b2.disable()
            b3.enable()
        if b3.clicked(p):
            b1.enable()
            b2.enable()
            b3.disable()
        if b4.clicked(p):
            break
        p = win.getMouse
     
def main():
    window = GraphWin("", 700, 400)
    text = Text(Point(400, 200), "Click on a button.")
    text.draw(window)
    #buttonTest(window, text)  # comment out this line.
    # invoke colorButtonTest
    colorButtonTest(window, text)
    window.close()
    exit()
          
     
if __name__ == '__main__':
    main()
