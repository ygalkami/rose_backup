# This represents the actual board and stores the landscape.
# by Matt Boutell and Curt Clifton, 18 Jan 2008

# Tasks: 
#  - Complete the implementation of clearLines
#  - You may add additional code, but the functionality of the other given methods
#    should not change.  Otherwise the tests may fail.

from tetrisTestUtilities import *

class PlayingBoard:
    """The Tetris playing board.  The default board has 18 rows and 10 columns."""
    
    default_num_cols = 10
    default_num_rows = 18
    clear = " "
    
    def __init__(self, rows=default_num_rows, 
                 cols=default_num_cols):
        self.contents = [[PlayingBoard.clear] * cols for row in range(rows)]
        self.num_rows = rows
        self.num_cols = cols

    def getWidth(self):
        """ Returns the width of the board (number of columns)""" 
        return self.num_cols
    
    def getHeight(self):
        """ Returns the height of the board (number of rows)""" 
        return self.num_rows

    def __isFull(self, row):
        for s in row:
            if s == PlayingBoard.clear:
                return False
        return True
    
    def clearLines(self):
        """Checks for completed lines on this board, clears all such lines, and
        returns a list of the row indexes of the cleared lines.  Will return an 
        empty list if no lines were cleared."""
        # TODO: implement clearLines per the specification
        clearedLines = []
        for r in range(self.num_rows):
            if self.__isFull(self.contents[r]):
                self.contents.pop(r)
                self.contents.insert(0,[PlayingBoard.clear]*self.num_cols)
                clearedLines.append(r)
        return clearedLines
    
    def getCellSymbol(self, row, col):
        """Returns the symbol in the given row and column."""
        return self.contents[row][col]
    
    def setCellSymbol(self, row, col, symbol):
        """Sets the symbol in the given row and column to the given symbol.
        The symbol should be a single character string."""
        self.contents[row][col] = symbol
    
    def clearCells(self, cellRowColList):
        """Clears the cells specified by the given list of (row,column) pairs."""
        for (r,c) in cellRowColList:
            self.setCellSymbol(r, c, PlayingBoard.clear)
    
    def __isClear(self, row, col):
        """Returns true if the cell in the given row and column is clear."""
        return self.contents[row][col] == PlayingBoard.clear
    
    def areCellsClear(self, cellRowColList):
        """Returns true if every cell specified by the given list of 
        (row,column) pairs is clear."""
        for (r,c) in cellRowColList:
            if not self.__isClear(r, c):
                return False
        return True

#-----------------------------------------------------------------------------
# PLAYING BOARD TESTS
#-----------------------------------------------------------------------------
def boardSizeTest():
    printTestName()
    board = PlayingBoard()
    verifyTrue("default board width", board.getWidth() == 10)
    verifyTrue("default board height", board.getHeight() == 18)
    print

def boardSetAndIsClearTest():
    printTestName()
    board = PlayingBoard()
    setCellsOfBoard(landscape1, board)
    verifyBoardWithLandscape("board setCellSymbol and areCellsClear test", [], 
                             board, landscape1)
    print
    
def clearLinesTestHelper(testName, landscapeBefore, landscapeAfter, 
                         expectedLineNumbers):
    board = PlayingBoard()
    setCellsOfBoard(landscapeBefore, board)
    clearedLines = board.clearLines()
    verifyBoardWithLandscape(testName, [], board, landscapeAfter)
    clearedLines.sort()
    verifyEqualLists(testName + " results", expectedLineNumbers, clearedLines)


def boardClearLinesTest():
    printTestName()
    clearLinesTestHelper("clear bottom line", landscape3F, landscape3C, [17])
    clearLinesTestHelper("clear four lines", landscape4F, landscape4C, 
                         range(14,18))
    clearLinesTestHelper("clear two lines, separated", landscape5F, landscape5C, 
                         [15,17])
    print
    
def playingBoardTests():
    printTestSetName()
    boardSizeTest()
    boardSetAndIsClearTest()
    boardClearLinesTest()
    print
    
if __name__ == '__main__':
    playingBoardTests()