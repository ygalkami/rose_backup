# Matt Boutell and Curt Clifton, 19 Jan 2008

from tetrisTestUtilities import *
from Bar import *
from PlayingBoard import *

class Ell(Bar):
    """This is an implementation of:
       E#E
       E   
       where # indicates the center of rotation."""
       
    def __init__(self, board):
        self.row = 0
        self.col = (board.getWidth()-1)/2
        self.orientation = 0
        self.board = board
        # Cell offsets are used to calculate which cells (relative to the centroid)
        # are filled by a block in each of the orientations. Rows in the offset 
        # matrix correspond to the four possible orientations.  Cols correspond to
        # the four cells covered.
        self.cellOffsets = [[(0, -1), (0, 0), (0, 1), (1, -1)],
                            [(-1, -1), (-1, 0), (0, 0), (1, 0)],
                            [(0, -1), (0, 0), (0, 1), (-1, 1)],
                            [(-1, 0), (0, 0), (1, 0), (1, 1)]]
        self.colorSymbol = "E"
        self._addToBoard()
        
    
#-----------------------------------------------------------------------------
# ELL TESTS
#-----------------------------------------------------------------------------

def moveLeftEllTest():
    printTestName()
    board = PlayingBoard()
    piece = Ell(board)
    verifyBoardSparse("Initial Ell board", 
                      [(0,3),(0,4),(0,5),(1,3)], board)
    piece.moveLeft()
    verifyBoardSparse("Ell board after one moveLeft", 
                      [(0,2),(0,3),(0,4),(1,2)], board)
    doMultipleMoves(piece, -2, 0, 0)
    verifyBoardSparse("Ell board after moving to left edge", 
                      [(0,0),(0,1),(0,2),(1,0)], board)
    piece.moveLeft()
    verifyBoardSparse("Ell board after trying to move left again", 
                      [(0,0),(0,1),(0,2),(1,0)], board)
    print

def moveRightEllTest():
    printTestName()
    board = PlayingBoard()
    piece = Ell(board)
    piece.moveRight()
    verifyBoardSparse("Ell board after one moveRight", 
                      [(0,4),(0,5),(0,6),(1,4)], board)
    doMultipleMoves(piece, 3, 0, 0)
    verifyBoardSparse("Ell board after moving to right edge", 
                      [(0,7),(0,8),(0,9),(1,7)], board)
    piece.moveRight()
    verifyBoardSparse("Ell board after trying to move right again", 
                      [(0,7),(0,8),(0,9),(1,7)], board)
    print
    
def moveDownEllTest():
    printTestName()
    board = PlayingBoard()
    piece = Ell(board)
    verifyTrue("Ell initial moveDown return value", piece.moveDown())
    verifyBoardSparse("Ell board after one moveDown", 
                      [(1,3),(1,4),(1,5),(2,3)], board)
    doMultipleMoves(piece, 0, 14, 0)
    verifyBoardSparse("Ell board after moving one space from bottom edge", 
                      [(15,3),(15,4),(15,5),(16,3)], board)

    verifyTrue("Ell next-to-last moveDown return value", piece.moveDown())
    verifyBoardSparse("Ell board after trying to move down again", 
                      [(16,3),(16,4),(16,5),(17,3)], board)

    verifyFalse("Ell last moveDown return value", piece.moveDown())
    verifyBoardSparse("Ell board after trying to move down again", 
                      [(16,3),(16,4),(16,5),(17,3)], board)
    print

def dropEllTest():
    printTestName()
    board = PlayingBoard()
    piece = Ell(board)
    rotateAndDropHelper(piece, board, 0, [(16,3),(16,4),(16,5),(17,3)])

    board = PlayingBoard()
    piece = Ell(board)
    rotateAndDropHelper(piece, board, 1, [(15,4),(16,4),(17,4),(15,3)])
    
    board = PlayingBoard()
    piece = Ell(board)
    rotateAndDropHelper(piece, board, 2, [(17,3),(17,4),(17,5),(16,5)])

    board = PlayingBoard()
    piece = Ell(board)
    rotateAndDropHelper(piece, board, 3, [(15,4),(16,4),(17,4),(17,5)])

    board = PlayingBoard()
    piece = Ell(board)
    rotateAndDropHelper(piece, board, 0, [(16,3),(16,4),(16,5),(17,3)])
    print

