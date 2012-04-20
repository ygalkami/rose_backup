# Calculates the one-dimensional Haar wavelet transformation.
# by Curt Clifton, Mar. 5, 2008

from math import *
from zellegraphics import *
from time import sleep
import doctest

def haar(ar):
    """Calculates the Haar wavelet transformation of the given array, whose size must
    be a power of 2.
    
    >>> print haar([8, 5])
    [6.5, 1.5]
    >>> print haar([5, 8])
    [6.5, -1.5]
    >>> print haar([8, 5, 7, 3])
    [5.75, 1.75, 0.75, -0.25]
    >>> print haar([8, 7, 5, 3])
    [5.75, 0.75, 1.75, -0.25]
    >>> print haar(range(8))
    [3.5, -0.5, -1.0, 0.0, -2.0, 0.0, 0.0, 0.0]
    """
    n = log(len(ar), 2)
    if n != int(n):
        raise Exception("Array length, " + str(len(ar)) + ", is not a power of 2")
    return __haar_helper(ar, n)

def __haar_helper(ar, level):
    averages = []
    differences = []
    for i in range(1,len(ar), 2):
        ave = (ar[i-1] + ar[i]) / 2.0
        diff = (ar[i-1] - ar[i]) / 2.0
        averages.append(ave)
        differences.append(diff)
    result = averages + differences
    if level == 1:
        return result
    else:
        return __haar_helper(result, level-1)
    
def __test_haar(ar):
    result = haar(ar)
    maximum = max(ar + result)
    minimum = min(ar + result + [0])
    if len(ar) < 16:
        print "haar(", ar, ") =", result
    win = GraphWin(str(ar), 500,300)
    win.setCoords(0, minimum, len(ar), maximum)
    Line(Point(0,0), Point(len(ar),0)).draw(win)
    p2, q2 = Point(0, ar[0]), Point(0, result[0])
    for i in range(1, len(ar)):
        p1, q1 = p2, q2
        p2, q2 = Point(i, ar[i]), Point(i, result[i])
        p_line, q_line = Line(p1, p2), Line(q1, q2)
        p_line.setOutline('red')
        p_line.draw(win)
        q_line.setOutline('blue')
        q_line.draw(win)
        

if __name__ == '__main__':
    doctest.testmod()
    __test_haar([sin(pi*r**1.35/4096) for r in range(0, 2**12)])
    __test_haar([sin(pi*r/256) for r in range(0, 2048)])
    __test_haar([sin(pi*r/256) + 0.25*cos(pi*r/64) for r in range(0, 2048)])
    while True:
        sleep(0.1)
        pass
    
    
