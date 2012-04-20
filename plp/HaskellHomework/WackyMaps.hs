{-
    Haskell makes profs wacky.
-}

import Data.Map (Map, empty, insert, findWithDefault)
import System.IO

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

data DateQuotePair = DQPair Date Quote
    deriving (Show,Read)

type Quote = String
type Prof = String
type Date = String

main :: IO ()
main = do
	db <- getDatabaseFromDisk
	repl db

repl :: (Map String [DateQuotePair]) -> IO ()
repl quotes = do
	putStr "Would you like to add a new quote (1) or view old quotes (2) or quit (3)? "
	choice <- getLine
	case choice of
		"1" -> add_new quotes
		"2" -> my_lookup quotes
		_ -> writeDatabaseToDisk quotes

my_lookup :: (Map String [DateQuotePair]) -> IO ()
my_lookup quotes = do
	putStr "Whose quotes would you like to see? "
	name <- getLine
	displayQuotes name (findWithDefault [] name quotes)
	repl quotes

displayQuotes :: String -> [DateQuotePair] -> IO ()
displayQuotes name [] = return ()
displayQuotes name ((DQPair date quote) : quoteList) = do
        putStrLn (name ++ " said: " ++ quote ++ " - on - " ++ date)
        displayQuotes name quoteList


add_new quotes = do
	putStr "Who said the quote? "
	name <- getLine
	putStr "What did they say? "
	quote <- getLine
	putStr "When did they say it (dd/mm/yy)? "
	date <- getLine
	let found = (findWithDefault [] name quotes)
	repl (insert name (found ++ [(DQPair date quote)]) quotes)

wpqFileName = "wpq.txt"

getDatabaseFromDisk :: IO (Map Prof [DateQuotePair])
getDatabaseFromDisk = catch (readAttempt) (\exc -> return empty)
    where readAttempt = 
            do
                contents <- readFile wpqFileName
                return ((read contents) :: (Map Prof [DateQuotePair]))

writeDatabaseToDisk :: (Map String [DateQuotePair]) -> IO ()
writeDatabaseToDisk quotes = writeFile wpqFileName (show quotes)
