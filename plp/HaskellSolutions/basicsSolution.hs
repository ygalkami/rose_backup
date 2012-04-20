import IO

-- Infinite list of multiples
multiples n = 0 : map ((+) n) (multiples n)

-- Another implementation using a different Prelude function
alsoMultiples n = iterate ((+) n) 0

test = do
	putStrLn ("take 10 (multiple 5) ==> " ++ (show (take 10 (multiples 5))))
	putStrLn ("take 10 (multiple 3) ==> " ++ (show (take 10 (multiples 3))))
	putStrLn ("take 10 (multiple 67) ==> " ++ (show (take 10 (multiples 67))))
	
