# Curt Clifton and Matt Boutell, 19 Jan 2008

from tetrisTestUtilities import *
from Bar import *
from PlayingBoard import *

class RightZig(Bar):
    """This is an implementation of:
        #R
       RR
       where # indicates the center of rotation."""

    def _init_piece(self):
        # Cell offsets are used to calculate which cells (relative to the centroid)
        # are filled by a block in each of the orientations. Rows in the offset 
        # matrix correspond to the four possible orientations.  Cols correspond to
        # the four cells covered.
        self.cellOffsets = [[ (1,-1),  (1,0),  (0,0),  (0,1)],
                            [(-1,-1), (0,-1),  (0,0),  (1,0)],
                            [ (-1,1), (-1,0),  (0,0), (0,-1)],
                            [  (1,1),  (0,1),  (0,0), (-1,0)]]
        self.colorSymbol = "R"

#-----------------------------------------------------------------------------
# RIGHT ZIG TESTS
#-----------------------------------------------------------------------------

def moveLeftRightZigTest():
    printTestName()
    board = PlayingBoard()
    piece = RightZig(board)
    verifyBoardSparse("Initial RightZig board", 
                      [(0,4),(0,5),(1,3),(1,4)], board)
    piece.moveLeft()
    verifyBoardSparse("RightZig board after one moveLeft", 
                      [(0,3),(0,4),(1,2),(1,3)], board)
    doMultipleMoves(piece, -2, 0, 0)
    verifyBoardSparse("RightZig board after moving to left edge", 
                      [(0,1),(0,2),(1,0),(1,1)], board)
    piece.moveLeft()
    verifyBoardSparse("RightZig board after trying to move left again", 
                      [(0,1),(0,2),(1,0),(1,1)], board)
    print

def moveRightRightZigTest():
    printTestName()
    board = PlayingBoard()
    piece = RightZig(board)
    piece.moveRight()
    verifyBoardSparse("RightZig board after one moveRight", 
                      [(0,5),(0,6),(1,4),(1,5)], board)
    doMultipleMoves(piece, 3, 0, 0)
    verifyBoardSparse("RightZig board after moving to right edge", 
                      [(0,8),(0,9),(1,7),(1,8)], board)
    piece.moveRight()
    verifyBoardSparse("RightZig board after trying to move right again", 
                      [(0,8),(0,9),(1,7),(1,8)], board)
    print
    
def moveDownRightZigTest():
    printTestName()
    board = PlayingBoard()
    piece = RightZig(board)
    verifyTrue("RightZig initial moveDown return value", piece.moveDown())
    verifyBoardSparse("RightZig board after one moveDown", 
                      [(1,4),(1,5),(2,3),(2,4)], board)
    doMultipleMoves(piece, 0, 14, 0)
    verifyBoardSparse("RightZig board after moving one space from bottom edge", 
                      [(15,4),(15,5),(16,3),(16,4)], board)

    verifyTrue("RightZig next-to-last moveDown return value", piece.moveDown())
    verifyBoardSparse("RightZig board after trying to move down again", 
                      [(16,4),(16,5),(17,3),(17,4)], board)

    verifyFalse("RightZig last moveDown return value", piece.moveDown())
    verifyBoardSparse("RightZig board after trying to move down again", 
                      [(16,4),(16,5),(17,3),(17,4)], board)
    print

def dropRightZigTest():
    printTestName()
    board = PlayingBoard()
    piece = RightZig(board)
    rotateAndDropHelper(piece, board, 0, [(16,4),(16,5),(17,3),(17,4)])

    board = PlayingBoard()
    piece = RightZig(board)
    rotateAndDropHelper(piece, board, 1, [(15,3),(16,3),(16,4),(17,4)])
    
    board = PlayingBoard()
    piece = RightZig(board)
    rotateAndDropHelper(piece, board, 2, [(16,4),(16,5),(17,3),(17,4)])

    board = PlayingBoard()
    piece = RightZig(board)
    rotateAndDropHelper(piece, board, 3, [(15,4),(16,4),(16,5),(17,5)])

    board = PlayingBoard()
    piece = RightZig(board)
    rotateAndDropHelper(piece, board, 0, [(16,4),(16,5),(17,3),(17,4)])
    print

