# This program implements the game Quixo.
# It was written as a team project for CSSE 120, Fall 2007.
# TODO: REPLACE THE SECTION AND TEAM NUMBER IN THE FOLLOWING LINE
# Section 1, Team 13
# Team members:
# David Pick
# Aaron Blankenbaker
# John Lee Burns

from graphics import *
from time import *
from math import *

win = GraphWin("Quixo", 500, 500)
boardsize = 5
pps = 100
inset = 15
board = [0] * boardsize
for i in range(boardsize):
    board[i] = [0] * boardsize
    
board2 = [0] * boardsize
for i in range(boardsize):
    board2[i] = [0] * boardsize
#create block class
class block():
    def __init__(self, piece, row, col, placerow, placecol):
        #take in piece and assign the create piece to each class, then draw a piece based on that input
        self.piece = piece
        if piece == "x":
            self.drawX(row, col)
        elif piece == "o":
            self.drawO(row, col)
        elif piece == "blank":
            self.drawBlank(row, col)
    #draw x
    def drawX(self, row, col):
        self.line1 = Line(self.getUpperLeft(row, col), self.getLowerRight(row, col))
        self.line2 = Line(self.getUpperRight(row, col), self.getLowerLeft(row, col))
        self.line1.draw(win)
        self.line2.draw(win)
    #draw O
    def drawO(self, row, col):
        x = pps * col + 50
        y = pps * row + 50
        self.circle = Circle(Point(x, y), 35)
        self.circle.draw(win)
    
    #Draw blank square
    def drawBlank(self, row, col):
        x1 = pps * col + 5
        y1 = pps * row + 5
        x2 = pps * col + 95
        y2 = pps * row + 95
        self.rect = Rectangle(Point(x1, y1), Point(x2, y2))
        self.rect.setFill('white')
        self.rect.draw(win)
        
    def getUpperLeft(self, row,col):
        x1 = pps * (col + 1) - inset
        y1 = pps * (row + 1) - inset
        return Point(x1, y1)

    def getLowerLeft(self, row, col):
        x2 = pps * (col + 1) - inset
        y2 = pps * row + inset
        return Point(x2, y2)
    
    def getUpperRight(self, row, col):
        x1 = pps * col + inset
        y1 = pps * (row + 1) - inset
        return Point(x1, y1)
        
    def getLowerRight(self, row, col):
        x2 = pps * col + inset
        y2 = pps * row + inset
        return Point(x2, y2)
    
    def undraw(self):
        if self.piece == "x":
            self.line1.undraw()
            self.line2.undraw()
        elif self.piece == "o":
            self.circle.undraw()
    #Find the blocks current row
    def getrow(self):
        if self.piece == "x":
            row = (self.line1.getCenter().getX() - 50) / pps
        if self.piece == "o":
            row = (self.circle.getCenter().getX() - 50) / pps
        if self.piece == "blank":
            row = (self.rect.getCenter().getX() - 50) / pps
        return row
    #Find the blocks current column    
    def getcol(self):
        if self.piece == "x":
            col = (self.line1.getCenter().getY() - 50) / pps
        if self.piece == "o":
            col = (self.circle.getCenter().getY() - 50) / pps
        if self.piece == "blank":
            col = (self.rect.getCenter().getY() - 50) / pps
        return col
    
    #if the blocked is clicked outline it in red
    def clicked(self):
        self.rect.setOutline('red')
        #print self.getrow(), self.getcol()
        
    #set the blocks out back to black    
    def unclicked(self):
        self.rect.setOutline('black')

#Create the board at the beginning of the game
#Initizlize every block to blank    
def drawboard(boardsize): 
    for i in range(boardsize):
        for j in range(boardsize):
            board[i][j] = block("blank", i, j, i, j) 
                      
#Find what direction to rotate
def direction2(row, col, placerow, placecol):           
    if row - placerow > 0:
        side = "right"
    else:
        side = "left"
    if col - placecol > 0:
        side = "down"
    else:
        side = "up"
    return side

#Find which direction vertical or horizontally to rotate
def RowOrCol(row, col, placerow, placecol):
    if abs(row - placerow) == 4:
        direction = "vert"
    elif abs(col - placecol) == 4:
        direction = "horiz"
    else:
        direction = "bad direction"
    return direction

#Find which row/col to rotate
def rotatenum(row, col, placerow, placecol):
    if row - placerow == 0:
        num = row
    elif col - placecol == 0:
        num = col
    else:
        num = "bad move"
    return num

#Tell the user if they made an illegal move
def badmove():
    text = Text(Point(250, 250), "That is an illegal move, please try again")
    text.setOutline('red')
    text.draw(win)
    undrawpieces()
    drawpieces()
    for i in range(100):
        sleep(.01)
    text.undraw()
    
    