def rotateEllTest():
    printTestName()
    board = PlayingBoard()
    piece = Ell(board)
    # Move piece below top edge to give space to rotate
    doMultipleMoves(piece, 0, 2, 0)
    piece.rotate()
    verifyBoardSparse("Ell board after one rotation", 
                      [(1,4),(2,4),(3,4),(1,3)], board)
    piece.rotate()
    verifyBoardSparse("Ell board after two rotations", 
                      [(2,3),(2,4),(2,5),(1,5)], board)
    piece.rotate()
    verifyBoardSparse("Ell board after three rotations", 
                      [(1,4),(2,4),(3,4),(3,5)], board)
    piece.rotate()
    verifyBoardSparse("Ell board after four rotations", 
                      [(2,3),(2,4),(2,5),(3,3)], board)
    print

def moveLeftWithLandscapeEllTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Ell(board)
    doMultipleMoves(piece, -2, 10, 0)
    piece.moveLeft()
    verifyBoardWithLandscape("Ell left into landscape--partially obstructed", 
                             [(10,1),(10,2),(10,3),(11,1)], board, landscape1)
    doMultipleMoves(piece, -1, 3, 3)
    piece.moveLeft()
    verifyBoardWithLandscape("Ell left into landscape--fully obstructed", 
                             [(12,1),(13,1),(14,1),(14,2)], board, landscape1)
    print

def moveRightWithLandscapeEllTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Ell(board)
    doMultipleMoves(piece, 3, 10, 3)
    piece.moveRight()
    verifyBoardWithLandscape("Ell right into landscape--partially obstructed", 
                             [(9,7),(10,7),(11,7),(11,8)], board, landscape1)
    doMultipleMoves(piece, 1, 3, 2)
    piece.moveRight()
    verifyBoardWithLandscape("Ell right into landscape--fully obstructed", 
                             [(12,8),(13,8),(14,8),(12,7)], board, landscape1)
    print

def moveDownWithLandscapeEllTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Ell(board)
    doMultipleMoves(piece, 4, 10, 0)
    verifyFalse("Ell down into landscape--partially obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Ell down into landscape--partially obstructed", 
                             [(10,7),(10,8),(10,9),(11,7)], board, landscape1)
    
    doMultipleMoves(piece, -4, 0, 1)
    doMultipleMoves(piece, -3, 1, 0)
    
    verifyFalse("Ell down into landscape--partially obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Ell down into landscape--partially obstructed", 
                             [(10,1),(11,1),(12,1),(10,0)], board, landscape1)
    
    # Restart
    board = PlayingBoard()
    setCellsOfBoard(landscape2, board)
    piece = Ell(board)
    doMultipleMoves(piece, 0, 3, 1) # Lower into open space and rotate
    doMultipleMoves(piece, 0, 12, 0) # Lower into "canyon"
    verifyFalse("Ell down into landscape--fully obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Ell down into landscape--fully obstructed", 
                             [(14, 4),(15, 4),(16, 4),(14,3)], board, landscape2)
    print

def rotateWithLandscapeEllTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Ell(board)
    # Need to split into 2 separate moves, else it gets caught the landscape
    doMultipleMoves(piece, 2, 10, 1)
    doMultipleMoves(piece, 0, 5, 0)
    piece.rotate()
    verifyBoardWithLandscape("Ell rotate in landscape--Barely clear", 
                             [(15,5),(15,6),(15,7),(14,7)], board, landscape1)
    piece.rotate()
    verifyBoardWithLandscape("Ell rotate in landscape--obstructed", 
                             [(15,5),(15,6),(15,7),(14,7)], board, landscape1)
    print

def ellTests():
    """Runs the tests."""
    initialFailureCount = getCountOfFailedTests()
    printTestSetName()
    newPieceTest(Ell(PlayingBoard()))
    print
    
    moveLeftEllTest()
    moveRightEllTest()
    moveDownEllTest()
    dropEllTest()
    rotateEllTest()
    
    if getCountOfFailedTests() > initialFailureCount:
        announceAborting("ELL")
    else:
        moveLeftWithLandscapeEllTest()
        moveRightWithLandscapeEllTest()
        moveDownWithLandscapeEllTest()
        rotateWithLandscapeEllTest()
    
if __name__ == '__main__':
    ellTests()