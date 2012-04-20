# This module was a prototype to verify that we can get sufficient frame rate
# using setFill().

from zellegraphics import *
from random import randrange
from time import sleep

num_cols = 10
num_rows = 18
cell_size = 30
rest_interval = 0.5

colors = ['peru', 'papayawhip', 'peachpuff']

def randColor():
    return colors[randrange(len(colors))]

def updateFillColors():
    for r in range(num_rows):
        for c in range(num_cols):
            cell = cells[r][c]
            cell.setFill(board[r][c])

# Creates graphical display and cells
win = GraphWin("Tetris", num_cols*cell_size, num_rows*cell_size)
win.setBackground('gray')
cells = [[Rectangle(Point(col*cell_size, row*cell_size),Point((1+ col)*cell_size, (1 + row)*cell_size)) for col in range(num_cols)] for row in range(num_rows)]
# Creates board model matrix, randomly filled
board = [[randColor() for col in range(num_cols)] for row in range(num_rows)]
board[0][0]='red'
updateFillColors()
for r in range(num_rows):
    for c in range(num_cols):
        cell = cells[r][c]
        cell.setOutline('gray')
        cell.draw(win)
        
# Tests animation by rotating the board and updating display
while win.checkMouse() == None:
    sleep(rest_interval)
    rest_interval *= 0.95
    board.insert(0, board.pop(-1))
    updateFillColors()

win.getMouse()
win.close()