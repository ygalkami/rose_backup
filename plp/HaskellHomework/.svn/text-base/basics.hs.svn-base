-- Answers by David Pick
-- Points: 5.5 / 5.5
--multiples :: Int -> [Int]
multiples n = map (+ n) (-n : multiples n)

test = do
    putStrLn "Multiples"
    putStrLn ("take 5 (multiples 5) = " ++ show (take 5 (multiples 5)))
    putStrLn ("take 5 (multiples 3) = " ++ show (take 5 (multiples 3)))
