# Calculates the one-dimensional Haar wavelet transformation.
# by David Pick, 9/9/09

# Excellent work. --CCC

import math
import unittest

def haar(ls):
    temp = ls
    for i in range(0, int(math.log(len(ls), 2))):
        temp = calculate(temp, [], [])
    return temp
    
def calculate(ls, avgs, change_coeffs):
    if len(ls) > 0:
        avgs.append((ls[0] + ls[1]) / 2.0)
        change_coeffs.append((ls[0] - ls[1]) / 2.0)
        return calculate(ls[2:], avgs, change_coeffs)
    else:
        return avgs + change_coeffs
        


class TestFunctions(unittest.TestCase):

    def test_haar(self):
        self.assertEqual(haar([8, 7, 5, 3]), [5.75, 0.75, 1.75, -0.25])
        self.assertEqual(haar([8, 5, 7, 3]), [5.75, 1.75, 0.75, -0.25])
        self.assertEqual(haar([8, 5]), [6.5, 1.5])
        self.assertEqual(haar([5, 8]), [6.5, -1.5])


unittest.main()
        