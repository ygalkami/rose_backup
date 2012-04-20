{- 
    I think that I shall never see 
       a poem as lovely as a tree.
       
                           Joyce Kilmer
-}
-- Points: 4.5 / 4.5

import IO
import Char

{- 
    An external node, ExtNode, is a "null node".  A leaf node is 
    represented as an internal node, IntNode, with two external nodes
    as children.
-} 
data BinaryTree a = 
        ExtNode
      | IntNode a (BinaryTree a) (BinaryTree a)
    deriving (Eq)

-- Show instance
instance (Show a) => Show (BinaryTree a) where
    show ExtNode = "*"
    show (IntNode x left right) = 
        let leftStr = show left
            rightStr = show right
            elem = show x
        in
            elem ++ "\n" ++ indent leftStr ++ "\n" ++ indent rightStr
        where
            indent = reverse . tail . reverse . unlines . (map ("  " ++)) . lines

-- Takes a pre-order and in-order traversal and builds a tree.
buildTree :: Eq a => [a] -> [a] -> BinaryTree a
buildTree [] [] = ExtNode
buildTree (po:pos) ios =
    let (leftIO, (io:rightIO)) = break (==po) ios
        (leftPO, rightPO) = splitAt (length leftIO) pos
    in IntNode po 
               (buildTree leftPO leftIO)
               (buildTree rightPO rightIO)

-- TODO: Implement Traversals
-- preorder :: BinaryTree a -> [a]
preorder ExtNode = []
preorder (IntNode a left right) = [a] ++ preorder left ++ preorder right

-- inorder :: BinaryTree a -> [a]
inorder ExtNode = []
inorder (IntNode a left right) = inorder left ++ [a] ++ inorder right

-- postorder :: BinaryTree a -> [a]
postorder ExtNode = []
postorder (IntNode a left right) = postorder left ++ postorder right ++ [a]

-- BONUS: 
-- levelorder :: BinaryTree a -> [a]


-- Testing trees
-- TODO: uncomment test code
test :: IO ()
test = do
    et <- return (buildTree "" "")
    putStrLn "Testing the empty tree"
    assertEquals "" (preorder et)
    assertEquals "" (inorder et)
    assertEquals "" (postorder et)
--    assertEquals "" (levelorder et)
    t <- return (buildTree "ABCD" "CBAD")
    putStrLn ("Testing tree " ++ (show t))
    assertEquals "ABCD" (preorder t)
    assertEquals "CBAD" (inorder t)
    assertEquals "CBDA" (postorder t)
--    assertEquals "ABDC" (levelorder t)
    t2 <- return (buildTree "THEQUICKLAZYFOX" "QIUCEHLAZKFYTXO")
    putStrLn ("Testing tree " ++ (show t2))
    assertEquals "THEQUICKLAZYFOX" (preorder t2)
    assertEquals "QIUCEHLAZKFYTXO" (inorder t2)
    assertEquals "ICUQEZALFYKHXOT" (postorder t2)
--    assertEquals "THOEKXQLYUAFICZ" (levelorder t2)
    return ()

assertEquals :: (Eq a, Show a) => a -> a -> IO ()
assertEquals exp act
    | exp == act = return ()
    | otherwise = do
        putStrLn ("*** Expected " ++ show exp ++ ", got " ++ show act)
        return ()
