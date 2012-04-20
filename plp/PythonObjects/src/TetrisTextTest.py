# This module tests the basic Tetris model, consisting of all pieces (rotation 
# and movement) and the playing board.  It does this by calling test function
# in the individual modules for pieces and the board.

# by Matt Boutell and Curt Clifton, 17-19 Jan 2008.

# Standard modules
import sys

# Test helpers
from tetrisTestUtilities import *

# Tetris specific modules
from PlayingBoard import *
from MrChunky import *
from Bar import *
from Ell import *
from Jay import *
from Tee import *
from RightZig import *
from LeftZag import *

#-----------------------------------------------------------------------------
# RUN ALL THE TESTS
#-----------------------------------------------------------------------------
def textTests():
    """Main test method runs the other tests."""
    resetCountOfFailedTests()
    
    playingBoardTests()
    mrChunkyTests()
    barTests()
    ellTests()
    jayTests()
    teeTests()
    rightZigTests()
    leftZagTests()
    
    # --------------------
    print
    if getCountOfFailedTests() == 0:
        print "Success!  All tests passed!"
    else:
        print "Sorry, %d of the attempted tests failed." % (getCountOfFailedTests())


if __name__ == '__main__':
    textTests()
