# Curt Clifton and Matt Boutell, 17 Jan 2008
# Points: 5 / 5
from tetrisTestUtilities import *
from PlayingBoard import *

class Bar:
    """This is an implementation of:
       B#BB
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
        self.cellOffsets = [[ (0,-1),  (0,0),  (0,1),  (0,2)],
                            [ (-1,0),  (0,0),  (1,0),  (2,0)],
                            [ (0,-2), (0,-1),  (0,0),  (0,1)],
                            [ (-2,0), (-1,0),  (0,0),  (1,0)]]
        self.colorSymbol = "B"
        self._addToBoard()

    def _addToBoard(self):
        """Sets cells on the board to represent this piece."""
        locations = self._cellsCovered(self.row, self.col, self.orientation)
        for loc in locations:
            self.board.setCellSymbol(loc[0],loc[1],self.colorSymbol)
    
    def _cellsCovered(self, row, col, orientation):
        """Returns a list of the coordinates that would be covered by this piece
        with centroid in the given row and column."""
        if not orientation in range(4):
            print "ERROR: invalid orientation"
        cells = []
        for rowOffset, colOffset in self.cellOffsets[orientation]:
            cells.append((row+rowOffset, col+colOffset))
        return cells

    def _cellOutOfBounds(self, cellList):
        for cell in cellList:
            if cell[0] < 0 or cell[0] >= self.board.getHeight() or \
                    cell[1] < 0 or cell[1] >= self.board.getWidth():
                return True
        return False
    
    def _moveHelper(self, positionModifier):
        """Performs the move specified by the position modifier function if possible,
        returning true in that case.  Otherwise, leaves the board unchanged and
        returns false."""
        newR, newC, newO = positionModifier(self.row, self.col, self.orientation)
        if newO > len(self.cellOffsets) - 1:
            newO = 0
        maybeNewCells = self._cellsCovered(newR, newC, newO)
        if self._cellOutOfBounds(maybeNewCells):
            return
        # Remove self, so we don't "bump into ourselves"
        currentCells = self._cellsCovered(self.row, self.col, self.orientation)
        self.board.clearCells(currentCells)
        if self.board.areCellsClear(maybeNewCells):
            self.row, self.col, self.orientation = newR, newC, newO
            newCells = maybeNewCells
            couldMove = True
        else:
            newCells = currentCells
            couldMove = False
        for (r,c) in newCells:
            self.board.setCellSymbol(r, c, self.colorSymbol)
        return couldMove
        
    
    def moveLeft(self):
        """ Moves the piece left if possible; otherwise leaves it unchanged."""
        return self._moveHelper((lambda r, c, o : (r, c - 1, o)))
    
    def moveRight(self):
        """ Moves the piece right if possible; otherwise leaves it unchanged."""
        return self._moveHelper((lambda r, c, o : (r, c + 1, o)))

    def moveDown(self):
        """ Moves the piece down one row if possible, returning True in that case;
        otherwise leaves it unchanged and returns false."""
        return self._moveHelper((lambda r, c, o : (r + 1, c, o)))

    def drop(self):
        """ Moves the piece down as far as possible."""
        while self.moveDown():
            pass

    def rotate(self):
        """ Rotates the piece clockwise if possible; otherwise leaves it unchanged."""
        return self._moveHelper((lambda r, c, o : (r, c, o + 1)))


#-----------------------------------------------------------------------------
# BAR TESTS
#-----------------------------------------------------------------------------

def moveLeftBarTest():
    printTestName()
    board = PlayingBoard()
    piece = Bar(board)
    verifyBoardSparse("Initial Bar board", 
                      [(0,3),(0,4),(0,5),(0,6)], board)
    piece.moveLeft()
    verifyBoardSparse("Bar board after one moveLeft", 
                      [(0,2),(0,3),(0,4),(0,5)], board)
    doMultipleMoves(piece, -2, 0, 0)
    verifyBoardSparse("Bar board after moving to left edge", 
                      [(0,0),(0,1),(0,2),(0,3)], board)
    piece.moveLeft()
    verifyBoardSparse("Bar board after trying to move left again", 
                      [(0,0),(0,1),(0,2),(0,3)], board)
    print

def moveRightBarTest():
    printTestName()
    board = PlayingBoard()
    piece = Bar(board)
    piece.moveRight()
    verifyBoardSparse("Bar board after one moveRight", 
                      [(0,4),(0,5),(0,6),(0,7)], board)
    doMultipleMoves(piece, 3, 0, 0)
    verifyBoardSparse("Bar board after moving to right edge", 
                      [(0,6),(0,7),(0,8),(0,9)], board)
    piece.moveRight()
    verifyBoardSparse("Bar board after trying to move right again", 
                      [(0,6),(0,7),(0,8),(0,9)], board)
    print
    
def moveDownBarTest():
    printTestName()
    board = PlayingBoard()
    piece = Bar(board)
    verifyTrue("Bar initial moveDown return value", piece.moveDown())
    verifyBoardSparse("Bar board after one moveDown", 
                      [(1,3),(1,4),(1,5),(1,6)], board)
    doMultipleMoves(piece, 0, 15, 0)
    verifyBoardSparse("Bar board after moving one space from bottom edge", 
                      [(16,3),(16,4),(16,5),(16,6)], board)

    verifyTrue("Bar next-to-last moveDown return value", piece.moveDown())
    verifyBoardSparse("Bar board after trying to move down again", 
                      [(17,3),(17,4),(17,5),(17,6)], board)

    verifyFalse("Bar last moveDown return value", piece.moveDown())
    verifyBoardSparse("Bar board after trying to move down again", 
                      [(17,3),(17,4),(17,5),(17,6)], board)
    print

def dropBarTest():
    printTestName()
    board = PlayingBoard()
    piece = Bar(board)
    rotateAndDropHelper(piece, board, 0, [(17,3),(17,4),(17,5),(17,6)])
    
    board = PlayingBoard()
    piece = Bar(board)
    rotateAndDropHelper(piece, board, 1, [(14,4),(15,4),(16,4),(17,4)])
    
    board = PlayingBoard()
    piece = Bar(board)
    rotateAndDropHelper(piece, board, 2, [(17,2),(17,3),(17,4),(17,5)])

    board = PlayingBoard()
    piece = Bar(board)
    rotateAndDropHelper(piece, board, 3, [(14,4),(15,4),(16,4),(17,4)])

    board = PlayingBoard()
    piece = Bar(board)
    rotateAndDropHelper(piece, board, 4, [(17,3),(17,4),(17,5),(17,6)])
    print
    

def rotateBarTest():
    printTestName()
    board = PlayingBoard()
    piece = Bar(board)
    # Move piece below top edge to give space to rotate
    doMultipleMoves(piece, 0, 2, 0)
    piece.rotate()
    verifyBoardSparse("Bar board after one rotation", 
                      [(1,4),(2,4),(3,4),(4,4)], board)
    piece.rotate()
    verifyBoardSparse("Bar board after two rotations", 
                      [(2,2),(2,3),(2,4),(2,5)], board)
    piece.rotate()
    verifyBoardSparse("Bar board after three rotations", 
                      [(0,4),(1,4),(2,4),(3,4)], board)
    piece.rotate()
    verifyBoardSparse("Bar board after four rotations", 
                      [(2,3),(2,4),(2,5),(2,6)], board)
    print

def moveLeftWithLandscapeBarTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Bar(board)
    doMultipleMoves(piece, -2, 10, 1)
    piece.moveLeft()
    verifyBoardWithLandscape("Bar left into landscape--partially obstructed", 
                             [(9,1),(10,1),(11,1),(12,1)], board, landscape1)
    doMultipleMoves(piece, 0, 4, 0)
    piece.moveLeft()
    verifyBoardWithLandscape("Bar left into landscape--fully obstructed", 
                             [(13,1),(14,1),(15,1),(16,1)], board, landscape1)
    print

def moveRightWithLandscapeBarTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Bar(board)
    doMultipleMoves(piece, 4, 10, 1)
    piece.moveRight()
    verifyBoardWithLandscape("Bar right into landscape--partially obstructed", 
                             [(9,8),(10,8),(11,8),(12,8)], board, landscape1)
    doMultipleMoves(piece, 0, 2, 0)
    piece.moveRight()
    verifyBoardWithLandscape("Bar right into landscape--fully obstructed", 
                             [(11,8),(12,8),(13,8),(14,8)], board, landscape1)
    print

def moveDownWithLandscapeBarTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Bar(board)
    doMultipleMoves(piece, 3, 10, 0)
    verifyFalse("Bar down into landscape--partially obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Bar down into landscape--partially obstructed", 
                             [(10,6),(10,7),(10,8),(10,9)], board, landscape1)
    # Need new everything, since piece bottomed out above
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Bar(board)
    doMultipleMoves(piece, 0, 3, 3) # Lower into open space and rotate
    doMultipleMoves(piece, 0, 12, 0) # Lower into "canyon"
    verifyFalse("Bar down into landscape--fully obstructed, return value", 
                  piece.moveDown())
    verifyBoardWithLandscape("Bar down into landscape--fully obstructed", 
                             [(13, 4),(14, 4),(15, 4),(16, 4)], board, landscape1)
    print

def rotateWithLandscapeBarTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    piece = Bar(board)
    doMultipleMoves(piece, -2, 11, 0)
    piece.rotate()
    verifyBoardWithLandscape("Bar rotate in landscape--barely clear", 
                             [(10,2),(11,2),(12,2),(13,2)], board, landscape1)
    piece.rotate()
    verifyBoardWithLandscape("Bar rotate in landscape--obstructed", 
                             [(10,2),(11,2),(12,2),(13,2)], board, landscape1)
    print

def barTests():
    """Runs the tests."""
    initialFailureCount = getCountOfFailedTests()
    printTestSetName()
    newPieceTest(Bar(PlayingBoard()))
    print
    
    moveLeftBarTest()
    moveRightBarTest()
    moveDownBarTest()
    dropBarTest()
    rotateBarTest()
    
    if getCountOfFailedTests() > initialFailureCount:
        announceAborting("BAR")
    else:
        moveLeftWithLandscapeBarTest()
        moveRightWithLandscapeBarTest()
        moveDownWithLandscapeBarTest()
        rotateWithLandscapeBarTest()

if __name__ == '__main__':
    barTests()