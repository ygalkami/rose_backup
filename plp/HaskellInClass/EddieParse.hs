{- ----------------------------------------------------------------
    Module for parsing strings into terms in the Eddie language.
    
    Uses the Parsec module (see ch. 16, Real World Haskell).  It probably uses
    the module poorly, but it's my first attempt at Parsec.
    
    by Curt Clifton, Oct 7, 2009.
---------------------------------------------------------------- -}

module EddieParse (parseEddie,unsafeParseEddie) where

import Text.ParserCombinators.Parsec
import EddieTypes (Term(..))
import qualified Data.Map as Map
import Data.Char (isSpace)

{- ----------------------------------------------------------------
    Define the non-terminals, using the standard parsing technique of
    recursing to lowest precedence operators first and highest last.
---------------------------------------------------------------- -}
eddieTerm = eddiePlus
eddiePlus = leftAssocBinOp eddieMD (Map.fromList [('+',Sum)])
eddieMD = leftAssocBinOp eddieBase (Map.fromList [('*',Mult), ('/',Div)])

eddieBase = 
    eddieConst <|> eddieVarrefOrAssn <|> eddieParens

eddieConst = do
    d <- many1 digit
    return (Const (read d))
    
eddieVarrefOrAssn = do
    d <- letter
    isAssn <- optionMaybe (char '=')
    case isAssn of
        Nothing -> return (Get d)
        _ -> do val <- eddieTerm
                char ';'
                next <- eddieTerm
                return (Set d val next)
    
eddieParens = between (char '(') (char ')') eddieTerm

{- ----------------------------------------------------------------
    Uses the standard technique of eliminating immediate left recursion. 
    See http://en.wikipedia.org/wiki/Left_recursion or take CSSE 404.
---------------------------------------------------------------- -}
leftAssocBinOp :: GenParser Char st Term -> Map.Map Char (Term -> Term -> Term)
                    -> GenParser Char st Term
leftAssocBinOp higherPrecParser m = 
    do l <- higherPrecParser
       leftAssocBinOp' l
            where leftAssocBinOp' left = 
                    do op <- optionMaybe (oneOf (Map.keys m))
                       case op of
                            Nothing -> return left
                            (Just c) -> let termConstr = Map.findWithDefault (error "shouldn't happen") c m
                                        in do right <- higherPrecParser
                                              leftAssocBinOp'
                                                    (termConstr left right)
                
{- ----------------------------------------------------------------
    Some utility functions for invoking the parser on strings.
---------------------------------------------------------------- -}
parseEddie :: String -> Either ParseError Term
parseEddie = (parse eddieTerm "console") . (filter (not . isSpace))

unsafeParseEddie :: String -> Term
unsafeParseEddie s = case (parseEddie s) of
                        Left e -> error (show e)
                        Right t -> t

{- ----------------------------------------------------------------
    Test code.
---------------------------------------------------------------- -}
assertEqual :: String -> String -> IO ()
assertEqual expected actual = do
    if (expected == actual)
        then putStr "."
        else putStrLn $ " expected: " ++ expected ++ ", actual: " ++ actual
        
tests = [("1", "1"),
         ("a", "a"),
         ("(1+2)", "1+2"),
         ("(1+2)", "1 + 2"),
         ("(a/b)", "a/b"),
         ("(1*b)", "1*b"),
         ("(1*b)", "((1)*b)"),
         ("((1/2)*3)", "1/2*3"),
         ("(1/(2*3))", "1/(2*3)"),
         ("((1+(2*3))+4)", "1+2*3+4"),
         ("(((1+2)*3)+4)", "(1+2)*3+4"),
         ("((1+2)*(3+4))", "(1+2)*(3+4)"),
         ("(x=1; (x+2))","x=1;x+2"),
         ("(x=1; (x=(x+2); x))","x=1;x=x+2;x")
        ]

test = do mapM_ (uncurry assertEqual) (map f tests)
          putStrLn ""
            where f (e,arg) = (e, show . unsafeParseEddie $ arg)
