# Matt Boutell and Curt Clifton, 19 Jan 2008

from tetrisTestUtilities import *
from Bar import *
from PlayingBoard import *

class Jay(Bar):
    """This is an implementation of:
       J#J
         J
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
        self.cellOffsets = [[(0, -1), (0, 0), (0, 1), (1, 1)],
                            [(1, -1), (1, 0), (0, 0), (-1, 0)],
                            [(-1, -1), (0, -1), (0, 0), (0, 1)],
                            [(-1, 0), (0, 0), (1, 0), (-1, 1)]]
        self.colorSymbol = "J"
        self._addToBoard()

#-----------------------------------------------------------------------------
# JAY TESTS
#-----------------------------------------------------------------------------

def moveLeftJayTest():
    printTestName()
    board = PlayingBoard()
    piece = Jay(board)
    verifyBoardSparse("Initial Jay board", 
                      [(0,3),(0,4),(0,5),(1,5)], board)
    piece.moveLeft()
    verifyBoardSparse("Jay board after one moveLeft", 
                      [(0,2),(0,3),(0,4),(1,4)], board)
    doMultipleMoves(piece, -2, 0, 0)
    verifyBoardSparse("Jay board after moving to left edge", 
                      [(0,0),(0,1),(0,2),(1,2)], board)
    piece.moveLeft()
    verifyBoardSparse("Jay board after trying to move left again", 
                      [(0,0),(0,1),(0,2),(1,2)], board)
    print

def moveRightJayTest():
    printTestName()
    board = PlayingBoard()
    piece = Jay(board)
    piece.moveRight()
    verifyBoardSparse("Jay board after one moveRight", 
                      [(0,4),(0,5),(0,6),(1,6)], board)
    doMultipleMoves(piece, 3, 0, 0)
    verifyBoardSparse("Jay board after moving to right edge", 
                      [(0,7),(0,8),(0,9),(1,9)], board)
    piece.moveRight()
    verifyBoardSparse("Jay board after trying to move right again", 
                      [(0,7),(0,8),(0,9),(1,9)], board)
    print
    
def moveDownJayTest():
    printTestName()
    board = PlayingBoard()
    piece = Jay(board)
    verifyTrue("Jay initial moveDown return value", piece.moveDown())
    verifyBoardSparse("Jay board after one moveDown", 
                      [(1,3),(1,4),(1,5),(2,5)], board)
    doMultipleMoves(piece, 0, 14, 0)
    verifyBoardSparse("Jay board after moving one space from bottom edge", 
                      [(15,3),(15,4),(15,5),(16,5)], board)

    verifyTrue("Jay next-to-last moveDown return value", piece.moveDown())
    verifyBoardSparse("Jay board after trying to move down again", 
                      [(16,3),(16,4),(16,5),(17,5)], board)

    verifyFalse("Jay last moveDown return value", piece.moveDown())
    verifyBoardSparse("Jay board after trying to move down again", 
                      [(16,3),(16,4),(16,5),(17,5)], board)
    print

def dropJayTest():
    printTestName()
    board = PlayingBoard()
    piece = Jay(board)
    rotateAndDropHelper(piece, board, 0, [(16,3),(16,4),(16,5),(17,5)])

    board = PlayingBoard()
    piece = Jay(board)
    rotateAndDropHelper(piece, board, 1, [(15,4),(16,4),(17,4),(17,3)])
    
    board = PlayingBoard()
    piece = Jay(board)
    rotateAndDropHelper(piece, board, 2, [(17,3),(17,4),(17,5),(16,3)])

    board = PlayingBoard()
    piece = Jay(board)
    rotateAndDropHelper(piece, board, 3, [(15,4),(16,4),(17,4),(15,5)])

    board = PlayingBoard()
    piece = Jay(board)
    rotateAndDropHelper(piece, board, 0, [(16,3),(16,4),(16,5),(17,5)])
    print

def rotateJayTest():
    printTestName()
    board = PlayingBoard()
    piece = Jay(board)
    # Move piece below top edge to give space to rotate
    doMultipleMoves(piece, 0, 2, 0)
    piece.rotate()
    verifyBoardSparse("Jay board after one rotation", 
                      [(1,4),(2,4),(3,4),(3,3)], board)
    piece.rotate()
    verifyBoardSparse("Jay board after two rotations", 
                      [(2,3),(2,4),(2,5),(1,3)], board)
    piece.rotate()
    verifyBoardSparse("Jay board after three rotations", 
                      [(1,4),(2,4),(3,4),(1,5)], board)
    piece.rotate()
    verifyBoardSparse("Jay board after four rotations", 
                      [(2,3),(2,4),(2,5),(3,5)], board)
    print

def moveLeftWithLandscapeJayTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Jay(board)
    doMultipleMoves(piece, -2, 10, 1)
    piece.moveLeft()
    verifyBoardWithLandscape("Jay left into landscape--partially obstructed", 
                             [(9,2),(10,2),(11,2),(11,1)], board, landscape1)
    doMultipleMoves(piece, -1, 3, 2)
    piece.moveLeft()
    verifyBoardWithLandscape("Jay left into landscape--fully obstructed", 
                             [(12,1),(13,1),(14,1),(12,2)], board, landscape1)
    print

def moveRightWithLandscapeJayTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Jay(board)
    doMultipleMoves(piece, 3, 10, 0)
    piece.moveRight()
    verifyBoardWithLandscape("Jay right into landscape--partially obstructed", 
                             [(10,6),(10,7),(10,8),(11,8)], board, landscape1)
    doMultipleMoves(piece, 0, 2, 0)
    piece.moveRight()
    verifyBoardWithLandscape("Jay right into landscape--fully obstructed", 
                             [(12,6),(12,7),(12,8),(13,8)], board, landscape1)
    print

def moveDownWithLandscapeJayTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Jay(board)
    doMultipleMoves(piece, -3, 10, 0)
    verifyFalse("Jay down into landscape--partially obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Jay down into landscape--partially obstructed", 
                             [(10,0),(10,1),(10,2),(11,2)], board, landscape1)

    # Split up so it doesn't get caught
    doMultipleMoves(piece, 3, 0, 0)
    doMultipleMoves(piece, 0, 0, 3)
    doMultipleMoves(piece, 4, 1, 0)
    
    verifyFalse("Jay down into landscape--partially obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Jay down into landscape--partially obstructed", 
                             [(10,8),(11,8),(12,8),(10,9)], board, landscape1)
    
    # Restart
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Jay(board)
    doMultipleMoves(piece, -2, 3, 3) # Lower into open space and rotate
    doMultipleMoves(piece, 0, 13, 0) # Lower into "canyon"
    verifyFalse("Jay down into landscape--fully obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Jay down into landscape--fully obstructed", 
                             [(15, 2),(16, 2),(17, 2),(15,3)], board, landscape1)
    print

def rotateWithLandscapeJayTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Jay(board)
    # Need to split into 2 separate moves, else it gets caught the landscape
    doMultipleMoves(piece, 1, 10, 3)
    doMultipleMoves(piece, 0, 6, 0)
    piece.rotate()
    verifyBoardWithLandscape("Jay rotate in landscape--barely clear", 
                             [(16,4),(16,5),(16,6),(17,6)], board, landscape1)
    piece.rotate()
    verifyBoardWithLandscape("Jay rotate in landscape--obstructed", 
                             [(16,4),(16,5),(16,6),(17,6)], board, landscape1)
    print

def jayTests():
    """Runs the tests."""
    initialFailureCount = getCountOfFailedTests()
    printTestSetName()
    newPieceTest(Jay(PlayingBoard()))
    print
    
    moveLeftJayTest()
    moveRightJayTest()
    moveDownJayTest()
    dropJayTest()
    rotateJayTest()
    
    if getCountOfFailedTests() > initialFailureCount:
        announceAborting("JAY")
    else:
        moveLeftWithLandscapeJayTest()
        moveRightWithLandscapeJayTest()
        moveDownWithLandscapeJayTest()
        rotateWithLandscapeJayTest()

if __name__ == '__main__':
    jayTests()