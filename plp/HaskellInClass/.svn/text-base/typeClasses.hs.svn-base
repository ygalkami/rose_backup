{- Fun with typeclasses. -}

{- The following is a compiler pragma that tells ghc to allow type
synonyms in typeclass instances: -}
{-# LANGUAGE TypeSynonymInstances #-}

import Data.Char (isSpace)

class MyEq a where
    isEqual :: a -> a -> Bool
    

instance MyEq String where
    isEqual "" "" = True
    isEqual "" _  = False
    isEqual _  "" = False
    isEqual (c:cs) (c':cs') =
        (c == c') && isEqual cs cs'


class MyEq2 a where
    isEqual2 :: a -> a -> Bool
    isEqual2 x y = 
        not (isNotEqual2 x y)
    
    isNotEqual2 :: a -> a -> Bool
    isNotEqual2 x y = 
        not (isEqual2 x y)

instance MyEq2 String where
-- TODO: What happens if we comment out the function declarations here?
    isEqual2 "" "" = True
    isEqual2 "" _  = False
    isEqual2 _  "" = False
    isEqual2 (c:cs) (c':cs') =
        (c == c') && isEqual2 cs cs'


data Color = Red | Yellow | Blue
-- TODO:
    deriving (Read, Show, Eq, Ord, Enum)
--instance Show Color where
--	show Red = "Crimson"
--	show Blue = "Periwinkle"
--	show Yellow = "Lemon"

    
{- TODO: Make Color an instance of Show.  For example:

    ghci> show Red
    "Crimson"
    ghci> show Blue
    "Periwinkle"
    ghci> show Yellow
    "Lemon"
-}

{- Read typeclass -}

-- Implementing read is a bit more involved (see RWH, p. 142):
--instance Read Color where
--    readsPrec _ input =
--        tryParse nameColorAList
--        where nameColorAList = [("Red", Red), ("Yellow", Yellow), ("Blue", Blue)]
--              trimmedInput = dropWhile isSpace input
--              tryParse [] = [] -- no matches, so failed
--              tryParse ((name, color):ncs) =
--				  if (take (length name) trimmedInput) == name
--                  then [(color, drop (length name) trimmedInput)]
--                  else tryParse ncs


-- TODO: can you modify the instance definition of Read for Color above
-- to handle spaces?


{- Another way to make a new type of our own. -}
newtype UserID = UserID Int
    deriving (Eq, Ord, Show)


