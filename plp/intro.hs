add1 n = n + 1

simple x y z = x * (y + z)

-- recursion and pattern matching

fact 0 = 1
fact n = n * (fact (n - 1))

-- more pattern matching
sumList [] = 0
sumList (x : xs) = x + sumList xs

prodList [] = 1
prodList (x : xs) = x * prodList xs

atLast (x : []) = x