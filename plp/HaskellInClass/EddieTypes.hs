{- ----------------------------------------------------------------
    Type and term definitions for a small interpreted language with
    state, called Eddie.
    
    by Curt Clifton, Oct 7, 2009
---------------------------------------------------------------- -}

module EddieTypes (Term(..), Value(..)) where

{- ----------------------------------------------------------------
    A small language for integer arithmetic with variables and
    assignment.
---------------------------------------------------------------- -}
data Term = Const Int
          | Div Term Term
          | Mult Term Term
          | Sum Term Term
          | Set Var Term Term -- like: Var = Term; Term
          | Get Var
    deriving (Eq, Ord)
    
type Var = Char

-- Make terms showable.
instance Show Term where
    show (Const i) = show i
    show (Div left right) = "(" ++ show left ++ "/" ++ show right ++ ")"
    show (Mult left right) = "(" ++ show left ++ "*" ++ show right ++ ")"
    show (Sum left right) = "(" ++ show left ++ "+" ++ show right ++ ")"
    show (Get v) = showVar v
    show (Set v a b) = "(" ++ showVar v ++ "=" ++ show a ++ "; " ++ show b ++ ")"

-- show character without the single quotes
showVar :: Char -> String
showVar = (take 1) . (drop 1) . show

{- ----------------------------------------------------------------
    Use an algebraic data type for values so we can add other sorts of
    values (e.g., booleans) later.
---------------------------------------------------------------- -}
data Value = IntValue Int
    deriving (Eq, Ord)

instance Show Value where
    show (IntValue i) = show i

