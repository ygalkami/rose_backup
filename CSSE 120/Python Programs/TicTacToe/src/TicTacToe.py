# TicTacToe
# by David Pick
from graphics import *
from win_in import *

#get board size from user / define it to be 3 if left blank
boardsize = raw_input("Enter a board size (press enter for 3):")
boardsize = boardsize.strip()

if boardsize.isdigit() == True:
    boardsize = int(boardsize)
else:
    boardsize = 3
    
board = []
#create nested list to represent the bored
for i in range(boardsize):
    board = board + [i]
    
for i in range(boardsize):
    board[i] = [-1] * boardsize
    
#constants for later use
pps = 100
inset = 15
    
win = GraphWin("Tic Tac Toe", (pps * boardsize), (pps * boardsize))

def drawboard():
    #draw the bored
    for i in range(boardsize):
        x1 = pps * i
        y1 = 0
        x2 = pps * i
        y2 = pps * boardsize
        line = Line(Point(x1, y1), Point(x2, y2))
        line.draw(win)
    for i in range(boardsize):
        x1 = 0
        y1 = 100 * i
        x2 = pps * boardsize
        y2 = pps * i
        line = Line(Point(x1, y1), Point(x2, y2))
        line.draw(win)

def getUpperLeft(row,col):
    x1 = pps * (col + 1) - inset
    y1 = pps * (row + 1) - inset
    return Point(x1, y1)

def getLowerLeft(row, col):
    x2 = pps * (col + 1) - inset
    y2 = pps * row + inset
    return Point(x2, y2)

def getUpperRight(row, col):
    x1 = pps * col + inset
    y1 = pps * (row + 1) - inset
    return Point(x1, y1)
    
def getLowerRight(row, col):
    x2 = pps * col + inset
    y2 = pps * row + inset
    return Point(x2, y2)

def DrawX(row, col):
    #draw a X in a specified row and col
    line1 = Line(getUpperLeft(row, col), getLowerRight(row, col))
    line2 = Line(getUpperRight(row, col), getLowerLeft(row, col))
    line1.draw(win)
    line2.draw(win)

def DrawO(row, col):
    #draw an O in a specified row and col
    x = pps * col + 50
    y = pps * row + 50
    circle = Circle(Point(x, y), 35)
    circle.draw(win)    


def fillboard():
    #fill the board alternating between x and o
    d = 0
    for i in range(boardsize):
        for j in range(boardsize):
            if d == 1:
                DrawX(i, j)
                d = 0
            else:
                DrawO(i, j)
                d = 1
                
def getmouse():
    #wait for user click and put X or O there
    turn = True
    count = 0
    #make sure no one has won yet / if they do draw a line to indicate it
    while checkwin() < 0:
        point = win.getMouse()
        x = point.getX()
        y = point.getY()
        
        col = x / pps
        row = y / pps
        if board[row][col] < 0:
            count = count + 1
            if turn == True:
                DrawX(row, col)
                turn = False
                board[row][col] = 0
            else:
                DrawO(row, col)
                turn = True
                board[row][col] = 1
        if count == boardsize * boardsize:
            break
        

def checkwin():
    gameover = -1
    Ospot = 0
    Xspot = 0
    col = 0
    row = 0
    
    #check for wins
    gameoverhoriz = checkhoriz()
    gameoververt = checkvert()
    gameoverdiag1 = checkdiag1()
    gameoverdiag2 = checkdiag2()
    
    if gameoverhoriz != -1 or gameoververt != -1 or gameoverdiag1 != -1 or gameoverdiag2 != -1:
        gameover = 0
                
    return gameover
def checkvert():
        col = 0
        gameover = -1
        for i in range(boardsize):
            Ospot = 0
            Xspot = 0
            for j in range(boardsize):
                if board[j][i] == 0:
                    Xspot = Xspot + 1
                    col = i
                if board[j][i] == 1:
                    Ospot = Ospot + 1
                    col = i
                if Xspot == boardsize or Ospot == boardsize:
                    x1 = (col + 1) * pps - 50
                    x2 = x1
                    y1 = 0
                    y2 = boardsize * pps
                    line = Line(Point(x1, y1), Point(x2, y2))
                    line.setOutline('red')
                    line.draw(win)
                    gameover = 0
                    return gameover
                    break
        
        return gameover
            
def checkdiag1():
    gameover = -1
    Ospot = 0
    Xspot = 0
                
    for i in range(boardsize):
        if board[i][i] == 0:
            Xspot = Xspot + 1
        if board[i][i] == 1:
            Ospot = Ospot + 1
        if Xspot == boardsize or Ospot == boardsize:
            x1 = 0
            x2 = boardsize * pps
            y1 = 0
            y2 = boardsize * pps
            line = Line(Point(x1, y1), Point(x2, y2))
            line.setOutline('red')
            line.draw(win)
            gameover = 0
            return gameover
            break
    return gameover

def checkdiag2():
    gameover = -1
    Ospot = 0
    Xspot = 0
                
    for i in range(boardsize):
        if board[i][(boardsize - 1) - i] == 0:
            Xspot = Xspot + 1
        if board[i][(boardsize - 1) - i] == 1:
            Ospot = Ospot + 1
        if Xspot == boardsize or Ospot == boardsize:
            x1 = boardsize * pps
            x2 = 0
            y1 = 0
            y2 = boardsize * pps
            line = Line(Point(x1, y1), Point(x2, y2))
            line.setOutline('red')
            line.draw(win)
            gameover = 0
            return gameover
            break
    return gameover

def checkhoriz():
        Xspot = 0
        Ospot = 0
        row = 0
        gameover = -1
        for i in range(boardsize):
            if board[i] == [0] * boardsize:
                gameover = 0
                row = i
                Xspot = boardsize
            if board[i] == [1] * boardsize:
                gameover = 1
                row = i
                Ospot = boardsize
                
        if gameover != -1:        
            x1 = 0
            x2 = pps * boardsize
            y1 = (row + 1) * pps - 50
            y2 = y1
            line = Line(Point(x1, y1), Point(x2, y2))
            line.setOutline('red')
            line.draw(win)
        return gameover
            
drawboard()
getmouse()
win.getMouse()
win.close()