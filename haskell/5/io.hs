module Demo where
import Control.Monad


main = do
    putStrLn "What is your name?"
    name <- getLine
    putStrLn $ "Nice to meet you, " ++ name ++ "!"

main' :: IO ()
main' = do
    putStrLn "What is your name?"
    putStr "Name: "
    name <- getLine
    if (name == "") then
        main'
    else
        putStrLn $ "Hi, " ++ name ++ "!"


{-
    newtype IO a = RealWorld -> (RealWorld, a)

    return :: a -> IO a
    (>>=) :: a -> (a -> IO b) -> IO b

    instance Monad IO where
        return a = \w -> (w,a)
        (>>=) m k = \w -> case m w of (w',a) -> k a w'

-}

getLine' :: IO String
getLine' = do
    c <- getChar
    if c == '\n' then
        return []
    else do
        cs <- getLine'
        return (c:cs)

putStr' :: String -> IO ()
putStr' [] = return ()
putStr' (x:xs) = putChar x >> putStr' xs


putStr'' :: String -> IO ()
putStr'' = sequence_ . map putChar


putStr''' :: String -> IO ()
putStr''' = mapM_ putChar