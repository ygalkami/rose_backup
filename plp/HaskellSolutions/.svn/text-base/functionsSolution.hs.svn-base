-- Imports the IO library for printing
import IO

-- Factorial example
fact 0 = 1
fact n = n * fact(n-1)

-- DEFINE YOUR FUNCTIONS HERE

-- Fibonacci function, the slow way
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2)

-- Fibonacci function, the fast way
fastFib n = fst (fibPair n)

fibPair 0 = (0, 0)
fibPair 1 = (1, 0)
fibPair n = fibPairHelper (fibPair (n-1))

fibPairHelper (n, m) = (n+m, n)

-- Generates the first n items of the given list
firstN 0 xs = []
firstN n [] = []
firstN n (x:xs) = x : (firstN (n-1) xs)

-- Haar wavelet
haar xs = haarLevelN (logBase 2 (fromIntegral (length xs))) xs
-- haar xs = haarLevelN (logBase 2 (length xs)) xs

haarLevelN 0 xs = xs
haarLevelN n xs = haarLevelN (n-1) (haarJoinPair (haarOneStep xs [] []))

haarJoinPair (aves, coefs) = reverse(aves) ++ reverse(coefs)

haarOneStep (x1:x2:[]) aves coefs = ((ave x1 x2):aves, (coef x1 x2):coefs)
haarOneStep (x1:x2:xs) aves coefs = 
    haarOneStep xs ((ave x1 x2):aves) ((coef x1 x2):coefs)

ave x1 x2 = (x1 + x2)/2
coef x1 x2 = (x1 - x2)/2


-- Defines the no-argument test function to run the tests, you
-- still need to invoke it in the interpreter.  You'll need to 
-- comment out lines below for functions that you haven't yet 
-- implemented.
test = do
    putStrLn "Factorial"
    putStrLn ("fact 5 = " ++ show (fact 5))
    putStrLn "Fibonacci, the slow way"
    putStrLn ("fibonacci 0 = " ++ show (fibonacci 0))
    putStrLn ("fibonacci 1 = " ++ show (fibonacci 1))
    putStrLn ("fibonacci 10 = " ++ show (fibonacci 10))
    putStrLn ("fibonacci 20 = " ++ show (fibonacci 20))
    putStrLn ("fibonacci 25 = " ++ show (fibonacci 25))
    putStrLn "Fibonacci, the fast way"
    putStrLn ("fastFib 0 = " ++ show (fastFib 0))
    putStrLn ("fastFib 1 = " ++ show (fastFib 1))
    putStrLn ("fastFib 10 = " ++ show (fastFib 10))
    putStrLn ("fastFib 20 = " ++ show (fastFib 20))
    putStrLn ("fastFib 25 = " ++ show (fastFib 25))
    putStrLn "firstN"
    putStrLn ("firstN 10 [] = " ++ show(firstN 10 []::[Int]))
    putStrLn ("firstN 10 [1] = " ++ show(firstN 10 [1]))
    putStrLn ("firstN 10 \"cat\" = " ++ show(firstN 10 "cat"))
    putStrLn ("firstN 2 \"cat\" = " ++ show(firstN 2 "cat"))
    putStrLn ("firstN 0 \"cat\" = " ++ show(firstN 0 "cat"))
    putStrLn ("firstN 0 [] = " ++ show(firstN 0 []::[Int]))
    putStrLn "Haar wavelet"
    putStrLn ("haar [8,5] = " ++ show(haar [8,5]))
    putStrLn ("haar [5,8] = " ++ show(haar [5,8]))
    putStrLn ("haar [8,5,7,3] = " ++ show(haar [8,5,7,3]))
    putStrLn ("haar [8,7,5,3] = " ++ show(haar [8,7,5,3]))
    putStrLn ("haar " ++ show [0..7] ++ " = " ++ show(haar [0..7]))

-- putStrLn is the function to display a string on a line
-- The '++' operator does list, or in this case string, concatenation
-- The show function converts values to strings.
