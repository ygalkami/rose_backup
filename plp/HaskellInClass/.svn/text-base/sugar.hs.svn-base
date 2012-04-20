{-
	Desugaring do blocks.
-}

import System.IO
import Data.Char (toUpper,isSpace)


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
