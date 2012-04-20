{-
    Haskell makes profs wacky.
-}

import Data.Map (Map, empty, insert, findWithDefault)
import IO (readFile, writeFile)

-- Sample uses of Map functions
m1 = empty
m2 = insert 'x' 10 m1
m3 = insert 'y' 20 m2
v1 = findWithDefault 0 'x' m3
v2 = findWithDefault 0 'y' m3
v3 = findWithDefault 0 'z' m3
m4 = insert 'y' 30 m3
v4 = findWithDefault 0 'y' m4

-- TODO: implement Wacky Prof Quotes read-eval-print loop
type Prof = String
type Date = String
type Quote = String
data DateQuotePair = DQPair Date Quote
      deriving (Show,Read)

repl :: (Map Prof [DateQuotePair]) -> IO ()
repl map = do
    putStrLn "Enter 'a' to add a quote, 'p' to print quotes, or 'q' to quit: "
    input <- getLine
    case input of
        ('a':_) -> addQuote map
        ('p':_) -> printQuotes map
        ('q':_) -> do
                        saveMap map
                        putStrLn "Thanks for playing: "
        _ -> do
                putStrLn "I don't understand"
                repl map

addQuote :: (Map Prof [DateQuotePair]) -> IO ()
addQuote map = do
    putStrLn "Who spaketh the wackiness?"
    prof <- getLine
    putStrLn "When did they speak thusly?"
    date <- getLine
    putStrLn "What sayeth they?"
    quote <- getLine
    profsRecord <- return (findWithDefault [] prof map)
    newMap <- return (insert prof ((DQPair date quote) : profsRecord) map)
    repl newMap

printQuotes :: (Map Prof [DateQuotePair]) -> IO ()
printQuotes map = do
    putStrLn "Whom do your seek?"
    prof <- getLine
    profsRecord <- return (findWithDefault [] prof map)
    case profsRecord of
        [] -> do
            putStrLn (prof ++ " spaketh not wacky.")
            repl map
        qs -> do
            putStrLn (prof ++ "'s record of wackiness:")
            printRecord profsRecord
            repl map

printRecord :: [DateQuotePair] -> IO ()
printRecord [] = putStrLn "\n"
printRecord (dqp:dqps) = do
            putStrLn ("   " ++ (pretty dqp))
            printRecord dqps
        where pretty (DQPair d q) = d ++ ": " ++ q

{- File I/O -}
-- Default file name
wpqFileName = "wpq.txt"

getDatabaseFromDisk :: IO (Map Prof [DateQuotePair])
getDatabaseFromDisk = catch (readAttempt) (\exc -> return empty)
    where readAttempt = 
            do
                contents <- readFile wpqFileName
                let db = ((read contents) :: (Map Prof [DateQuotePair]))
                {- '$!' below forces strict processing of the db
                   argument, rather than non-strict (lazy) processing. 
                   This causes the entire file contents to be loaded
                   into memory, but prevents the problem where Haskell
                   gives a permission error on writing to the file
                   because it has finished lazily reading from the file.
                -}
                return $! db

saveMap :: (Map Prof [DateQuotePair]) -> IO ()
saveMap = (writeFile wpqFileName) . show

{- Start me up. -}
main :: IO ()
main = do
    db <- getDatabaseFromDisk
    repl db
    
