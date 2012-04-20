# Curt Clifton and Matt Boutell, 19 Jan 2008

from tetrisTestUtilities import *
from Bar import *
from PlayingBoard import *

class LeftZag(Bar):
    """This is an implementation of:
       L#
        LL
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
        self.cellOffsets = [[(0, -1), (0, 0), (1, 0), (1, 1)],
                            [(1, -1), (0, -1), (0, 0), (-1, 0)],
                            [(-1, -1), (-1, 0), (0, 0), (0, 1)],
                            [(1, 0), (0, 0), (0, 1), (-1, 1)]]
        self.colorSymbol = "L"
        self._addToBoard()

#-----------------------------------------------------------------------------
# LEFT ZAG TESTS
#-----------------------------------------------------------------------------

def moveLeftLeftZagTest():
    printTestName()
    board = PlayingBoard()
    piece = LeftZag(board)
    verifyBoardSparse("Initial LeftZag board", 
                      [(0,3),(0,4),(1,4),(1,5)], board)
    piece.moveLeft()
    verifyBoardSparse("LeftZag board after one moveLeft", 
                      [(0,2),(0,3),(1,3),(1,4)], board)
    doMultipleMoves(piece, -2, 0, 0)
    verifyBoardSparse("LeftZag board after moving to left edge", 
                      [(0,0),(0,1),(1,1),(1,2)], board)
    piece.moveLeft()
    verifyBoardSparse("LeftZag board after trying to move left again", 
                      [(0,0),(0,1),(1,1),(1,2)], board)
    print

def moveRightLeftZagTest():
    printTestName()
    board = PlayingBoard()
    piece = LeftZag(board)
    piece.moveRight()
    verifyBoardSparse("LeftZag board after one moveRight", 
                      [(0,4),(0,5),(1,5),(1,6)], board)
    doMultipleMoves(piece, 3, 0, 0)
    verifyBoardSparse("LeftZag board after moving to right edge", 
                      [(0,7),(0,8),(1,8),(1,9)], board)
    piece.moveRight()
    verifyBoardSparse("LeftZag board after trying to move right again", 
                      [(0,7),(0,8),(1,8),(1,9)], board)
    print
    
def moveDownLeftZagTest():
    printTestName()
    board = PlayingBoard()
    piece = LeftZag(board)
    verifyTrue("LeftZag initial moveDown return value", piece.moveDown())
    verifyBoardSparse("LeftZag board after one moveDown", 
                      [(1,3),(1,4),(2,4),(2,5)], board)
    doMultipleMoves(piece, 0, 14, 0)
    verifyBoardSparse("LeftZag board after moving one space from bottom edge", 
                      [(15,3),(15,4),(16,4),(16,5)], board)

    verifyTrue("LeftZag next-to-last moveDown return value", piece.moveDown())
    verifyBoardSparse("LeftZag board after trying to move down again", 
                      [(16,3),(16,4),(17,4),(17,5)], board)

    verifyFalse("LeftZag last moveDown return value", piece.moveDown())
    verifyBoardSparse("LeftZag board after trying to move down again", 
                      [(16,3),(16,4),(17,4),(17,5)], board)
    print

def dropLeftZagTest():
    printTestName()
    board = PlayingBoard()
    piece = LeftZag(board)
    rotateAndDropHelper(piece, board, 0, [(16,3),(16,4),(17,4),(17,5)])

    board = PlayingBoard()
    piece = LeftZag(board)
    rotateAndDropHelper(piece, board, 1, [(15,4),(16,4),(16,3),(17,3)])
    
    board = PlayingBoard()
    piece = LeftZag(board)
    rotateAndDropHelper(piece, board, 2, [(16,3),(16,4),(17,4),(17,5)])

    board = PlayingBoard()
    piece = LeftZag(board)
    rotateAndDropHelper(piece, board, 3, [(15,5),(16,5),(16,4),(17,4)])

    board = PlayingBoard()
    piece = LeftZag(board)
    rotateAndDropHelper(piece, board, 0, [(16,3),(16,4),(17,4),(17,5)])
    print

def rotateLeftZagTest():
    printTestName()
    board = PlayingBoard()
    piece = LeftZag(board)
    # Move piece below top edge to give space to rotate
    doMultipleMoves(piece, 0, 2, 0)
    piece.rotate()
    verifyBoardSparse("LeftZag board after one rotation", 
                      [(1,4),(2,3),(2,4),(3,3)], board)
    piece.rotate()
    verifyBoardSparse("LeftZag board after two rotations", 
                      [(1,3),(1,4),(2,4),(2,5)], board)
    piece.rotate()
    verifyBoardSparse("LeftZag board after three rotations", 
                      [(1,5),(2,5),(2,4),(3,4)], board)
    piece.rotate()
    verifyBoardSparse("LeftZag board after four rotations", 
                      [(2,3),(2,4),(3,4),(3,5)], board)
    print

def moveLeftWithLandscapeLeftZagTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = LeftZag(board)
    doMultipleMoves(piece, -2, 11, 1)
    piece.moveLeft()
    verifyBoardWithLandscape("LeftZag left into landscape--obstructed by long edge", 
                             [(10,2),(11,1),(11,2),(12,1)], board, landscape1)
    doMultipleMoves(piece, 2, 0, 0) # Need to move right before down
    piece.rotate() # Need to rotate before down
    doMultipleMoves(piece, 0, 6, 0)
    piece.moveLeft()
    verifyBoardWithLandscape("LeftZag left into landscape--obstructed by zag", 
                             [(15,3),(15,4),(16,4),(16,5)], board, landscape1)
    print

def moveRightWithLandscapeLeftZagTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = LeftZag(board)
    doMultipleMoves(piece, 4, 12, 1)
    piece.moveRight()
    verifyBoardWithLandscape("LeftZag right into landscape--obstructed by long edge", 
                             [(11,8),(12,7),(12,8),(13,7)], board, landscape1)
    doMultipleMoves(piece, -1, 0, 0) # Need to move left before down
    doMultipleMoves(piece, 0, 4, 0)
    piece.moveRight()
    verifyBoardWithLandscape("LeftZag right into landscape--obstructed by tab", 
                             [(14,7),(15,6),(15,7),(16,6)], board, landscape1)
    print

def moveDownWithLandscapeLeftZagTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = LeftZag(board)
    doMultipleMoves(piece, 5, 10, 1)
    verifyFalse("LeftZag down into landscape--obstructed by zag, return values", 
                  piece.moveDown())
    verifyBoardWithLandscape("LeftZag down into landscape--obstructed by zag", 
                             [(9,9),(10,8),(10,9),(11,8)], board, landscape1)
    doMultipleMoves(piece, -3, 0, 0)  # Move left, then down
    doMultipleMoves(piece, 0, 5, 0)
    verifyTrue("LeftZag down into landscape--barely clear, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("LeftZag down into landscape--barely clear", 
                             [(15,6),(16,5),(16,6),(17,5)], board, landscape1)
    
    # Restart
    board = PlayingBoard()
    setCellsOfBoard(landscape2, board)
    piece = LeftZag(board)
    doMultipleMoves(piece, -3, 10, 0) # Lower into open space and rotate
    verifyFalse("LeftZag down into landscape--hung on tab, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("LeftZag down into landscape--hung on tab", 
                             [(10,0),(10,1),(11,1),(11,2)], board, landscape2)
    doMultipleMoves(piece, 6, 0, 0) # Move left into open space
    piece.rotate() 
    doMultipleMoves(piece, 0, 5, 0) # Lower into "canyon"
    verifyFalse("LeftZag down into landscape--fully obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("LeftZag down into landscape--fully obstructed", 
                             [(14, 7),(15, 6),(15, 7),(16, 6)], board, landscape2)
    print

def rotateWithLandscapeLeftZagTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape2, board)
    piece = LeftZag(board)
    # Need to split into 2 separate moves, else it gets caught the landscape
    doMultipleMoves(piece, 6, 11, 1)
    piece.rotate()
    verifyBoardWithLandscape("LeftZag rotate in landscape--obstructed", 
                             [(10,8),(11,7),(11,8),(12,7)], board, landscape2)

    piece.moveLeft() # gets some room to spin
    doMultipleMoves(piece, 1, 0, 2) 
    piece.rotate()
    verifyBoardWithLandscape("LeftZag rotate in landscape--barely clear", 
                             [(11,6),(11,7),(12,7),(12,8)], board, landscape2)
    print

def leftZagTests():
    """Runs the tests."""
    initialFailureCount = getCountOfFailedTests()
    printTestSetName()
    newPieceTest(LeftZag(PlayingBoard()))
    print
    
    moveLeftLeftZagTest()
    moveRightLeftZagTest()
    moveDownLeftZagTest()
    dropLeftZagTest()
    rotateLeftZagTest()
    
    if getCountOfFailedTests() > initialFailureCount:
        announceAborting("LEFT ZAG")
    else:
        moveLeftWithLandscapeLeftZagTest()
        moveRightWithLandscapeLeftZagTest()
        moveDownWithLandscapeLeftZagTest()
        rotateWithLandscapeLeftZagTest()

if __name__ == '__main__':
    leftZagTests()