# Matt Boutell and Curt Clifton, 19 Jan 2008

from tetrisTestUtilities import *
from Bar import *
from PlayingBoard import *

class Tee(Bar):
    """This is an implementation of:
       T#T
        T
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
        self.cellOffsets = [[(0,-1), (0, 0), (0, 1), (1, 0)],
                            [(-1, 0), (0, 0), (1, 0), (0, -1)],
                            [(-1, 0), (0, -1), (0, 0), (0, 1)],
                            [(-1, 0), (0, 0), (1, 0), (0, 1)]]
        self.colorSymbol = "T"
        self._addToBoard()



#-----------------------------------------------------------------------------
# TEE TESTS
#-----------------------------------------------------------------------------

def moveLeftTeeTest():
    printTestName()
    board = PlayingBoard()
    piece = Tee(board)
    verifyBoardSparse("Initial Tee board", 
                      [(0,3),(0,4),(0,5),(1,4)], board)
    piece.moveLeft()
    verifyBoardSparse("Tee board after one moveLeft", 
                      [(0,2),(0,3),(0,4),(1,3)], board)
    doMultipleMoves(piece, -2, 0, 0)
    verifyBoardSparse("Tee board after moving to left edge", 
                      [(0,0),(0,1),(0,2),(1,1)], board)
    piece.moveLeft()
    verifyBoardSparse("Tee board after trying to move left again", 
                      [(0,0),(0,1),(0,2),(1,1)], board)
    print

def moveRightTeeTest():
    printTestName()
    board = PlayingBoard()
    piece = Tee(board)
    piece.moveRight()
    verifyBoardSparse("Tee board after one moveRight", 
                      [(0,4),(0,5),(0,6),(1,5)], board)
    doMultipleMoves(piece, 3, 0, 0)
    verifyBoardSparse("Tee board after moving to right edge", 
                      [(0,7),(0,8),(0,9),(1,8)], board)
    piece.moveRight()
    verifyBoardSparse("Tee board after trying to move right again", 
                      [(0,7),(0,8),(0,9),(1,8)], board)
    print
    
def moveDownTeeTest():
    printTestName()
    board = PlayingBoard()
    piece = Tee(board)
    verifyTrue("Tee initial moveDown return value", piece.moveDown())
    verifyBoardSparse("Tee board after one moveDown", 
                      [(1,3),(1,4),(1,5),(2,4)], board)
    doMultipleMoves(piece, 0, 14, 0)
    verifyBoardSparse("Tee board after moving one space from bottom edge", 
                      [(15,3),(15,4),(15,5),(16,4)], board)

    verifyTrue("Tee next-to-last moveDown return value", piece.moveDown())
    verifyBoardSparse("Tee board after trying to move down again", 
                      [(16,3),(16,4),(16,5),(17,4)], board)

    verifyFalse("Tee last moveDown return value", piece.moveDown())
    verifyBoardSparse("Tee board after trying to move down again", 
                      [(16,3),(16,4),(16,5),(17,4)], board)
    print

def dropTeeTest():
    printTestName()
    board = PlayingBoard()
    piece = Tee(board)
    rotateAndDropHelper(piece, board, 0, [(16,3),(16,4),(16,5),(17,4)])

    board = PlayingBoard()
    piece = Tee(board)
    rotateAndDropHelper(piece, board, 1, [(15,4),(16,4),(17,4),(16,3)])
    
    board = PlayingBoard()
    piece = Tee(board)
    rotateAndDropHelper(piece, board, 2, [(17,3),(17,4),(17,5),(16,4)])

    board = PlayingBoard()
    piece = Tee(board)
    rotateAndDropHelper(piece, board, 3, [(15,4),(16,4),(17,4),(16,5)])

    board = PlayingBoard()
    piece = Tee(board)
    rotateAndDropHelper(piece, board, 0, [(16,3),(16,4),(16,5),(17,4)])
    print

def rotateTeeTest():
    printTestName()
    board = PlayingBoard()
    piece = Tee(board)
    # Move piece below top edge to give space to rotate
    doMultipleMoves(piece, 0, 2, 0)
    piece.rotate()
    verifyBoardSparse("Tee board after one rotation", 
                      [(1,4),(2,4),(3,4),(2,3)], board)
    piece.rotate()
    verifyBoardSparse("Tee board after two rotations", 
                      [(2,3),(2,4),(2,5),(1,4)], board)
    piece.rotate()
    verifyBoardSparse("Tee board after three rotations", 
                      [(1,4),(2,4),(3,4),(2,5)], board)
    piece.rotate()
    verifyBoardSparse("Tee board after four rotations", 
                      [(2,3),(2,4),(2,5),(3,4)], board)
    print

def moveLeftWithLandscapeTeeTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Tee(board)
    doMultipleMoves(piece, -2, 11, 1)
    piece.moveLeft()
    verifyBoardWithLandscape("Tee left into landscape--partially obstructed", 
                             [(10,2),(11,2),(12,2),(11,1)], board, landscape1)
    doMultipleMoves(piece, -1, 2, 2)
    piece.moveLeft()
    verifyBoardWithLandscape("Tee left into landscape--fully obstructed", 
                             [(12,1),(13,1),(14,1),(13,2)], board, landscape1)
    print

def moveRightWithLandscapeTeeTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Tee(board)
    doMultipleMoves(piece, 3, 11, 3)
    piece.moveRight()
    verifyBoardWithLandscape("Tee right into landscape--partially obstructed", 
                             [(10,7),(11,7),(12,7),(11,8)], board, landscape1)
    doMultipleMoves(piece, 1, 2, 2)
    piece.moveRight()
    verifyBoardWithLandscape("Tee right into landscape--fully obstructed", 
                             [(12,8),(13,8),(14,8),(13,7)], board, landscape1)
    print

def moveDownWithLandscapeTeeTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Tee(board)
    doMultipleMoves(piece, -3, 10, 1)
    verifyFalse("Tee down into landscape--partially obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Tee down into landscape--partially obstructed", 
                             [(9,1),(10,1),(11,1),(10,0)], board, landscape1)

    doMultipleMoves(piece, 7, 0, 1)  
    verifyFalse("Tee down into landscape--partially obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Tee down into landscape--partially obstructed", 
                             [(10,7),(10,8),(10,9),(9,8)], board, landscape1)
    
    # Restart
    board = PlayingBoard()
    setCellsOfBoard(landscape2, board)
    piece = Tee(board)
    doMultipleMoves(piece, 2, 10, 3) # Lower into open space and rotate
    doMultipleMoves(piece, 0, 5, 0) # Lower into "canyon"
    verifyFalse("Tee down into landscape--fully obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Tee down into landscape--fully obstructed", 
                             [(14, 6),(15, 6),(16, 6),(15,7)], board, landscape2)
    doMultipleMoves(piece, -1, 0, 0) # Move left into open space 
    doMultipleMoves(piece, 0, 0, 1) # Rotate 
    doMultipleMoves(piece, 0, 1, 0) # Lower into "canyon"
    verifyFalse("Tee down into landscape--fully obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Tee down into landscape--fully obstructed", 
                             [(16, 4),(16, 5),(16, 6),(17,5)], board, landscape2)
    print

def rotateWithLandscapeTeeTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape2, board)
    piece = Tee(board)
    # Need to split into 2 separate moves, else it gets caught the landscape
    doMultipleMoves(piece, 0, 10, 3)
    doMultipleMoves(piece, 0, 5, 0)
    piece.rotate()
    verifyBoardWithLandscape("Tee rotate in landscape--obstructed", 
                             [(14,4),(15,4),(16,4),(15,5)], board, landscape2)

    doMultipleMoves(piece, 2, 0, 0)
    piece.rotate()
    verifyBoardWithLandscape("Tee rotate in landscape--barely clear", 
                             [(15,5),(15,6),(15,7),(16,6)], board, landscape2)
    print

def teeTests():
    """Runs the tests."""
    initialFailureCount = getCountOfFailedTests()
    printTestSetName()
    newPieceTest(Tee(PlayingBoard()))
    print
    
    moveLeftTeeTest()
    moveRightTeeTest()
    moveDownTeeTest()
    dropTeeTest()
    rotateTeeTest()
    
    if getCountOfFailedTests() > initialFailureCount:
        announceAborting("TEE")
    else:
        moveLeftWithLandscapeTeeTest()
        moveRightWithLandscapeTeeTest()
        moveDownWithLandscapeTeeTest()
        rotateWithLandscapeTeeTest()

if __name__ == '__main__':
    teeTests()