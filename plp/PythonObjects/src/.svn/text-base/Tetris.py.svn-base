# Tetris
# by Team <NN>
# CSSE 120, Winter 2007-08
# Team Members: <put your names here>

# This is the main entry point for the Tetris game.  We will provide a new
# version of the code for this module in the middle of 7th week.  That new
# version will include a graphical user interface for Tetris.  If your code
# passes the TetrisTextTests, it is very likely to just work without changes
# with the graphical version we'll provide.

#import TetrisTextTest 
#TetrisTextTest.textTests()

from zellekeygraphics import *
from time import sleep, time
from random import randrange
from PlayingBoard import PlayingBoard
from MrChunky import MrChunky
from Bar import Bar
from Ell import Ell
from Jay import Jay
from Tee import Tee
from RightZig import RightZig
from LeftZag import LeftZag

# Configuration variables.
num_rows = 18
num_cols = 10
cell_size = 30 # in pixels
game_step_time = 0.5 # in seconds
min_key_repeat_interval = 0.001 # in seconds, delay between keypress checks
background_color = "gray"

# Key Codes
# No doubt these are defined elsewhere, but we couldn't find them
# In each list the first entry is the keycode on Windows XP; the second on 
# Mac OS X, 10.4.11; the third on Linux.
left_arrow  = [37,8060956,100,113]
up_arrow    = [38,8257566,98,111]
right_arrow = [39,8126493,102,114]
down_arrow  = [40,8192031,104,116]
enter_key   = [13,4980739,36]

# TODO: Update symbols to match your pieces, and change colors if you wish.
# A dictionary is like a list, but we can look up things using "keys".  With the
# definition below, we can write: colorDictionary["M"] 
# and get back "red", the color for MrChunky.
colorDictionary = {"M": "red", # MrChunky
                   "B": "orange", # Bar
                   "E": "blue", # Ell
                   "J": "purple", # Jay
                   "T": "yellow", # Tee
                   "R": "lightblue", # RightZig
                   "L": "green", #LeftZag
                   " ": background_color} #blank

def drawBoardOnScreen(cells, board):
    """Fills in the cells on the drawing window with the colors based on the
    board description."""
    for r in range(num_rows):
        for c in range(num_cols):
            cell = cells[r][c]
            cell.setFill(colorDictionary[board.getCellSymbol(r, c)])

def createCells(win, board):    
    """Creates a board-size matrix of invisible (gray) squares."""
    cells = [[Rectangle(Point(col*cell_size, row*cell_size), \
                        Point((1+ col)*cell_size, (1 + row)*cell_size)) \
                        for col in range(num_cols)] for row in range(num_rows)]
    for r in range(num_rows):
        for c in range(num_cols):
            cell = cells[r][c]
            cell.setFill("black")
            cell.setOutline(background_color)
            cell.draw(win)
    return cells

def createPiece(board):
    """Randomly generates a new piece."""
    # You can comment out parts of this to remove any not-yet-implemented 
    # pieces during testing.
    pieceChoice = randrange(7)
    if pieceChoice == 0:
        return Bar(board)
    elif pieceChoice == 1:
        return Ell(board)
    elif pieceChoice == 2:
        return Jay(board)
    elif pieceChoice == 3:
        return Tee(board)
    elif pieceChoice == 4:
        return RightZig(board)
    elif pieceChoice == 5:
        return LeftZag(board)
    
    # Default to MrChunky
    return MrChunky(board)

def gameOver(board):
    """Tests whether there is room to add a new piece to the board.  If not,
    the game is over."""
    # FIXME: entranceZone cell columns should depend on board width.
    entranceZone = [(0,3),(0,4),(0,5),(0,6),(1,3),(1,4),(1,5)]
    return not board.areCellsClear(entranceZone)

def main():
    """Runs the game."""
    board = PlayingBoard(num_rows, num_cols)

    # Creates graphical display and cells
    win = GraphWin("Tetris", num_cols*cell_size, num_rows*cell_size)
    win.setBackground('gray')
    cells = createCells(win, board)
    
    # The main event loop for the game.
    activePiece = createPiece(board)
    drawBoardOnScreen(cells, board)
    # Keeps processing until we detect gameOver(), which breaks out of the loop.
    while True:
        # Keeps getting keyboard input until game_step_time seconds have passed.
        startTime = time()
        endTime = startTime + game_step_time
        while time() < endTime:
            key = win.checkKey()
            if key == None:
                # no key pressed, so wait a bit before checking again
                sleep(min_key_repeat_interval)
            else:
                # key pressed, so tell the active piece to do the right thing
                if key in enter_key:
                    break
                elif key in left_arrow:
                    activePiece.moveLeft()
                elif key in right_arrow:
                    activePiece.moveRight()
                elif key in up_arrow:
                    activePiece.rotate()
                elif key in down_arrow:
                    # when dropping a piece, leave the keyboard input loop so
                    # a new piece can be created
                    activePiece.drop()
                    break
                drawBoardOnScreen(cells,board)

        stillLive = activePiece.moveDown()
        drawBoardOnScreen(cells, board)
        if not stillLive:
            linesCleared = board.clearLines()
            if gameOver(board):
                # Leave main event loop of game when game is over.
                break
            activePiece = createPiece(board)
            drawBoardOnScreen(cells, board)
    
    win.close()
    
main()