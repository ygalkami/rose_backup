{-
    In-class examples for Haskell Style.
-}

import Data.Char (ord)
import Data.Bits (shiftL, (.&.), (.|.))

-- ----------------------------------------------------------------
-- RECURSIVE DATA TYPES
{- 
    An external node, ExtNode, is a "null node".  A leaf node is 
    represented as an internal node, IntNode, with two binary trees
    as children.
-} 
data BinaryTree a = 
        ExtNode
      | IntNode a (BinaryTree a) (BinaryTree a)
    deriving Show

-- Takes a pre-order and in-order traversal and builds a tree.
buildTree :: String -> String -> BinaryTree Char
buildTree [] [] = ExtNode
buildTree (po:pos) ios =
    let (leftIO, (io:rightIO)) = break (==po) ios
        (leftPO, rightPO) = splitAt (length leftIO) pos
    in IntNode po (buildTree leftPO leftIO) (buildTree rightPO rightIO)

-- Counts the internal nodes
size :: BinaryTree a -> Int
size ExtNode = 0
size (IntNode x left right) = 1 + size left + size right

-- Finds the height of the tree
-- TODO
--height :: BinaryTree a -> Int
height ExtNode = -1
height (IntNode _ left right) = 1 + max (height left) (height right)



-- Infix tree constructors
node :: a -> BinaryTree a
node x = IntNode x ExtNode ExtNode

(<-*) :: BinaryTree a -> BinaryTree a -> BinaryTree a
_ <-* ExtNode             = error "Can't add a left child to an external node"
t <-* (IntNode x _ right) = IntNode x t right

(*->) :: BinaryTree a -> BinaryTree a -> BinaryTree a
ExtNode *-> _ = error "Can't add a right child to an external node"
(IntNode x left _) *-> t = IntNode x left t

-- TODO: implement
-- (*->) :: BinaryTree a -> BinaryTree a -> BinaryTree a





{- Examples:
    *Main> node 1
    IntNode 1 ExtNode ExtNode
    *Main> (node 2) <-* (node 1) *-> (node 3)
    IntNode 1 (IntNode 2 ExtNode ExtNode) (IntNode 3 ExtNode ExtNode)
-}
-- ----------------------------------------------------------------
-- RECORD SYNTAX

type CustomerID = Int
type Address = [String]

data Customer = Customer {
        customerId      :: CustomerID,
        customerName    :: String,
        customerAddress :: Address
    } deriving (Show)

{-
    Example:

    *Main> let c = Customer 123 "Curt" ["Raptor Ranch", "213 Python Way", "Haskell, IN 47999"]
    *Main> customerAddress c
    ["Raptor Ranch","213 Python Way","Haskell, IN 47999"]
    
    *Main> :m +System.Time
    *Main System.Time> :browse System.Time
-}

-- ----------------------------------------------------------------
-- ADLER-32 EXAMPLE
{-
    Adler-32 checksum implemented in a variety of ways, from RWH, ch. 4.
    
    Calculates two 16-bit checksums and returns their 32-bit
    concatenation. The first checksum is the sum of all input bytes,
    plus 1. The second checksum is the running total of all the
    intermediate values of the first checksum.  In both cases the sums
    are calculated modulo 65521
-}
base = 65521

-- Here's a basic tail-recursive implementation
adler32 :: String -> Int
adler32 xs = helper 1 0 xs
    where helper chSum1 chSum2 (x:xs) = 
                    let chSum1' = (chSum1 + (ord x .&. 0xff)) `mod` base
                        chSum2' = (chSum1' + chSum2) `mod` base
                    in helper chSum1' chSum2' xs
          helper chSum1 chSum2 _ = (chSum2 `shiftL` 16) .|. chSum1


-- Refactor to use a single accumulator data structure, a tuple.
-- This is just to help us recognize a pattern later on.
adler32_v2 :: String -> Int
adler32_v2 xs = helper (1,0) xs
    where helper (chSum1,chSum2) (x:xs) = 
                    let chSum1' = (chSum1 + (ord x .&. 0xff)) `mod` base
                        chSum2' = (chSum1' + chSum2) `mod` base
                    in helper (chSum1',chSum2') xs
          helper (chSum1,chSum2) _ = (chSum2 `shiftL` 16) .|. chSum1

-- Here for reference.  Defined in Data.List.
-- foldl :: (a -> b -> a) -> a -> [b] -> a
-- foldl op acc (x:xs) = foldl op (op acc x) xs
-- foldl _  acc _      = acc

-- TODO: Implement sumAll using foldl




adler32_v3 :: String -> Int
adler32_v3 xs = let (chSum1,chSum2) = foldl procByte (1,0) xs
                in (chSum2 `shiftL` 16) .|. chSum1
    where procByte (chSum1,chSum2) x = 
            let chSum1' = (chSum1 + (ord x .&. 0xff))
            in (chSum1' `mod` base, (chSum1' + chSum2) `mod` base)

-- TODO: Implement sumAll using foldr






-- Here for reference.  Defined in Data.List:
-- foldr :: (a -> b -> b) -> b -> [a] -> b
-- foldr op acc (x:xs) = op x (foldr op acc xs)
-- foldr _  acc []     = acc

-- filter using foldr
myFilter :: (c -> Bool) -> [c] -> [c]
myFilter pred xs = foldr op [] xs
    where op x acc | pred x    = x : acc
                   | otherwise = acc

-- append using foldr
append :: [c] -> [c] -> [c]
append xs ys = foldr (:) ys xs

-- map using foldr
myMap :: (c -> d) -> [c] -> [d]
myMap f xs = foldr op [] xs
    where op x acc = (f x) : acc -- GOOD: foldr version leaves right end alone
{-
    Matching the types in myMap to those in foldr:
    a == c
    b == [d]
    f :: c -> d
    xs :: [c]
    op :: a -> b -> a == c -> [d] -> [d]
-}
    
-- map using foldl
myMapBad :: (c -> d) -> [c] -> [d]
myMapBad f xs = foldl op [] xs
    where op acc x = acc ++ [f x] -- BAD: foldl version builds list from right

{-
    Matching the types in myMapBad to those in foldl:
    a == [d]
    b == c
    op :: [d] -> c -> [d]
-}

{- Examples:
    > take 10 (myMap (^2) [1..10000000])
    [1,4,9,16,25,36,49,64,81,100]
    > take 10 (myMapBad (^2) [1..10000000])
    *** Exception: stack overflow
    > last (myMap (^2) [1..10000000])
    100000000000000
    > last (myMapBad (^2) [1..10000000])
    *** Exception: stack overflow
-}

