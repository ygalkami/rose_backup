{-
    Some practice using Maybe and fold.
-}

import Data.List (foldl')
import IO (putStrLn,putStr)

{- Here's the definition of the binary tree data type from the previous
HW. -}
data BinaryTree a = ExtNode
                  | IntNode a (BinaryTree a) (BinaryTree a)

-- Takes a pre-order and in-order traversal and builds a tree.
buildTree :: Eq a => [a] -> [a] -> BinaryTree a
buildTree [] [] = ExtNode
buildTree (po:pos) ios =
    let (leftIO, (io:rightIO)) = break (==po) ios
        (leftPO, rightPO) = splitAt (length leftIO) pos
    in IntNode po 
               (buildTree leftPO leftIO)
               (buildTree rightPO rightIO)

{- TODO: Implement a function, depth, that finds the first node whose
value satisfies the predicate in an pre-order traversal of the tree.  It
then returns the depth of that node.  It reutrns Nothing if the node
isn't found.  For example:

  depth odd (buildTree [] []) == Nothing
  depth odd (buildTree [1] [1]) == Just 0
  depth odd (buildTree [2,1] [1,2]) == Just 1
  
  depth odd (buildTree [0,1,2,3] [1,0,3,2]) == Just 1
  depth odd (buildTree [0,4,2,3] [4,0,3,2]) == Just 2
  
  depth (>5) (buildTree [0,4,2,3] [4,0,3,2]) == Nothing
  depth (>0) (buildTree [0,4,2,3] [4,0,3,2]) == Just 1

  depth (==0) (buildTree [0,4,2,3] [4,0,3,2]) == Just 0
  depth (==2) (buildTree [0,4,2,3] [4,0,3,2]) == Just 1
  depth (==3) (buildTree [0,4,2,3] [4,0,3,2]) == Just 2
  depth (==1) (buildTree [0,4,2,3] [4,0,3,2]) == Nothing
  depth (==4) (buildTree [0,4,2,3] [4,0,3,2]) == Just 1

-}
depth :: (a -> Bool) -> (BinaryTree a) -> Maybe Int
depth _ ExtNode = Nothing
depth p (IntNode x left right)
    | p x = Just 0
    | otherwise = let childResults = (depth p left, depth p right)
                  in case childResults of
                        (Nothing, Nothing) -> Nothing
                        (Just i, _)        -> Just (i + 1)
                        (_, Just i)        -> Just (i + 1)

{- TODO: Don't actually change the code, but explain how you could
change your solution to depth to return the depth of the shallowest
matching node. (Put your answer in this comment.)

ANSWER: 

    Change the last two patterns in the case expression to use Nothing
    instead of the wildcard.  Add a fourth case:
    
    (Just lv, Just rv) -> Just 1 + (min lv rv)
-}

{-
TODO: Implement a function, factors, that takes a list of integers and
returns a list of lists, where each sublist contains the factors of the
corresponding value from the original list.  For example:

  factors [10] == [[1,2,5,10]]
  factors [3..9] == [[1,3],[1,2,4],[1,5],[1,2,3,6],[1,7],[1,2,4,8],[1,3,9]]
  factors [] == []

Hints: Try to use library functions (like map, filter, and others) to
your advantage.  Think about helpers with names like factor and
evenlyDivides.  You may find you can simplify to eliminate some of these
helpers once you've worked out the logic.
-}
factors :: (Integral t) => [t] -> [[t]]
factors = map factor

-- factor :: (Integral t) => t -> [t]
factor n = filter ((0==).(n `rem`)) [1..n]

{-
BONUS, use your factors function to create a function, primes, that
generates an infinite list of prime numbers.  Can you do it with a
single line of library functions?  My definition is 59 characters long.
-}
primes :: [Integer]
primes = map last (filter ((2==) . length) (factors [1..]))

{- Consider the library function, intersperse, that takes an element and
a list and returns a new list where every other element is from the
original list or is the new element.  For example:

  intersperse ',' "" == ""
  intersperse ',' "abcd" == "a,b,c,d"

TODO: Implement a recursive (but not tail recursive) version of
intersperse, call it intersperseR
-}
intersperseR :: a -> [a] -> [a]
intersperseR _ [] = []
intersperseR i xs@(x:[]) = xs
intersperseR i (x:xs) = x : i : (intersperseR i xs)

{- TODO: Implement a tail-recursive version of intersperse, call it
intersperseTR -}
intersperseTR ::  a -> [a] -> [a]
intersperseTR i xs = case (reverse (itrHelper [] i xs)) of
                        [] -> []
                        r -> tail r
itrHelper acc i [] = acc
itrHelper acc i (x:xs) = itrHelper (x:i:acc) i xs


{- TOOD: implement a version of intersperse using foldr, call it
intersperseFR -}
intersperseFR :: a -> [a] -> [a]
intersperseFR i xs = case (foldr op [] xs) of
                         [] -> []
                         r -> init r
                     where op x acc = x : i : acc


{- The library function dropWhile takes a predicate function and a list.
It discards elements from the head of the list that match the predicate.
When a non-matching element is found, the remainder of the list,
including that element, is returned. For example:

 dropWhile (< 3) [1,2,3,4,5,1,2,3] == [3,4,5,1,2,3]
 dropWhile (< 9) [1,2,3] == []
 dropWhile (< 0) [1,2,3] == [1,2,3]

TODO: Implement a recursive version of dropWhile, call it dropWhileR.
-}
dropWhileR :: (a -> Bool) -> [a] -> [a]
dropWhileR _ [] = []
dropWhileR p (x:xs) = 
    if p x
    then dropWhileR p xs
    else x:xs

{- TODO: Implement a version of dropWhile using foldl, call it dropWhileFL. -}
dropWhileFL :: (a -> Bool) -> [a] -> [a]
dropWhileFL p = reverse . (foldl' op [])
    where op acc x | (p x) && (null acc) = []
                   | otherwise = x:acc
        
{- Sample derivation:
    dropWhileFL odd [1,4,7]
        == reverse (foldl op [] (1:4:7:[]))
        == reverse (foldl op (op 1 []) (4:7:[]))
        == reverse (foldl op (op 4 (op 1 [])) (7:[]))
        == reverse (foldl op (op 7 (op 4 (op 1 []))) [])
        == reverse (          op 7 (op 4 (op 1 [])))
        == reverse (          op 7 (op 4 []))
        == reverse (          op 7 (4:[]))
        == reverse (          7:4:[])
        == [4,7]
-}
 
{-
    TODO: Could one implement a version of dropWhile using foldr?
    What's the issue with trying to do so? (Put your answers to the
    questions in this comment.)
    
    ANSWER: This would be challenging with foldr.  Technically it's
    possible; see the implementation of foldl using foldr in the book. 
    However, dropWhile needs to accept all elements from the left-most
    matched element to the end of the list.  The the op function in
    foldr is evaluated right-to-left, so its hard to "know" when we've
    seen the left-most matching element.
-}


{- stripPrefix drops the given prefix from a list.  It returns Nothing
if the list did not start with the prefix given, or Just the list after
the prefix, if it does.  For example:

 stripPrefix "foo" "foobar" == Just "bar"
 stripPrefix "foo" "foo" == Just ""
 stripPrefix "foo" "fo" == Nothing
 stripPrefix "foo" "barfoo" == Nothing
 stripPrefix "foo" "barfoobaz" == Nothing

-}
-- NOT ASSIGNED: implement a recursive version of stripPrefix, call it stripPrefixR
stripPrefixR :: Eq a => [a] -> [a] -> Maybe [a]
stripPrefixR [] xs = Just xs
stripPrefixR _  [] = Nothing
stripPrefixR (p:ps) (x:xs)
    | p == x    = stripPrefixR ps xs
    | otherwise = Nothing
    
-- NOT ASSIGNED: implement a version of stripPrefix using foldl, call it stripPrefixFL
stripPrefixFL :: Eq a => [a] -> [a] -> Maybe [a]
stripPrefixFL ps xs = 
    let (prefixRemaining,Just result) = foldl' op (Just ps, Just []) xs
    in case prefixRemaining of (Just []) -> Just (reverse result)
                               _         -> Nothing
    where op acc@(Nothing,_)    _       = acc
          op (Just [], Just res) x      = (Just [], Just (x:res))
          op (Just (p:ps), empty) x 
                            | p == x    = (Just ps, empty)
                            | otherwise = (Nothing, empty)



{- inits takes a list and returns a list of lists.  Each element of the
result is prefix of the original list, beginning with the empty prefix,
then the 1-element prefix, the 2-element prefix, and so on, up to the
original list. For example:

 inits "abc" == ["","a","ab","abc"]
 inits "" == [""]

-}
-- NOT ASSIGNED: implement a tail recursive version of inits, call it initsTR
initsTR :: [a] -> [[a]]
initsTR xs = initsTRHelp [[]] (reverse xs)
initsTRHelp acc [] = acc
initsTRHelp acc (x:xs) = initsTRHelp ([]:(map (x:) acc)) xs

-- NOT ASSIGNED: implement a version of inits using foldr, call it initsFR
initsFR :: [a] -> [[a]]
initsFR xs = foldr op [[]] xs
    where op x acc = []:(map (x:) acc)


{- ----------------------------------------------------------------
                         TESTING FUNCTIONS 
---------------------------------------------------------------- -}

-- TODO: uncomment lines as you implement functions
test = do
    putStrLn "Testing:"
    putStr "Testing depth"
    assertEquals Nothing (depth odd (buildTree [] []) ) 
    assertEquals (Just 0) (depth odd (buildTree [1] [1]))
    assertEquals (Just 1) (depth odd (buildTree [2,1] [1,2]))
    assertEquals (Just 1) (depth odd (buildTree [0,1,2,3] [1,0,3,2]))
    assertEquals (Just 2) (depth odd (buildTree [0,4,2,3] [4,0,3,2]))
    assertEquals (Nothing) (depth (>5) (buildTree [0,4,2,3] [4,0,3,2]))
    assertEquals (Just 1) (depth (>0) (buildTree [0,4,2,3] [4,0,3,2]))
    assertEquals (Just 0) (depth (==0) (buildTree [0,4,2,3] [4,0,3,2]))
    assertEquals (Just 1) (depth (==2) (buildTree [0,4,2,3] [4,0,3,2]))
    assertEquals (Just 2) (depth (==3) (buildTree [0,4,2,3] [4,0,3,2]))
    assertEquals (Nothing) (depth (==1) (buildTree [0,4,2,3] [4,0,3,2]))
    assertEquals (Just 1) (depth (==4) (buildTree [0,4,2,3] [4,0,3,2]))
    putStrLn ""
    putStr "Testing factors"
    assertEquals [[1,2,5,10]] (factors [10])
    assertEquals [[1,3],[1,2,4],[1,5],[1,2,3,6],[1,7],[1,2,4,8],[1,3,9]] (factors [3..9]) 
    assertEquals [] (factors [])
    putStrLn ""
    putStr "BONUS Testing primes"
    assertEquals [2,3,5,7,11,13,17,19,23,29] (take 10 primes) 
    assertEquals 547 (primes !! 100) 
    putStrLn ""
    putStr "Testing intersperseR"
    assertEquals "" (intersperseR ',' "") 
    assertEquals "a,b,c,d" (intersperseR ',' "abcd")
    putStrLn ""
    putStr "Testing intersperseTR"
    assertEquals "" (intersperseTR ',' "")
    assertEquals "a,b,c,d" (intersperseTR ',' "abcd")
    putStrLn ""
    putStr "Testing intersperseFR"
    assertEquals "" (intersperseFR ',' "")
    assertEquals "a,b,c,d" (intersperseFR ',' "abcd")
    putStrLn ""
    putStr "Testing dropWhileR"
    assertEquals [3,4,5,1,2,3] (dropWhileR (< 3) [1,2,3,4,5,1,2,3])
    assertEquals [] (dropWhileR (< 9) [1,2,3])
    assertEquals [1,2,3] (dropWhileR (< 0) [1,2,3])
    putStrLn ""
    putStr "Testing dropWhileFL"
    assertEquals [3,4,5,1,2,3] (dropWhileFL (< 3) [1,2,3,4,5,1,2,3])
    assertEquals [] (dropWhileFL (< 9) [1,2,3])
    assertEquals [1,2,3] (dropWhileFL (< 0) [1,2,3])
    putStrLn ""
    putStr "Testing stripPrefixR"
    assertEquals (Just "bar") (stripPrefixR "foo" "foobar")
    assertEquals (Just "") (stripPrefixR "foo" "foo")
    assertEquals (Nothing) (stripPrefixR "foo" "fo")
    assertEquals (Nothing) (stripPrefixR "foo" "barfoo")
    assertEquals (Nothing) (stripPrefixR "foo" "barfoobaz")
    putStrLn ""
    putStr "Testing stripPrefixFL"
    assertEquals (Just "bar") (stripPrefixFL "foo" "foobar")
    assertEquals (Just "") (stripPrefixFL "foo" "foo")
    assertEquals (Nothing) (stripPrefixFL "foo" "fo")
    assertEquals (Nothing) (stripPrefixFL "foo" "barfoo")
    assertEquals (Nothing) (stripPrefixFL "foo" "barfoobaz")
    putStrLn ""
    putStr "Testing initsTR"
    assertEquals ["","a","ab","abc"] (initsTR "abc")
    assertEquals [""] (initsTR "")
    putStrLn ""
    putStr "Testing initsFR"
    assertEquals ["","a","ab","abc"] (initsFR "abc")
    assertEquals [""] (initsFR "")
    putStrLn ""

    
assertEquals :: (Eq a, Show a) => a -> a -> IO ()
assertEquals exp act
    | exp == act = do 
        putStr "."
        return ()
    | otherwise = do
        putStrLn ("*** Expected " ++ show exp ++ ", got " ++ show act)
        return ()
