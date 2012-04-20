-- Put your answers to the quiz questions in this file and commit it
-- at the end of class.

-- Answers by David Pick

-- Here's the simple, but slow, version of fib.

import Char

fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

-- Note how this is instantaneous the second time we run it.
testFib = do
    putStrLn ("fib 27 = " ++ (show (fib 27)))



-- Quiz question:
-- upFrom :: Int -> [Int]
upFrom n = n:upFrom (n+1)


-- Quiz question:
-- upAndDownFrom :: Num a => a -> [a]
upAndDownFrom n = upAndDownFrom_help n (n-1)
upAndDownFrom_help x y = x:y:upAndDownFrom_help (x+1) (y-1)




-- Quiz question:
-- onlyPositive :: (Num a, Ord a) => [a] -> [a]
onlyPositive xs = filter (>0) xs




-- Quiz question:
-- fact :: Integer -> Integer
fact n = foldr (*) 1 [1..n]


-- Lazy fib
fastFib n = fibList !! n
	where fibList = 0 : 1 : zipWith (+) fibList (tail fibList)


-- Type synonyms
type BookID = Int
type Title = String
type Author = String

-- Custom data type
data BookInfo = Book BookID Title [Author]

-- Polymorphic custom data type
data Pair a b = Pair a b
		deriving (Show)

-- Find element matching a predicate
findElement :: (a -> Bool) -> [a] -> a
findElement p (x:xs) =
    if p x
    then x
    else findElement p xs

{-
*Main> findElement odd [1..10]
1
*Main> findElement even [1..10]
2
*Main> findElement (>4) [1..10]
5
*Main> findElement (>12) [1..10]
*** Exception: basics.hs:(66,0)-(69,24): Non-exhaustive patterns in function findElement
-}