#Get mouse clicks
#Draw Pieces and rotate board
def getmouse():
    turn = True
    count = 0
    gameover = False
    
    while gameover != True:
        clickpoint = mouseinput(win)
        x = clickpoint.getX()
        y = clickpoint.getY()
        
        placecol = x / pps
        placerow = y / pps
        
        placepoint = mouseinput(win)
        x = placepoint.getX()
        y = placepoint.getY()
        
        col = x / pps
        row = y / pps
        rotate = whichrotate(placerow, placecol, row, col)
        direction = RowOrCol(placerow, placecol, row, col)
        side = direction2(placerow, placecol, row, col)
        num = rotatenum(placerow, placecol, row, col)
        if num == "bad move" or direction == "bad direction":
            badmove()
            print "bad move"
        else:
            print "legal move"
            if turn == True:
                turn = False
                if board[placerow][placecol].piece == "blank":
                    board[placerow][placecol].piece = "x"
                    board[placerow][placecol].drawX(placerow, placecol)
                    
                    
                    undrawpieces()
                    rotateList(rotate, row, col)
                    drawpieces()
                    
                elif board[placerow][placecol].piece == "o":
                    badmove()
                    turn = True
                else:
                    undrawpieces()
                    rotateList(rotate, row, col)
                    drawpieces()
                winCond(board, 5, win, turn)
            elif turn == False:
                turn = True
                if board[placerow][placecol].piece == "blank":
                    board[placerow][placecol].piece = "o"
                    board[placerow][placecol].drawO(placerow, placecol)
                    
                    undrawpieces()
                    rotateList(rotate, row, col)
                    drawpieces()
                    
                elif board[placerow][placecol].piece == "x":
                    badmove()
                    turn = False
                else:
                    undrawpieces()
                    rotateList(rotate, row, col)
                    drawpieces()
                winCond(board, 5, win, turn)
drawboard(boardsize)
win.getMouse()
#Draw X's and O's based on list of lists
def drawpieces():
    for i in range(boardsize):
        for j in range(boardsize):
            board[i][j].unclicked()
            if board[i][j].piece == "x":
                board[i][j].drawX(i, j)
            if board[i][j].piece == "o":
                board[i][j].drawO(i, j)

#undraw all pieces
def undrawpieces():
    for i in range(boardsize):
        for j in range(boardsize):
            if board[i][j].piece != "blank":
                board[i][j].undraw()

#Make sure the user clicked on a valid block       
def mouseinput(window):
    ok=False
    while ok==False:
          point = window.getMouse()
          x1 = point.getX()
          y1 = point.getY()
          if x1<100 or x1>400 or y1<100 or y1>400:
              ok = True
          else:
              badmove()
    return point
#find which way to rotate
def whichrotate(row, col, placerow, placecol):
    rotate = ""
    if row - placerow < 0 and col - placecol == 0:
        print "vert from bottom"
        rotate = "Vertical From Bottom"
    if row - placerow > 0 and col - placecol == 0:
        print "vert from top"
        rotate = "Vertical From Top"
    if row - placerow == 0 and col - placecol > 0:
        print "right to left"
        rotate = "Right to Left"
    if row - placerow == 0 and col - placecol < 0:
        print "left to right"
        rotate = "Left to Right"
    return rotate


def createBoard(board2):
    for i in range(boardsize):
        tempstring = board2[i]
        for j in range(boardsize):
            if tempstring[j] == "X":
                board[i][j].piece = "x"
                board[i][j].drawX(i,j)
            if tempstring[j] == "O":
                board[i][j].piece = "o"
                board[i][j].drawO(i,j)
    return board

def printBoard(board):
    for i in range(boardsize):
        row = ""
        for j in range(boardsize):
            if board[i][j].piece == "blank":
                row = row + " " + "-"
            else:
                row = row + " " + board[i][j].piece
        print row
        
def rotateFromRight(alist):
    """Rotates alist so that the rightmost element appears at the left end of 
    the list and the other elements are pushed toward the right end of the list"""
    temp = alist[-1]
    for i in range(len(alist) - 2, -1, -1):
        alist[i + 1] = alist[i]
    alist[0] = temp

def rotateFromLeft(alist):
    """Rotates alist so that the leftmost element appears at the right end of 
    the list and the other elements are pushed toward the left end of the list"""
    temp = alist[0]
    for i in range(1, len(alist)):
        alist[i - 1] = alist[i]
        
    alist[len(alist)- 1] = temp

    
def rotateRow(alist, side):  
    """Rotates alist from side where side == left or side == right"""  
    if side == right:
        rotateFromRight(alist)
    if side == left:
        rotateFromLeft(alist)

        
def rotateAnyRow(atable, row, side):  
    """Rotates a given row of atable from side where side == left or side == right.
    row is given as an integer value. atable is a list of list of elements"""  
    if side == "right":
        rotateFromRight(atable[row])
    if side == "left":
        rotateFromLeft(atable[row])
  
        
