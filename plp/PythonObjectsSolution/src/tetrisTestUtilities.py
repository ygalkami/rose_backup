# This module includes a variety of helper functions used by modules for
# testing.

# by Matt Boutell and Curt Clifton, 17-19 Jan 2008.

# Standard modules
import sys

countOfFailedTests = 0

landscapeClear = ["          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          ",
                  "          "]

landscape1 = ["          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "x        x",
              "x        x",
              "x        x",
              "x        x",
              "x        x",
              "x  x   xxx",
              "x  xx  xxx"]

# used in parts of Ell and Tee tests.
landscape2 = ["          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "          ",
              "x        x",
              "x        x",
              "x        x",
              "x        x",
              "x  x     x",
              "x  x   xxx",
              "x  xx xxxx"]

# used for testing clearLines
landscape3F = ["          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "x        x",
               "x        x",
               "x        x",
               "x        x",
               "x  x     x",
               "x  x   xxx",
               "xxxxxxxxxx"]

landscape3C = ["          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "x        x",
               "x        x",
               "x        x",
               "x        x",
               "x  x     x",
               "x  x   xxx"]

landscape4F = ["          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "x        x",
               "x        x",
               "x        x",
               "xxxxxxxxxx",
               "xxxxxxxxxx",
               "xxxxxxxxxx",
               "xxxxxxxxxx"]

landscape4C = ["          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "x        x",
               "x        x",
               "x        x"]

landscape5F = ["          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "x        x",
               "x        x",
               "x        x",
               "x        x",
               "xxxxxxxxxx",
               "x  x   xxx",
               "xxxxxxxxxx"]

landscape5C = ["          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "          ",
               "x        x",
               "x        x",
               "x        x",
               "x        x",
               "x  x   xxx"]

#-----------------------------------------------------------------------------
# HELPER FUNCTIONS FOR TESTING
#-----------------------------------------------------------------------------

def resetCountOfFailedTests():
    global countOfFailedTests
    countOfFailedTests = 0
    
def getCountOfFailedTests():
    global countOfFailedTests
    return countOfFailedTests
    
def announcePassed(testName):
    """Helper method prints consistently formatted announcement about a test
    passing."""
    print "passed:", testName

def announceFailed(testName):
    """Helper method prints consistently formatted announcement about a test
    failing."""
    print "FAILED:", testName.upper()

def announceAborting(pieceName):
    print "tests failed."
    print "****ABORTING", pieceName.upper(), "TESTS****"
    print "Code must pass tests on sparse board before the tests with landscape will run correctly."
    
def printBoard(board):
    print "   \\   columns"
    colNumbers = "0123456789"
    print "rows\\" + colNumbers
    for r in range(board.getHeight()):
        nextLine = " %2d |" % (r)
        for c in range(board.getWidth()):
            nextLine += board.getCellSymbol(r,c)
        nextLine += "|"
        print nextLine
    print "     " + colNumbers

def verifyBoardSparse(testName, listOfFilledCells, board):
    verifyBoardWithLandscape(testName, listOfFilledCells, board, landscapeClear)

def verifyBoardWithLandscape(testName, listOfFilledCells, board, landscape):
    global countOfFailedTests # brings the variable above into this "scope"
    for r in range(board.getHeight()):
        for c in range(board.getWidth()):
            if ((r,c) in listOfFilledCells or landscape[r][c] != " ") \
                    and board.areCellsClear([(r,c)]):
                announceFailed(testName.upper())
                print "Cell (%d, %d) clear when it should be filled:" % (r,c)
                printBoard(board) 
                countOfFailedTests += 1
                return
            if not ((r,c) in listOfFilledCells or landscape[r][c] != " ") \
                    and not board.areCellsClear([(r,c)]):
                announceFailed(testName.upper())
                print "Cell (%d, %d) filled when it should be clear:" % (r,c)
                printBoard(board) 
                countOfFailedTests += 1
                return
    announcePassed(testName)

def verifyTrue(testName, booleanResult):
    global countOfFailedTests # brings the variable above into this "scope"
    if not booleanResult:
        announceFailed(testName.upper())
        print "Function should have returned True"
        countOfFailedTests += 1
    else:
        announcePassed(testName)

def verifyFalse(testName, booleanResult):
    global countOfFailedTests # brings the variable above into this "scope"
    if booleanResult:
        announceFailed(testName.upper())
        print "Function should have returned False"
        countOfFailedTests += 1
    else:
        announcePassed(testName)

def verifyEqualLists(testName, expected, actual):
    global countOfFailedTests # brings the variable above into this "scope"
    if not expected == actual:
        announceFailed(testName.upper())
        print "Function should have returned", expected
        countOfFailedTests += 1
    else:
        announcePassed(testName)
    
def printTestSetName():
    """Prints the name of the function that calls it.  Uses some cool
    Python 'foo' to ask the system for the name of the previously
    executing function.  Neat, huh?"""
    testName = sys._getframe(1).f_code.co_name
    borderText = "########"
    lineText = "=" * (len(borderText)*2 + len(testName) + 2)
    print lineText
    print borderText, sys._getframe(1).f_code.co_name, borderText
    print lineText

def printTestName():
    """Prints the name of the function that calls it.  Uses some cool
    Python 'foo' to ask the system for the name of the previously
    executing function.  Neat, huh?"""
    print "--------",sys._getframe(1).f_code.co_name,"--------"

def doMultipleMoves(piece, deltaCol, deltaRow, deltaCW):
    """Manipulates the given piece by sending it:
    deltaRow moveDown commands, then
    deltaCW rotate commands, then
    deltaCol moveLeft or moveRight commands (negative deltaCol for left).
    Note: deltaCW and deltaRow must be non-negative.
    We need to move down first, because pieces can't rotate freely at the top 
    of the board. """
    for i in range(deltaRow):
        piece.moveDown()
    for i in range(deltaCW):
        piece.rotate()
    for i in range(deltaCol):
        # if deltaCol is negative or zero this won't run
        piece.moveRight()
    for i in range(0, deltaCol, -1):
        # if deltaCol is positive or zero this won't run
        piece.moveLeft()

def setCellsOfBoard(landscape, board):
    for r in range(len(landscape)):
        for c in range(len(landscape[r])):
            board.setCellSymbol(r,c,landscape[r][c])

def rotateAndDropHelper(piece, board, rotateCount, filledCellList):
    """Tests drop in one of the orientations by calling rotate the specified
    number of times before dropping, then checking actual vs. given cells filled."""
    doMultipleMoves(piece, 0, 2, rotateCount)
    piece.drop()
    # piece.__class__.__name__ returns a string containing the name of the class
    # to which the instance belongs. This allows use to reuse this 
    # function for all the different classes.
    verifyBoardSparse(piece.__class__.__name__ + \
                        " board after rotate " + str(rotateCount) + " and drop", 
                        filledCellList, board)
    piece.drop()
    verifyBoardSparse(piece.__class__.__name__ + \
                        " board after trying to drop again", 
                        filledCellList, board)

def newPieceTest(piece):
    """Calls each method required of a piece, just to see if they exist."""
    piece.moveLeft()
    piece.moveRight()
    piece.moveDown()
    piece.drop()
    piece.rotate()
    announcePassed(str(piece.__class__.__name__) + 
                     " constructor and method stubs")
