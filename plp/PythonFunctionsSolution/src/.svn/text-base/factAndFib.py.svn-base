# A factorial warm-up, plus a couple of implementations of Fibonacci.
# by Curt Clifton, March 6, 2008

from doctest import testmod
from time import time

def factorial(n):
    """Recursively calculates the factorial of n.
    
    >>> print factorial(0)
    1
    >>> print factorial(1)
    1
    >>> print factorial(2)
    2
    >>> print factorial(3)
    6
    >>> print factorial(10)
    3628800
    """
    if n == 0:
        return 1
    return n * factorial(n-1)

def fib(n):
    """Recursively calculates the fibonacci function for n.
    
    >>> print fib(0)
    0
    >>> print fib(1)
    1
    >>> print fib(2)
    1
    >>> print fib(3)
    2
    >>> print fib(10)
    55
    """
    if n == 0 or n == 1:
        return n
    return fib(n-1) + fib(n-2)

# Cache to store memoization results for Fibonacci
__fibcache = [0,1]

def reset_fib_cache():
    global __fibcache
    __fibcache = [0,1]

def fib2(n):
    """Recursively calculates the fibonacci function for n using memoization
    
    >>> print fib2(0)
    0
    >>> print fib2(1)
    1
    >>> print fib2(2)
    1
    >>> print fib2(10)
    55
    >>> print fib2(3)
    2
    """
    if len(__fibcache) > n:
        return __fibcache[n]
    result = fib2(n-1) + fib2(n-2)
    # Because the function results are built from the bottom up, we only get to the
    # following line when len(__fibcache) == n
    __fibcache.append(result)
    return result

def time_one_fib(fn, dir=1):
    start_test_size = 10
    end_test_size = 40
    table_heading = "Max n, time (sec)"
    table_row_format = "%5d  %10.6f"
    print table_heading
    for test_size in xrange(start_test_size, end_test_size+1):
        start = time()
        if dir > 0:
            loop_start, loop_end = 0, test_size
        else:
            loop_start, loop_end = test_size, 0
        for i in xrange(loop_start, loop_end, dir):
            fn(i)
        end = time()
        print table_row_format % (test_size, (end - start))
    

def time_fibs():
    print "Going up, non-memoized version:"
    time_one_fib(fib)
    print "Going up, memoized version:"
    time_one_fib(fib2)
    print "Going down, memoized version:"
    reset_fib_cache()
    time_one_fib(fib2, -1)
    
# Timing results for Fibonacci:
#Going up, non-memoized version:
#Max n, time (sec)
#   10    0.000100
#   11    0.000152
#   12    0.000249
#   13    0.000409
#   14    0.000659
#   15    0.001093
#   16    0.001771
#   17    0.002896
#   18    0.004885
#   19    0.008030
#   20    0.013112
#   21    0.021680
#   22    0.036718
#   23    0.056958
#   24    0.088245
#   25    0.144474
#   26    0.229947
#   27    0.364039
#   28    0.575771
#   29    0.932991
#   30    1.504114
#   31    2.451780
#   32    3.933760
#   33    6.482622
#   34   10.372702
#   35   16.874304
#   36   27.981172
#   37   44.988940
#   38   72.855259
#   39  117.951275
#   40  191.975413
#Going up, memoized version:
#Max n, time (sec)
#   10    0.000023
#   11    0.000009
#   12    0.000008
#   13    0.000009
#   14    0.000010
#   15    0.000010
#   16    0.000010
#   17    0.000010
#   18    0.000011
#   19    0.000012
#   20    0.000011
#   21    0.000012
#   22    0.000012
#   23    0.000013
#   24    0.000013
#   25    0.000013
#   26    0.000014
#   27    0.000014
#   28    0.000016
#   29    0.000015
#   30    0.000015
#   31    0.000015
#   32    0.000017
#   33    0.000017
#   34    0.000017
#   35    0.000018
#   36    0.000018
#   37    0.000018
#   38    0.000019
#   39    0.000019
#   40    0.000020
#Going down, memoized version:
#Max n, time (sec)
#   10    0.000034
#   11    0.000008
#   12    0.000009
#   13    0.000009
#   14    0.000009
#   15    0.000010
#   16    0.000011
#   17    0.000011
#   18    0.000013
#   19    0.000011
#   20    0.000011
#   21    0.000013
#   22    0.000012
#   23    0.000012
#   24    0.000013
#   25    0.000014
#   26    0.000014
#   27    0.000016
#   28    0.000015
#   29    0.000016
#   30    0.000016
#   31    0.000016
#   32    0.000017
#   33    0.000016
#   34    0.000018
#   35    0.000017
#   36    0.000019
#   37    0.000020
#   38    0.000020
#   39    0.000020
#   40    0.000019


if __name__ == '__main__':
    #time_fibs()
    testmod()