def rotateFromTop(alist, col = 0):
    """Rotates a given column (col) of atable so that the topmost element 
    appears at the bottom of the column and the other elements are pushed toward
    the top of the column.  col is given as an integer value. atable is a list 
    of list of elements."""
    temp = alist[0][col]
    for i in range(1, len(alist)):
        alist[i - 1][col] = alist[i][col]
    alist[len(alist)-1][col] = temp

    
def rotateFromBottom(alist, col = 0):
    temp = alist[-1][col]
    for i in range(len(alist) - 2, -1, -1):
        alist[i + 1][col] = alist[i][col]
    alist[0][col] = temp
   
        
def rotateAnyColumn(alist, col, side):  
    if side == "top":
        temp = alist[0][col]
        for i in range(1, len(alist)):
            alist[i - 1][col] = alist[i][col]
        alist[len(alist)-1][col] = temp;
    elif side == "bottom":
        temp = alist[-1][col]
        for i in range(len(alist) - 2, -1, -1):
            alist[i + 1][col] = alist[i][col]
        alist[0][col] = temp        

#Rotate the list of lists        
def rotateList(which,row,col):
    if which == "Vertical From Bottom":
        rotateAnyColumn(board, col, "top")
        
    if which == "Vertical From Top":
        rotateAnyColumn(board,col, "bottom")
        
    if which == "Right to Left":
        rotateAnyRow(board, row, "right")
    
    if which == "Left to Right":
        rotateAnyRow(board, row, "left")

#Create winning animation            
def celebrate(win, winner):
    win.setCoords(0,0,400,400)
    i=0
    #print winner
    if winner == True:
        winx = Text(Point(60, 200), 'O')
    else:
        winx = Text(Point(60, 200), 'X')
    winw=Text(Point(80,200),'W')
    wini=Text(Point(100,200),'I')
    winn=Text(Point(120,200),'N')
    winx.draw(win)
    winw.draw(win)
    wini.draw(win)
    winn.draw(win)
    for n in range(300):
        winx.setSize(15+int(sin(i)*10))
        winw.setSize(15+int(sin(i)*10))
        wini.setSize(20+int(sin(i)*10))
        winn.setSize(24+int(sin(i)*10))
        
        winx.move((sin(i)), 0)
        winw.move(2*(sin(i)),0)
        wini.move(3*sin(i),0)
        winn.move(4*sin(i),0)
  
        x1=Polygon(Point(50,250+sin(i)*30),Point(50,150-sin(i)*30),Point(200+sin(i)*50,100-sin(i)*30),Point(200+sin(i)*50,300+sin(i)*30))
        x2=Polygon(Point(350-sin(i)*60,250),Point(350-sin(i)*60,150),Point(200+sin(i)*50,100-sin(i)*30),Point(200+sin(i)*50,300+sin(i)*30))
        x1.draw(win)
        x2.draw(win)
        i = n * .2
        sleep(.01)
        x1.undraw()
        x2.undraw()
        
    win.close()

#Check for wins
def winCond(boardchk,size,wind, winner):
    horwin=0
    vertwin=0
    slant1win=0
    slant2win=0
    
    #checks horizontal condition
    for i in range(size):
        for n in range(size):
            if(horwin==size):
                break
            if((boardchk[i][0].piece == boardchk[i][n].piece)and(boardchk[i][n].piece !="blank")):
                #print boardchk[i][n].piece
                horwin+=1
            else:
                horwin=0
                
    #checks vertical condition
    for n in range(size):
        for i in range(size):
            if(vertwin==size):
                break
            if((boardchk[0][n].piece ==boardchk[i][n].piece)and(boardchk[i][n].piece!="blank")):
                vertwin+=1
            else:
                vertwin=0
       
    #checks one of the slant conditions         
    for n in range(size):
        if(slant1win==size):
            break
        if((boardchk[0][0].piece==boardchk[n][n].piece)and(boardchk[n][n].piece!="blank")):
            slant1win+=1
        else:
            slant1win=0
      
    #checks the other slant condition      
    for n in range(size):
        if(slant2win==size):
            break
        if((boardchk[0][size-1].piece==boardchk[n][size-n-1].piece)and(boardchk[n][size-n-1].piece!="blank")):
            slant2win+=1
            #print size-n-1
            #print slant2win
        else:
            slant2win=0
    
    #closes the window if any of the conditions are met        
    if((vertwin==size)or(horwin==size)or(slant1win==size)or(slant2win==size)):
        celebrate(wind, winner)
        gameover = True
        return gameover

#printBoard(board)
#b = createBoard(['----O', 'XX--X', 'XO---', 'OO---', 'X----'])
printBoard(board)
getmouse()