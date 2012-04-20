{- ----------------------------------------------------------------
    Evaluator for Eddie.
    
    by Curt Clifton, Oct 7, 2009
---------------------------------------------------------------- -}

module EddieEval (eval) where

import EddieTypes (Term(..), Value(..))
import EddieParse (unsafeParseEddie)
import Data.Map (fromList, empty, Map, insert, findWithDefault)

-- "rename" parser to something simpler:
parse :: String -> Term
parse = unsafeParseEddie

{- ----------------------------------------------------------------
    A basic evaluator that just ignores assignment and treats varrefs as
    the constant 1.
---------------------------------------------------------------- -}

eval :: Term -> Value
eval (Const v) = IntValue v
eval (Div lt rt) = evalBinA div lt rt
eval (Mult lt rt) = evalBinA (*) lt rt
eval (Sum lt rt) = evalBinA (+) lt rt
eval (Get x) = IntValue 1 -- bzzt, varrefs aren't implemented correctly
eval (Set x t t') = (eval t') -- bzzt, ignores assignment

evalBinA op lt rt = let (IntValue lv) = (eval lt)
                        (IntValue rv) = (eval rt)
                    in IntValue (lv `op` rv)

{- ----------------------------------------------------------------
    The state monad.
    
    Allows sequencing of operations (e.g., assignment before evaluating
    term bodies).  Passes the store along between operations.
---------------------------------------------------------------- -}

-- Normally the constructor below would also be named MS, but for a first look
-- at making our own monad instance, it's best to keep them distinct.
data MS v = MakeMS (State -> (v, State))
-- State is just an instruction counter initially.  We'll update it to be
-- a variable store.
type State = Int

-- TODO: make MS an instance of Monad.

{- ----------------------------------------------------------------
    Stateful monadic interpreter.
---------------------------------------------------------------- -}

-- TODO: implement a stateful interpreter
evalS :: Term -> MS Value
evalS (Const n) = undefined

-- Helper function to evaluate terms using a given initial state:
evalFrom :: State -> Term -> (Value, State)
evalFrom initialState t =
    let (MakeMS f) = evalS t
    in f initialState
