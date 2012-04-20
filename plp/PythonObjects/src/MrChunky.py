# Curt Clifton and Matt Boutell, 17 Jan 2008

# Tasks:
#  - We will reimplement this together in class.

from tetrisTestUtilities import *
from PlayingBoard import *
from Bar import Bar

class MrChunky(Bar):
    """This is an implementation of:
       MM
       MM
       MrChunky doesn't rotate!"""
       
    def __init__(self, board):
        self.row = 0
        self.col = (board.getWidth()-1)/2
        self.orientation = 0
        self.board = board
        # Cell offsets are used to calculate which cells (relative to the centroid)
        # are filled by a block in each of the orientations. Rows in the offset 
        # matrix correspond to the four possible orientations.  Cols correspond to
        # the four cells covered.
        self.cellOffsets = [[(0,0),  (0,1),  (1,1), (1,0)]]
        self.colorSymbol = "M"
        self._addToBoard()
        
    def rotate(self):
        """ Rotates the piece clockwise if possible; otherwise leaves it unchanged."""
        return self._moveHelper((lambda r, c, o : (r, c, o)))
       

#-----------------------------------------------------------------------------
# MR CHUNKY TESTS
#-----------------------------------------------------------------------------
    
def moveLeftMrChunkyTest():
    printTestName()
    board = PlayingBoard()
    piece = MrChunky(board)
    verifyBoardSparse("Initial MrChunky board", 
                      [(0,4),(0,5),(1,4),(1,5)], board)
    piece.moveLeft()
    verifyBoardSparse("MrChunky board after one moveLeft", 
                      [(0,3),(0,4),(1,3),(1,4)], board)
    doMultipleMoves(piece, -3, 0, 0)
    verifyBoardSparse("MrChunky board after moving to left edge", 
                      [(0,0),(0,1),(1,0),(1,1)], board)
    piece.moveLeft()
    verifyBoardSparse("MrChunky board after trying to move left again", 
                      [(0,0),(0,1),(1,0),(1,1)], board)
    print

def moveRightMrChunkyTest():
    printTestName()
    board = PlayingBoard()
    piece = MrChunky(board)
    piece.moveRight()
    verifyBoardSparse("MrChunky board after one moveRight", 
                      [(0,5),(0,6),(1,5),(1,6)], board)
    doMultipleMoves(piece, 4, 0, 0)
    verifyBoardSparse("MrChunky board after moving to right edge", 
                      [(0,8),(0,9),(1,8),(1,9)], board)
    piece.moveRight()
    verifyBoardSparse("MrChunky board after trying to move right again", 
                      [(0,8),(0,9),(1,8),(1,9)], board)
    print
    
def moveDownMrChunkyTest():
    printTestName()
    board = PlayingBoard()
    piece = MrChunky(board)
    verifyTrue("MrChunky initial moveDown return value", piece.moveDown())
    verifyBoardSparse("MrChunky board after one moveDown", 
                      [(1,4),(1,5),(2,4),(2,5)], board)
    doMultipleMoves(piece, 0, 14, 0)
    verifyBoardSparse("MrChunky board after moving one space from bottom edge", 
                      [(15,4),(15,5),(16,4),(16,5)], board)

    verifyTrue("MrChunky next-to-last moveDown return value", piece.moveDown())
    verifyBoardSparse("MrChunky board after trying to move down again", 
                      [(16,4),(16,5),(17,4),(17,5)], board)

    verifyFalse("MrChunky last moveDown return value", piece.moveDown())
    verifyBoardSparse("MrChunky board after trying to move down again", 
                      [(16,4),(16,5),(17,4),(17,5)], board)
    print

def dropMrChunkyTest():
    printTestName()
    board = PlayingBoard()
    piece = MrChunky(board)
    piece.drop()
    verifyBoardSparse("MrChunky board after drop", 
                      [(16,4),(16,5),(17,4),(17,5)], board)
    piece.drop()
    verifyBoardSparse("MrChunky board after trying to drop again", 
                      [(16,4),(16,5),(17,4),(17,5)], board)
    print

def rotateMrChunkyTest():
    printTestName()
    board = PlayingBoard()
    piece = MrChunky(board)
    piece.rotate()
    verifyBoardSparse("MrChunky board after one rotation", 
                      [(0,4),(0,5),(1,4),(1,5)], board)
    print

def moveLeftWithLandscapeMrChunkyTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = MrChunky(board)
    doMultipleMoves(piece, -3, 10, 0)
    piece.moveLeft()
    verifyBoardWithLandscape("MrChunky left into landscape--partially obstructed", 
                             [(10,1),(10,2),(11,1),(11,2)], board, landscape1)
    doMultipleMoves(piece, 0, 4, 0)
    piece.moveLeft()
    verifyBoardWithLandscape("MrChunky left into landscape--fully obstructed", 
                             [(14,1),(14,2),(15,1),(15,2)], board, landscape1)
    print

def moveRightWithLandscapeMrChunkyTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = MrChunky(board)
    doMultipleMoves(piece, 3, 10, 0)
    piece.moveRight()
    verifyBoardWithLandscape("MrChunky right into landscape--partially obstructed", 
                             [(10,7),(10,8),(11,7),(11,8)], board, landscape1)
    doMultipleMoves(piece, 0, 2, 0)
    piece.moveRight()
    verifyBoardWithLandscape("MrChunky right into landscape--fully obstructed", 
                             [(12,7),(12,8),(13,7),(13,8)], board, landscape1)
    print

def moveDownWithLandscapeMrChunkyTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = MrChunky(board)
    doMultipleMoves(piece, 0, 15, 0)
    verifyFalse("MrChunky down into landscape--partially obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("MrChunky down into landscape--partially obstructed", 
                             [(15,4),(15,5),(16,4),(16,5)], board, landscape1)
    # Need new everything, since piece bottomed out above
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = MrChunky(board)
    doMultipleMoves(piece, 3, 14, 0) # Lower into "canyon"
    verifyFalse("MrChunky down into landscape--fully obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("MrChunky down into landscape--fully obstructed", 
                             [(14, 7),(14, 8),(15, 7),(15, 8)], board, landscape1)
    print

def mrChunkyTests():
    """Runs the tests."""
    initialFailureCount = getCountOfFailedTests()
    printTestSetName()
    newPieceTest(MrChunky(PlayingBoard()))
    print
    
    moveLeftMrChunkyTest()
    moveRightMrChunkyTest()
    moveDownMrChunkyTest()
    dropMrChunkyTest()
    rotateMrChunkyTest()
    
    if getCountOfFailedTests() > initialFailureCount:
        announceAborting("MR CHUNKY")
    else:
        moveLeftWithLandscapeMrChunkyTest()
        moveRightWithLandscapeMrChunkyTest()
        moveDownWithLandscapeMrChunkyTest()

if __name__ == '__main__':
    mrChunkyTests()