def rotateRightZigTest():
    printTestName()
    board = PlayingBoard()
    piece = RightZig(board)
    # Move piece below top edge to give space to rotate
    doMultipleMoves(piece, 0, 2, 0)
    piece.rotate()
    verifyBoardSparse("RightZig board after one rotation", 
                      [(1,3),(2,3),(2,4),(3,4)], board)
    piece.rotate()
    verifyBoardSparse("RightZig board after two rotations", 
                      [(1,4),(1,5),(2,3),(2,4)], board)
    piece.rotate()
    verifyBoardSparse("RightZig board after three rotations", 
                      [(1,4),(2,4),(2,5),(3,5)], board)
    piece.rotate()
    verifyBoardSparse("RightZig board after four rotations", 
                      [(2,4),(2,5),(3,3),(3,4)], board)
    print

def moveLeftWithLandscapeRightZigTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = RightZig(board)
    doMultipleMoves(piece, -2, 11, 1)
    piece.moveLeft()
    verifyBoardWithLandscape("RightZig left into landscape--obstructed by long edge", 
                             [(10,1),(11,1),(11,2),(12,2)], board, landscape1)
    doMultipleMoves(piece, 2, 0, 0) # Need to move right before down
    doMultipleMoves(piece, 0, 4, 0)
    piece.moveLeft()
    verifyBoardWithLandscape("RightZig left into landscape--obstructed by tab", 
                             [(14,3),(15,3),(15,4),(16,4)], board, landscape1)
    print

def moveRightWithLandscapeRightZigTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = RightZig(board)
    doMultipleMoves(piece, 3, 11, 0)
    piece.moveRight()
    verifyBoardWithLandscape("RightZig right into landscape--obstructed by tab", 
                             [(11,7),(11,8),(12,6),(12,7)], board, landscape1)
    doMultipleMoves(piece, -1, 0, 0) # Need to move left before down
    doMultipleMoves(piece, 0, 4, 0)
    #piece.moveRight()
    verifyBoardWithLandscape("RightZig right into landscape--obstructed by zig", 
                             [(15,6),(15,7),(16,5),(16,6)], board, landscape1)
    print

def moveDownWithLandscapeRightZigTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = RightZig(board)
    doMultipleMoves(piece, -3, 10, 1)
    verifyFalse("RightZig down into landscape--obstructed by zig, return values", 
                  piece.moveDown())
    verifyBoardWithLandscape("RightZig down into landscape--obstructed by zig", 
                             [(9,0),(10,0),(10,1),(11,1)], board, landscape1)
    doMultipleMoves(piece, 4, 0, 0)  # Move right, then down
    doMultipleMoves(piece, 0, 6, 0)
    verifyFalse("RightZig down into landscape--barely clear, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("RightZig down into landscape--barely clear", 
                             [(15,4),(16,4),(16,5),(17,5)], board, landscape1)
    
    # Restart
    board = PlayingBoard()
    setCellsOfBoard(landscape2, board)
    piece = RightZig(board)
    doMultipleMoves(piece, 4, 10, 0) # Lower into open space and rotate
    verifyFalse("RightZig down into landscape--hung on tab, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("RightZig down into landscape--hung on tab", 
                             [(10,8),(10,9),(11,7),(11,8)], board, landscape2)
    doMultipleMoves(piece, -2, 0, 0) # Move left into open space 
    doMultipleMoves(piece, 0, 5, 0) # Lower into "canyon"
    verifyFalse("RightZig down into landscape--fully obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("RightZig down into landscape--fully obstructed", 
                             [(16, 5),(16, 6),(15, 6),(15, 7)], board, landscape2)
    print

def rotateWithLandscapeRightZigTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape2, board)
    piece = RightZig(board)
    # Need to split into 2 separate moves, else it gets caught the landscape
    doMultipleMoves(piece, -3, 11, 3)
    piece.rotate()
    verifyBoardWithLandscape("RightZig rotate in landscape--obstructed", 
                             [(10,1),(11,1),(11,2),(12,2)], board, landscape2)

    doMultipleMoves(piece, 1, 0, 0)
    piece.rotate()
    verifyBoardWithLandscape("RightZig rotate in landscape--barely clear", 
                             [(11,2),(11,3),(12,1),(12,2)], board, landscape2)
    print

def rightZigTests():
    """Runs the tests."""
    initialFailureCount = getCountOfFailedTests()
    printTestSetName()
    newPieceTest(RightZig(PlayingBoard()))
    print
    
    moveLeftRightZigTest()
    moveRightRightZigTest()
    moveDownRightZigTest()
    dropRightZigTest()
    rotateRightZigTest()
    
    if getCountOfFailedTests() > initialFailureCount:
        announceAborting("RIGHT ZIG")
    else:
        moveLeftWithLandscapeRightZigTest()
        moveRightWithLandscapeRightZigTest()
        moveDownWithLandscapeRightZigTest()
        rotateWithLandscapeRightZigTest()


if __name__ == '__main__':
    rightZigTests()
    