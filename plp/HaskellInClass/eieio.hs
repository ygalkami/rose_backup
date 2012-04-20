{-
    Old McDonald had a farm, E-I-E-I-O.
    And this farm he had a pure, functional, lazy, statically typed
        programming language, H-A-S-K-E-L-L.
        
    (Come on!  Everybody sing!)
-}

import System.IO
import Data.Char (toUpper,isSpace)

{- ---------------------------------------------------------------- -}

ex1 = do
    putStr "WHAT is your name? "
    inpStr1 <- getLine
    putStr "WHAT is your quest? "
    inpStr2 <- getLine
    putStrLn ("Good luck with that, " ++ inpStr1 ++ "!")

{- ---------------------------------------------------------------- -}

transform :: String -> String
transform s = s ++ " is a lovely shade for a coconut."

ex2 :: IO ()
ex2 = do
    putStr "WHAT is your favorite color? "
    inpStr <- getLine
    let outStr = transform inpStr
    putStrLn outStr

{- ---------------------------------------------------------------- -}

fileTransform :: IO ()
fileTransform = do
    inHandle <- openFile "eieio.hs" ReadMode -- reading ourselves :-)
    outHandle <- openFile "shout.txt" WriteMode
    c <- mainLoop reverse inHandle outHandle 0
--	putStrLn ("Processed " ++ (show c) ++ " lines")
    hClose inHandle
    hClose outHandle

mainLoop :: (String -> String) -> Handle -> Handle -> Int -> IO Int
mainLoop f inh outh count = do
    atEOF <- hIsEOF inh
    if atEOF
        then let r = return count  -- have to indent then and else under the if in a do
			in r
        else do line <- hGetLine inh
                hPutStrLn outh (f line)
                mainLoop f inh outh (count + 1)

{- ---------------------------------------------------------------- -}

betterFileTransform :: IO ()
betterFileTransform = do
    inHandle <- openFile "eieio.hs" ReadMode -- reading ourselves :-)
    outHandle <- openFile "shout.txt" WriteMode
    inContents <- hGetContents inHandle
    let result = processData inContents
    hPutStr outHandle result
    hClose inHandle -- Don't close until we're done with inContents!
    hClose outHandle

processData = unlines . (map reverse) . lines

{- ---------------------------------------------------------------- -}

bestFileTransform :: IO ()
bestFileTransform = do
    inContents <- readFile "eieio.hs"
    writeFile "shout.txt" (map toUpper inContents)


{- ----------------------------------------------------------------
    IO with Helpers
---------------------------------------------------------------- -}

{- TODO: Implement an I/O action, wordProcessor :: IO (), that prompts
the user for a series of words and prints a count of the words entered,
along with the longest and shortest words.  For example:

    ghci> wordProcessor 
    Enter a word, or just return to quit: dog
    Enter a word, or just return to quit: cat
    Enter a word, or just return to quit: whale
    Enter a word, or just return to quit: raptor
    Enter a word, or just return to quit: 
    Number of words: 4
    Longest word: raptor
    Shortest word: cat

The pure helper functions longest and shortest are provided.
-}
-- wordProcessor :: IO ()

-- wpHelper :: String -> String -> Int -> IO (String, String, Int)

longest :: String -> String -> String
longest x y | (length x) > (length y) = x
            | otherwise = y
            
shortest :: String -> String -> String
shortest x y | (length x) < (length y) = x
             | otherwise = y

wordProcessor :: IO ()
wordProcessor = do
	(long, short, count) <- wpHelper "" "" 0
	putStrLn (show count)
	putStrLn long
	putStrLn short

wpHelper :: String -> String -> Int -> IO (String, String, Int)
wpHelper long short count = do
	putStr "Enter: "
	l <- getLine
	let w = takeWhile (not . isSpace) l
	case w of 
		"" -> return (long, short, count)
		_ -> if (count == 0) 
				then wpHelper w w 1
				else wpHelper (longest long w) (shortest short w) (count + 1)
    

{- ----------------------------------------------------------------
    Monads!
---------------------------------------------------------------- -}

strToMessage :: String -> String
strToMessage s = "Message for you, sir: " ++ s

putMessage :: String -> IO ()
putMessage = putStrLn . strToMessage

strings = ["Lancelot", "Robin", "Galahad"]

ex3 = do
    putMessage "Start me up"
    mapM_ putMessage strings
    putMessage "That's all folks!"

ex4 = do
    putStr "What is your name? "
    inpStr <- getLine
    putStrLn ("Bugger off, " ++ inpStr ++ "!")
   
-- ex4 desugared:
ex5 =
    putStr "What is your name? " >>
    getLine >>=
        (\inpStr -> putStrLn ("Bugger off, " ++ inpStr ++ "!"))

-- ex4, even less sweet:
ex6 =
    putStr "What is your name? " >>=
        (\_ -> getLine >>=
                 (\inpStr -> putStrLn ("Bugger off, " ++ inpStr ++ "!")))
